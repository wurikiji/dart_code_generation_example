import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'utils/gs_converter.dart';

class GetterSetterGenerator extends Generator {
  const GetterSetterGenerator();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final variables = library.allElements.whereType<VariableElement>();
    final classes = library.allElements.whereType<ClassElement>();

    final variableGetters = variables.toGetters().trim();
    final variableSetters = variables.toSetters().trim();

    final classExtension = classes.map((e) {
      final getters = e.fields.toGetters().trim();
      final setters = e.fields.toSetters().trim();
      if (getters.isEmpty && setters.isEmpty) return '';
      return '''
extension ${e.name}GetterSetter on ${e.name} {
  $getters
  $setters
}
''';
    }).join('\n');

    return '''
$variableGetters
$variableSetters
$classExtension
'''
        .trim();
  }
}
