library test_source_gen.tool.builder;

import 'package:build/build.dart';

import 'phases.dart';

main() async {
  await build(phases, deleteFilesByDefault: true);
}
