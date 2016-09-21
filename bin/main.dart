library main;

import 'dart:async';

import 'package:source_gen_experimentation/annotations/annotations.dart';
import 'dart:io';

part 'main.g.dart';

class MockHttpRequest implements HttpRequest {
  MockHttpRequest(this._uri, this._method);

  int get contentLength => 10;

  final String _method;

  String get method => 'GET';

  final Uri _uri;

  Uri get uri => _uri;

  Uri get requestedUri => _uri;

  HttpHeaders get headers => null;

  List<Cookie> get cookies => null;

  bool get persistentConnection => null;

  X509Certificate get certificate => null;

  HttpSession get session => null;

  String get protocolVersion => null;

  HttpConnectionInfo get connectionInfo => null;

  HttpResponse get response => null;
}

main(List<String> args) async {
  TestApi test = new TestApi();

  print(await test.handleRequest(new MockHttpRequest(new Uri.http("jaguar.com", "/api/get", {}), 'GET')));
}

@Group(urlPrefix: '/api', version: 'v1')
class TestApi extends Object with JaguarTestApi {
  int a = 12;

  @Route(urlTemplate: "/get", methods: const ['GET'])
  String get() {
    return "data";
  }
}
