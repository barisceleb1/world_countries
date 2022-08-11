import 'package:flutter/material.dart';
import 'package:world_countries/home_page.dart';


void main() {
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
