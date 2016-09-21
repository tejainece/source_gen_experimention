library sourceout;

import 'package:analyzer/dart/element/element.dart';

/// Generates the name for the [type].
///
/// This supports recursive calls for generics.
String generateType(TypeMetadata type) =>
    '${type.name}${generateTypeArguments(type)}';

/// Generates the arguments for the [type].
///
/// This supports recursive calls for generics.
String generateTypeArguments(TypeMetadata type) {
  var buffer = new StringBuffer();

  // Look for generics
  var arguments = type.arguments;

  if (arguments.isNotEmpty) {
    buffer.write('<');

    var argumentBuffer = new ArgumentBuffer();

    for (var argument in arguments) {
      argumentBuffer.write(generateType(argument));
    }

    buffer.write(argumentBuffer.toString());
    buffer.write('>');
  }

  return buffer.toString();
}