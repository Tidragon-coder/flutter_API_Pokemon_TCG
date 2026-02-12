import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_poke_tcg/views/home_page.dart';
import 'viewmodels/home_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
