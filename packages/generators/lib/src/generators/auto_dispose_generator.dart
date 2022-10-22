import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:annotations/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'utils/gs_converter.dart';

class AutoDisposeGenerator extends Generator {
  const AutoDisposeGenerator();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final classes = library.allElements.whereType<ClassElement>();

    final classExtensions = classes.map((classElm) {
      final targets = classElm.fields
          .where(TypeChecker.fromRuntime(AutoDispose).hasAnnotationOf)
          .where(
            (field) => field.isPrivate,
          )
          .where(
            (field) =>
                field.type.nullabilitySuffix == NullabilitySuffix.question,
          );

      final privateVariables = targets
          .map((field) {
            final type = field.type;
            final name = field.name;
            final privateName = '_${classElm.name}$name';
            final disposeChecker = '_active$privateName';
            return '''
$type $privateName;
bool $disposeChecker = false;
''';
          })
          .join('\n')
          .trim();

      final getters = targets
          .map((field) {
            final type = field.type.getDisplayString(withNullability: false);
            final name = field.name;
            final privateName = '_${classElm.name}$name';
            final publicName = name.toPublic();
            final disposerName = '_dispose$publicName';
            final activeChecker = '_active$privateName';
            return '''
$type $publicName(BuildContext context) {
  $privateName ??= $type();
  if (!$activeChecker) {
    $activeChecker = true;
    $disposerName(context);
  }
  return $privateName!;
}

void $disposerName(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    try {
      final element = context as Element;
      if (element.widget != null) {
        _dispose$publicName(context);
        return;
      }
    } catch (e) {
    }
    $privateName?.dispose();
    $privateName = null;
    $activeChecker = false;
  });
}
''';
          })
          .join('\n')
          .trim();

      if (privateVariables.isEmpty && getters.isEmpty) return '';

      return '''
$privateVariables

extension AutoDisposeFor${classElm.name} on ${classElm.name} {
  $getters
}
'''
          .trim();
    }).join('\n');

    return classExtensions.trim();
  }
}
