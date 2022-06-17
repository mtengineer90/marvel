import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class ListHorizontalComics extends StatelessWidget {
  const ListHorizontalComics({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: result.comics.items.length,
          itemBuilder: ((context, index) {
            return Card(
              child: SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GlobalWidgets.textSimpleSize(text: result.comics.items[index].name),
                  ],
                ),
              ),
            );
          })),
    );
  }
}