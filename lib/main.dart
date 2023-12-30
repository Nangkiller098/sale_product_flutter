import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sale_product_flutter/screens/home_screen.dart';
import 'package:sale_product_flutter/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = LocalStorage("USER_SESSION");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sale Product App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, data) {
          var token = storage.getItem("TOKEN");
          if (token == null) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
