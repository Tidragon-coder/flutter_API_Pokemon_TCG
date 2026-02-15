import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_poke_tcg/views/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/search_viewmodel.dart'; 
import 'viewmodels/explore_viewmodel.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(        
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => ExploreViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Pokémon TCG',  
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}