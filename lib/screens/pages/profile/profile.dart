import 'package:flutter/material.dart';

import '../../../models/characters.dart';
import '../../widgets/components.dart';
import '../../widgets/image_component.dart';
import 'components/list_horizontal_comics.dart';
import 'controller/profile_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key, this.arguments}) : super(key: key);

  static const routeName = '/profile';

  final String? arguments;
  final ProfileController _controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    final args = arguments ?? ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return GlobalWidgets.textTitlecenterNoOver(
              text: _controller.character == null
                  ? "Karakter Detay"
                  : _controller.character!.data!.results!.first.name);
        }),      ),
      body: FutureBuilder(
        future: _controller.getProfileFromApi(context, id: args),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasData) {
              if (snapshot.data == false) {
                const ErrorComponent();
              } else {
                return _body(context);
                              }
            }
            return const ErrorComponent();
          } catch (e) {
            return const ErrorComponent();
          }
        },
      ),
    );
  }

Widget _body(BuildContext context) {
    Result result = _controller.character!.data!.results!.first;
    return SingleChildScrollView(
      child: Column(mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Container(                    height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width*0.4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ImageFromAPI(
                    url: result.thumbnail.path,
                    imageVariant: ImageVariant.detail,
                    extention: result.thumbnail.extension.name.toString()),
              ),    ),
          ),
          GlobalWidgets.textTitlecenterNoOver(text: result.name, fontSize: 20),
          GlobalWidgets.textSimpleSize(text: result.description == "" ? "" : result.description),
          ListComics(result: result),
          const SizedBox(height: 32)
        ],
      ),
    );
  }

}