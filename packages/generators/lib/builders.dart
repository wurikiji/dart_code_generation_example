/// Support for doing something awesome.
///
/// More dartdocs go here.
library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/getter_setter_gnerator.dart';
import 'src/generators/injectable_generator.dart';
import 'src/generators/responsive_widget_generator.dart';

Builder injectableBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      InjectableGenerator(),
    ],
    'injectable_generator',
  );
}

Builder responsiveWidgetBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      ResponsiveWidgetGenerator(),
    ],
    'responsive_widget_generator',
  );
}

Builder getterSetterBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      GetterGenerator(),
      SetterGenerator(),
    ],
    'getter_setter_builder',
  );
}
