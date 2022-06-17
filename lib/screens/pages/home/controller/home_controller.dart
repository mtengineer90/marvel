import '../../../../models/characters.dart';
import 'package:mobx/mobx.dart';

import '../../../../services/constants.dart';
import '../../../../services/web/request.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  Character? character;

  @action
  Future getCharacterFromApi() async {
    try {
      var response = await ReqAPI.get(endPoint: EndPoint.characters);
    } catch (e) {}
  }
}