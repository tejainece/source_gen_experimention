// GENERATED CODE - DO NOT MODIFY BY HAND

part of main;

// **************************************************************************
// Generator: Group
// Target: class TestApi
// **************************************************************************

abstract class JaguarTestApi {
  static RouteInfo _routeget = const RouteInfo('/get', methods: const <String>[
    'GET',
  ]);
  Future<Null> handleRequest(HttpRequest request) async {
    if (_routeget.doesMatch(request.uri.path, request.method)) {
      return get();
    }
  }
}
