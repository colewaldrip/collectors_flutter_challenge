import 'package:flutter/material.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collection App',
      theme: ThemeData(
        fontFamily: 'AreaNormal',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AppView(),
    );
  }
}
