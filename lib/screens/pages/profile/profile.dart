import 'package:flutter/material.dart';
import 'package:marvel/screens/pages/home/components/home_components.dart';

import '../../widgets/components.dart';
import 'controller/profile_controller.dart';

ProfileController _controller = ProfileController();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, this.arguments}) : super(key: key);

  static const routeName = '/profile';

  final String? arguments;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: GlobalWidgets.textTitlecenterNoOver(text: 'Test'),
      ),
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
                return Text('Tamam'); //_lsitCharacter(context);
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