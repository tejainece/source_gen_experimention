library test_source_gen.tool.phases;

import 'package:build/build.dart';

import 'package:source_gen/source_gen.dart';

import 'package:source_gen_experimentation/generators/generator.dart';

final PhaseGroup phases = new PhaseGroup.singleAction(
    new GeneratorBuilder(const [
      const ApiClassAnnotationGenerator(),
    ]),
    new InputSet('source_gen_experimentation', const ['bin/main.dart']));
