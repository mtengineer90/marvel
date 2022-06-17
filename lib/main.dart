import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'screens/pages/home/home.dart';
import 'screens/pages/profile/profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      routes: {
        '/': ((context) => const HomeScreen()),
        ProfileScreen.routeName: ((context) => ProfileScreen()),
      },
    );
  }
}