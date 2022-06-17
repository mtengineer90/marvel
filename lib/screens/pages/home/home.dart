import 'package:flutter/material.dart';

import '../../../models/characters.dart';
import '../../widgets/widgets.dart';
import 'components/error_component.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GlobalComponents.textTitlecenterNoOver(text: 'Home Screen'),
      ),
      body: FutureBuilder(
        future: _controller.getCharacterFromApi(context),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasData) {
              if (snapshot.data == false) {
                const ErrorComponent();
              } else {
                return _lsitCharacter(context);
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

  Widget _lsitCharacter(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: _controller.character!.data.results.length,
          itemBuilder: (context, index) {
            Result result = _controller.character!.data.results[index];

            return ListTile(
              leading: Image.network(
                '${result.thumbnail.path}/portrait_xlarge.${result.thumbnail.extension.name.toString().toLowerCase()}',
                errorBuilder: (context, error, stackTrace) {
                  return const Text('😢');
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularProgressIndicator.adaptive();
                  }
                },
              ),
              title: GlobalComponents.textSimpleSize(text: result.name),
              contentPadding: const EdgeInsets.all(8),
            );
          }),
    );
  }
}