/// Support for doing something awesome.
///
/// More dartdocs go here.
library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/getter_setter_gnerator.dart';

Builder getterSetterBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      GetterGenerator(),
      SetterGenerator(),
      ClassGSGenerator(),
    ],
    'getter_setter_builder',
  );
}
