/// Support for doing something awesome.
///
/// More dartdocs go here.
library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/auto_dispose_generator.dart';
import 'src/generators/getter_setter_gnerator.dart';

Builder getterSetterBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      GetterSetterGenerator(),
    ],
    'getter_setter_builder',
  );
}

Builder autoDisposeBuilder(BuilderOptions _) {
  return SharedPartBuilder(
    [
      AutoDisposeGenerator(),
    ],
    'auto_dispose_builder',
  );
}
