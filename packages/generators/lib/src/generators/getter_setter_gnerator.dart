import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
class GetterGenerator extends GeneratorForAnnotation<Getter> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    print('This is field element $element');
    if (element is VariableElement) {
      final type = element.type;
      final name = element.name;
      if (!name.startsWith('_')) {
        throw 'Getter annotation can only be used on private variables';
      }
      final getter = name.substring(1);
      return '''
$type get $getter => $name;
''';
    }

    if (element is FieldElement) {
      final type = element.type;
      final name = element.name;
      if (!name.startsWith('_')) {
        throw 'Getter annotation can only be used on private variables';
      }
      final getter = name.substring(1);
      final className = element.enclosingElement3.name;
      return '''
extension on $className {
  $type get $getter => $name;
}
''';
    }

    throw 'Getter annotation can only be used on variables and class fields';
  }
}

class SetterGenerator extends GeneratorForAnnotation<Setter> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is VariableElement) {
      final type = element.type;
      final name = element.name;
      if (!name.startsWith('_')) {
        throw 'Setter annotation can only be used on private fields';
      }
      final setter = name.substring(1);
      return '''
set $setter($type newVal) => $name = newVal;
''';
    }
    throw 'Setter annotation can only be used on variables';
  }
}
