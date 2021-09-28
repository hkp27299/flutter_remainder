import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/home_page.dart';
import 'Models/notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => Notifier(),
        child: const HomePage(),
      ),
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(149, 189, 220, 1),
              secondary: Color.fromRGBO(227, 129, 240, 1),
              background: Color.fromRGBO(156, 227, 240, 1)),
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(251, 75, 31, 1)),
              headline1: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(254, 121, 61, 1)))),
    );
  }
}
