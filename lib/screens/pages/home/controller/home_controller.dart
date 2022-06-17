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
  Future getCharacterFromApi(BuildContext context) async {
    try {
      var response = await ReqAPI.get(endPoint: EndPoint.characters);
      if (response.statusCode == 200) {
        character = charactersFromJson(response.body);
      } else {
        if (response.body.contains('message')) {
          GlobalComponents.msgAlert(
            context: context,
            title: apiErrorFromJson(response.body).message,
          );
        } else {
          _unknownError(context);
        }
      }
    } catch (e) {
      _unknownError(context);
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