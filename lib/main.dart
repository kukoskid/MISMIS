import 'package:flutter/material.dart';
import 'screens/joke_types_screen.dart';
import 'screens/random_joke_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes for You',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[700],
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.purpleAccent),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => JokeTypesScreen(),
        '/randomJoke': (context) => RandomJokeScreen(),
      },
    );
  }
}
