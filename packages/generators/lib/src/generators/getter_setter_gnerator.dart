import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'utils/gs_converter.dart';

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
    return '''
extension GetterSetterOn$className on $className {
  ${element.fields.toGetters()}
  ${element.fields.toSetters()}
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
    if (element is! VariableElement) {
      throw 'Getter annotation can only be used on variables';
    }
    return element.toGetter();
  }
}

class SetterGenerator extends GeneratorForAnnotation<Setter> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! VariableElement) {
      throw 'Setter annotation can only be used on variables';
    }
    return element.toSetter();
  }
}
