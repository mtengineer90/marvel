import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import 'package:mobx/mobx.dart';

import '../../../../services/constants.dart';
import '../../../../services/web/request.dart';
import '../../../widgets/widgets.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  Character? character;

  @action
  Future<bool> getCharacterFromApi(BuildContext context) async {
    try {
      var response = await ReqAPI.get(endPoint: EndPoint.characters);
      if (response.statusCode == 200) {
        character = charactersFromJson(response.body);
        return true;
      } else {
        if (response.body.contains('message')) {
          GlobalComponents.msgAlert(
            context: context,
            title: apiErrorFromJson(response.body).message,
          );
          return false;
        } else {
          _unknownError(context);
          return false;
        }
      }
    } catch (e) {
      _unknownError(context);
                return false;
    }
  }

  void _unknownError(BuildContext context) {
    GlobalComponents.msgAlert(
      context: context,
      title: 'Hata!',
      content: "Tekrar deneyin!",
    );
  }
}