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
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GlobalWidgets.textTitlecenterNoOver(text: 'Anasayfa'),
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
                return listChar(context);
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
    }
  }

  Widget listChar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Observer(builder: (_) {
        int lenght = _controller.character!.data!.results!.length;
        return ListView.builder(
          controller: _scrollController,
          itemCount: _controller.loading ? lenght : lenght,
          itemBuilder: (context, index) {
            if (index == lenght - 1) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            } else {
              Result result = _controller.character!.data!.results![index];

              return Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 50),
                        child: ImageFromAPI(
                          url: result.thumbnail.path,
                          imageVariant: ImageVariant.detail,
                          extention: result.thumbnail.extension.name.toString().toLowerCase(),
                        ),
                      ),
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
            }
          },
        );
      }),
    );
  }
}