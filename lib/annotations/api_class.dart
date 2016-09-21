library test_source_gen.annotations.api_class;

class ApiClass {
  final String name;
  final String version;

  const ApiClass({this.name, this.version});

  String toString() => "$name $version";
}
