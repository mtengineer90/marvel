// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileController on _ProfileController, Store {
  late final _$characterAtom =
      Atom(name: '_ProfileController.character', context: context);

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

  late final _$getProfileFromApiAsyncAction =
      AsyncAction('_ProfileController.getProfileFromApi', context: context);

  @override
  Future<bool> getProfileFromApi(BuildContext context, {String? id}) {
    return _$getProfileFromApiAsyncAction
        .run(() => super.getProfileFromApi(context, id: id));
  }

  @override
  String toString() {
    return '''
character: ${character}
    ''';
  }
}
