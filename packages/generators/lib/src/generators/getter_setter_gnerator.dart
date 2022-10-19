import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class GetterSetterGenerator extends GeneratorForAnnotation<GetterSetter> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return r'''
extension on MyClass {
  int get hello => _hello;
}
''';
  }
}
