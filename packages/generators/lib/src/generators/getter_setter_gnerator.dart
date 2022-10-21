import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class ClassGSGenerator extends GeneratorForAnnotation<ApplyGS> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw 'Only classes can be annotated with @ApplyGS';
    }
    final className = element.name;
    final getters = element.fields
        .where(
      (element) =>
          TypeChecker.fromRuntime(Getter).hasAnnotationOfExact(element),
    )
        .map((field) {
      final type = field.type;
      final name = field.name;
      if (!name.startsWith('_')) {
        throw 'Getter annotation can only be used on private variables';
      }
      final getter = name.substring(1);
      return '$type get $getter => $name;';
    });
    final setters = element.fields
        .where(
      (element) =>
          TypeChecker.fromRuntime(Setter).hasAnnotationOfExact(element),
    )
        .map((field) {
      final type = field.type;
      final name = field.name;
      if (!name.startsWith('_')) {
        throw 'Setter annotation can only be used on private fields';
      }
      final setter = name.substring(1);
      return '''
set $setter($type newVal) => $name = newVal;
''';
    });
    return '''
extension GetterSetterOn$className on $className {
  ${getters.join('\n')}
  ${setters.join('\n')}
}
''';
  }
}

class GetterGenerator extends GeneratorForAnnotation<Getter> {
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
        throw 'Getter annotation can only be used on private variables';
      }
      final getter = name.substring(1);
      return '''
$type get $getter => $name;
''';
    }

    throw 'Getter annotation can only be used on variables';
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
