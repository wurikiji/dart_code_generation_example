import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ConvertToGetter extends ConvertVariable {
  ConvertToGetter(super.element, {super.asMethod});

  @override
  String toString() => asMethod
      ? '$type get${name.toPublic().toFirstCharUpper()}() => $name;'
      : '$type get ${name.toPublic()} => $name;';
}

class ConvertToSetter extends ConvertVariable {
  ConvertToSetter(super.element, {super.asMethod});

  @override
  String toString() => asMethod
      ? 'set${name.toPublic().toFirstCharUpper()}($type newVal) => $name = newVal;'
      : 'set ${name.toPublic()}($type newVal) => $name = newVal;';
}

abstract class ConvertVariable {
  ConvertVariable(this.element, {this.asMethod = false})
      : assert(
          element is VariableElement || element is FieldElement,
          'Getter/Setter annotation can only be used on variables and class fields',
        ),
        assert(
          element.isPrivate,
          'Getter/Setter annotation can only be used on private variables',
        );

  final Element element;
  final bool asMethod;

  String get name => element.name!;
  DartType get type => (element as dynamic).type;
}

extension ConvertElementsToGetterSetter on Iterable<Element> {
  String toGetters() => where((e) => e.isPrivate)
          .where((elm) => elm.annotatedWithGetter())
          .map((elm) {
        return elm.asMethod()
            ? ConvertToGetter(elm, asMethod: true)
            : ConvertToGetter(elm);
      }).join('\n');
  String toSetters() => where((e) => e.isPrivate)
          .where((elm) => elm.annotatedWithSetter())
          .map((elm) {
        return elm.asMethod()
            ? ConvertToSetter(elm, asMethod: true)
            : ConvertToSetter(elm);
      }).join('\n');
}

extension on Element {
  bool asMethod() {
    final annotation = _annotationOfGetter() ?? _annotationOfSetter()!;
    final asMethod = annotation.getField('asMethod')?.toBoolValue() ?? false;
    return asMethod;
  }

  DartObject? _annotationOfGetter() => _annotationOf<Getter>(this);
  DartObject? _annotationOfSetter() => _annotationOf<Setter>(this);
  bool annotatedWithGetter() => _annotatedWith<Getter>(this);
  bool annotatedWithSetter() => _annotatedWith<Setter>(this);
}

DartObject? _annotationOf<T>(Element element) =>
    TypeChecker.fromRuntime(T).firstAnnotationOf(element);

bool _annotatedWith<T>(Element element) =>
    TypeChecker.fromRuntime(T).hasAnnotationOf(element);

extension PublicPrivate on String {
  String toPublic() => replaceFirst(RegExp(r'^_+'), '');
  String toFirstCharUpper() =>
      replaceRange(0, 1, substring(0, 1).toUpperCase());
}
