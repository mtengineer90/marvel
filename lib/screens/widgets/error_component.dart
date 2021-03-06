import 'package:flutter/material.dart';

import 'widgets.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_outlined),
        ],
      ),
    );
  }
}