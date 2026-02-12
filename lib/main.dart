import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_poke_tcg/views/home_page.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/search_viewmodel.dart'; // ← ajout

void main() {
  runApp(
    MultiProvider(          // ← on passe à MultiProvider
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()), // ← ajout
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Pokémon TCG',  // ← nom mis à jour
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}