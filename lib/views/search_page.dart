import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:api_poke_tcg/viewmodels/home_viewmodel.dart';

import 'package:api_poke_tcg/widgets/app_drawer.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Bienvenue sur la seconde page'),
      ),
    );
  }
}
