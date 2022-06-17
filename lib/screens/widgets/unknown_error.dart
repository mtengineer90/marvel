
import 'package:flutter/material.dart';

import 'widgets.dart';
  void unknownError(BuildContext context) {
    GlobalWidgets.msgAlert(
      context: context,
      title: 'Hata!',
      content: "Tekrar deneyin!",
    );
  }
