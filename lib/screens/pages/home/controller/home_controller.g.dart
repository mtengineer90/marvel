// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$characterAtom =
      Atom(name: 'HomeControllerBase.character', context: context);

  @override
  Character? get character {
    _$characterAtom.reportRead();
    return super.character;
  }

  @override
  set character(Character? value) {
    _$characterAtom.reportWrite(value, super.character, () {
      super.character = value;
    });
  }

  late final _$getCharacterFromApiAsyncAction =
      AsyncAction('HomeControllerBase.getCharacterFromApi', context: context);

  @override
  Future<dynamic> getCharacterFromApi() {
    return _$getCharacterFromApiAsyncAction
        .run(() => super.getCharacterFromApi());
  }

  @override
  String toString() {
    return '''
character: ${character}
    ''';
  }
}
