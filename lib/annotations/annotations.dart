library test_source_gen.annotations.api_class;

class Group {
  final String urlPrefix;

  final String version;

  const Group({this.urlPrefix, this.version});

  String toString() => "$urlPrefix $version";
}

class Route {
  final String urlTemplate;

  final List<String> methods;

  const Route({this.urlTemplate: '', this.methods});
}

class RouteInfo {
  /// create a route object
  const RouteInfo(this.urlTemplate, {this.methods});

  /// the [urlTemplate] of the route
  final String urlTemplate;

  /// the allowed method of this route
  final List<String> methods;

  @override
  String toString() => "$urlTemplate $methods";

  bool doesMatch(String aPath, String aMethod) {
    //TODO implement complex matcher
    return aPath == urlTemplate && methods.contains(aMethod);
  }
}