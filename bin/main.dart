library main;

import 'dart:async';

import 'package:source_gen_experimentation/annotations/api_class.dart';
import 'package:source_gen_experimentation/annotations/api_method.dart';

part 'main.g.dart';

void main(List<String> args) {
  TestApi test = new TestApi();
}

@ApiClass(name: 'test', version: 'v1')
class TestApi {
  int a = 12;

  @ApiMethod(methods: const ['GET'])
  Future<Null> get() async {
    print("test");
  }
}
