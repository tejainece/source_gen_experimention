library test_source_gen.generators.api_class;

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_experimentation/annotations/api_class.dart';

class ApiClassAnnotationGenerator extends GeneratorForAnnotation<ApiClass> {
  const ApiClassAnnotationGenerator();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ApiClass annotation, BuildStep buildStep) async {
    return "// ${element.displayName} ${annotation.name} ${annotation.version}";
  }

  String toString() => 'ApiClass';
}

// class ApiClassGenerator extends Generator {
//   Future<String> generator(Element element, BuildStep buildStep) async {
//     return "hello";
//   }
// }
