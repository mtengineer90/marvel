import 'package:flutter/material.dart';
import 'package:marvel/screens/pages/home/components/home_components.dart';

import '../../widgets/components.dart';
import 'controller/profile_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key, this.arguments}) : super(key: key);

  static const routeName = '/profile';

  final String? arguments;
late ProfileController _controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return GlobalWidgets.textTitlecenterNoOver(
              text: _controller.character == null
                  ? "Profil Sayfası"
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
                return Text('Tamam'); //_listChar(context);
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

  Widget _body() {
    return ListView(
      children: [],
    );
  }
}