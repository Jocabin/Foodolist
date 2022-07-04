import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:foodolist/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodolist/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFFF4DB),
      systemNavigationBarDividerColor: Color(0xFFFFF4DB),
      systemNavigationBarColor: Color(0xFFFFF4DB)));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FoodolistApp());
}

class FoodolistApp extends StatelessWidget {
  const FoodolistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Foodolist",
        theme: ThemeData(
          primaryColor: const Color(0xFF507F24),
          backgroundColor: const Color(0xFFFFF4DB),
          fontFamily: "Futura",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
                onPrimary: Colors.white),
          ),
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF011200)),
              bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF011200)),
              button: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF507F24))),
        ),
        home: const HomePage());
  }
}
