import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../models/characters.dart';
import '../../widgets/image_component.dart';
import '../../widgets/widgets.dart';
import '../../widgets/error_component.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_scrollListener);

    return Scaffold(
      appBar: AppBar(
        title: GlobalWidgets.textTitlecenterNoOver(text: 'Home Screen'),
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
                return _listChar(context);
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

  _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      await _controller.getCharacterFromApi(context);
      setState(() {
        print('tttt');
      });
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  Widget _listChar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Observer(builder: (_) {
        int lenght = _controller.character!.data!.results!.length;
        return ListView.builder(
          itemCount: _controller.loading ? lenght + 1 : lenght,
          itemBuilder: (context, index) {
            Result result = _controller.character!.data!.results![index];
            if (index == lenght - 1) {
              return const CircularProgressIndicator();
            }
            return Column(
              children: [
                ListTile(
                  leading: ImageFromAPI(
                    url: result.thumbnail.path,
                    imageVariant: ImageVariant.portraitXlarge,
                    extention: result.thumbnail.extension.name.toString().toLowerCase(),
                  ),
                  title: GlobalWidgets.textSimpleSize(text: result.name),
                  contentPadding: const EdgeInsets.all(8),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile', arguments: result.id.toString());
                  },
                ),
                const Divider(thickness: 2, height: 1)
              ],
            );
          },
        );
      }),
    );
  }
}