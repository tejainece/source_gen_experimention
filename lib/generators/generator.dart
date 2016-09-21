library test_source_gen.generators.api_class;

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_experimentation/annotations/annotations.dart';
import 'package:source_gen/src/utils.dart';
import 'package:source_gen/src/annotation.dart';

class ApiClassAnnotationGenerator extends GeneratorForAnnotation<Group> {
  const ApiClassAnnotationGenerator();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, Group annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      var friendlyName = friendlyNameForElement(element);
      throw new InvalidGenerationSourceError(
          'Generator cannot target `$friendlyName`.',
          todo: 'Remove the Group annotation from `$friendlyName`.');
    }

    var classElement = element as ClassElement;
    var className = classElement.name;

    Writer lWriter = new Writer(className);

    classElement.methods.forEach((MethodElement aField) {
      var matchingAnnotations =
          aField.metadata.where((md) => matchAnnotation(Route, md)).toList();

      if (matchingAnnotations.isEmpty) {
        return;
      } else if (matchingAnnotations.length > 1) {
        throw 'cannot have more than one matching annotation';
      }

      var annotationInstance =
          instantiateAnnotation(matchingAnnotations.single) as Route;

      if (matchingAnnotations.length > 1) {
        throw 'cannot instantiate annotation';
      }

      lWriter.addRoute(new RouteMethod(annotationInstance, aField));
    });

    return lWriter.getCode();
  }

  String toString() => 'Group';
}

class RouteMethod {
  RouteMethod(this.route, this.metadata);

  final Route route;

  final MethodElement metadata;

  String get name => "_route${metadata.displayName}";
}

/// Writes the mixin for a given Router.Group
class Writer {
  StringBuffer _buffer = new StringBuffer();

  Writer(this.className) {}

  final String className;

  List<RouteMethod> _routes = <RouteMethod>[];

  void addRoute(RouteMethod aRoute) {
    _routes.add(aRoute);
  }

  void _dumpRouteMethodSignature(RouteMethod aRoute) {
    //TODO _buffer.write(aRoute.metadata.displayName);
  }

  void _dumpRouteMethodInfo(RouteMethod aRoute) {
    _buffer.write("const RouteInfo ${aRoute.name}");
    _buffer.write(
        " = const RouteInfo('${aRoute.route.urlTemplate}', methods: const <String>[");
    aRoute.route.methods.forEach((String aMethod) {
      _buffer.writeln("'${aMethod}', ");
    });
    _buffer.writeln("]);");
  }

  void _dumpHandler() {
    _buffer.writeln("Future<Null> handleRequest(HttpRequest request) async {");

    _routes.forEach((RouteMethod aRoute) {
      //TODO handle methods that return future
      _buffer.write('''
        if(${aRoute.name}.doesMatch(request.uri.path, request.method)) {
          return ${aRoute.metadata.name}();
        }
        ''');
    });

    _buffer.writeln("}");
  }

  void _dump() {
    _buffer.writeln("abstract class Jaguar${className} {");

    _routes.forEach((RouteMethod aRoute) {
      _dumpRouteMethodSignature(aRoute);
    });

    _routes.forEach((RouteMethod aRoute) {
      _dumpRouteMethodInfo(aRoute);
    });

    _dumpHandler();

    _buffer.writeln("}");
  }

  String getCode() {
    _dump();
    return _buffer.toString();
  }
}
