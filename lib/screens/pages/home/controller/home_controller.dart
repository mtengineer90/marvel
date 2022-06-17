import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import 'package:mobx/mobx.dart';

import '../../../../services/constants.dart';
import '../../../../services/web/request.dart';
import '../../../widgets/unknown_error.dart';
import '../../../widgets/widgets.dart';

part 'home_controller.g.dart';
class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  Character? character = Character(data: Data(results: <Result>[]));
  @observable
  bool loading = false;

  @action
  Future<bool> getCharacterFromApi(BuildContext context) async {
    try {
      changeLoading(true);
      var response = await ReqAPI().get(endPoint: EndPoint.characters);
      if (response.statusCode == 200) {
        if (character!.etag == null) {
          character = charactersFromJson(str:response.body);
        } else {
          addResults(charactersFromJson(str: response.body).data!.results!);
        }
        changeLoading(false);
        return true;
      } else {
        if (response.body.contains('message')) {
          GlobalWidgets.msgAlert(
            context: context,
            title: apiErrorFromJson(response.body).message,
          );
          changeLoading(false);

          return false;
        } else {
          unknownError(context);
          changeLoading(false);

          return false;
        }
      }
    } catch (e) {
      unknownError(context);
      changeLoading(false);

      return false;
    }
  }

  @action
  void addResults(List<Result> results) {
    for (var element in results) {
      character!.data!.results!.add(element);
    }
    character = character;
  }

  @action
  changeLoading(bool value) {
    loading = value;
  }
}