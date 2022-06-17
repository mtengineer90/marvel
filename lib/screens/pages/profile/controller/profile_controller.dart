import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/models.dart';
import '../../../../models/profile.dart';
import '../../../../services/constants.dart';
import '../../../../services/web/request.dart';
import '../../../widgets/components.dart';
import '../../../widgets/widgets.dart';


part 'profile_controller.g.dart';

class ProfileController = _ProfileController with _$ProfileController;

abstract class _ProfileController with Store {
  @observable
  Character? character;

  @action
  Future<bool> getProfileFromApi(BuildContext context, {String? id}) async {
    try {
      var response = await ReqAPI.get(endPoint: "${EndPoint.characters}/$id");
      if (response.statusCode == 200) {
        character = charactersFromJson(response.body);
        return true;
      } else {
        if (response.body.contains('message')) {
          GlobalWidgets.msgAlert(
            context: context,
            title: apiErrorFromJson(response.body).message,
          );
          return false;
        } else {
          unknownError(context);
          return false;
        }
      }
    } catch (e) {
      unknownError(context);
      return false;
    }
  }
}