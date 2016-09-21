library test_source_gen.generators.api_method;

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_experimentation/annotations/api_method.dart';

class ApiMethodAnnotationGenerator extends GeneratorForAnnotation<ApiMethod> {
  const ApiMethodAnnotationGenerator();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ApiMethod annotation, BuildStep buildStep) async {
    return "// ${element.displayName} ${annotation.path} ${annotation.methods}";
  }

  String toString() => 'ApiMethod';
}
