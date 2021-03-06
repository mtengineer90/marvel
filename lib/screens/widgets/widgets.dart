import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class GlobalWidgets {
  static Future<void> msgAlert({
    required BuildContext context,
    String? title,
    String? content,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    EdgeInsetsGeometry? padding,
    bool showCloseIcon = true,
    bool barrierDismissible = true,
    Widget? child,
  }) async {
    await showGeneralDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: Color.fromARGB(255, 240, 228, 228).withOpacity(0.5),
      context: context,
      transitionBuilder: (context, a1, a2, widget2) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            title: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    child ??
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: padding,
                            child: textTitlecenterNoOver(text: "$title", fontSize: 18),
                          ),
                        ),
                    Visibility(
                      visible: showCloseIcon,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  MdiIcons.close,
                                )),
                          )),
                    ),
                  ],
                )),
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            //left, top, right, bottom
            content: Visibility(
              visible: child == null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                children: <Widget>[
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                    child: textSimpleSize(text: content ?? "", fontSize: 11, textcolor: Colors.black87),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Color.fromARGB(77, 247, 233, 233),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 240),
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) => const SizedBox(),
    );
  }

  static Widget textTitlecenterNoOver({required String text, double? fontSize=14, Color? textcolor}) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: textcolor));
  }

  static Widget textSimpleSize({required String text, Color? textcolor, double? fontSize=14}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(color: textcolor, fontSize: fontSize)),
    );
  }
}

