import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../widgets/widgets.dart';

class ListComics extends StatelessWidget {
  const ListComics({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0,2.0,16.0,16.0),
      child: SizedBox(
        height: 320,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: result.comics.items.length,
            itemBuilder: ((context, index) {
              return Card(
                child: SizedBox(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GlobalWidgets.textSimpleSize(text: result.comics.items[index].name,),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}