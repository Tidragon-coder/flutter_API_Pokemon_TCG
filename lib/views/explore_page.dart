import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_poke_tcg/viewmodels/explore_viewmodel.dart';
import 'package:api_poke_tcg/widgets/app_drawer.dart';

import '../models/search_result.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreViewmodel(),
      child: const ExplorePageContent(),
    );
  }
}

class ExplorePageContent extends StatefulWidget {
  const ExplorePageContent({super.key});

  @override
  State<ExplorePageContent> createState() => _ExplorePageContentState();
}

class _ExplorePageContentState extends State<ExplorePageContent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreViewmodel>().onSearchPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExploreViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Exploration')),
      drawer: AppDrawer(),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.result == null || viewModel.result!.isEmpty
          ? const Center(child: Text("Aucun résultat"))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: viewModel.result!.length,
              itemBuilder: (context, index) {
                final card = viewModel.result![index];
                return _CardTile(card: card);
              },
            ),
    );
  }
}

class _CardTile extends StatelessWidget {
  final CardModel card;

  const _CardTile({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: card.image != null && card.image!.isNotEmpty
                ? Image.network(
                    '${card.image}/high.png',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '#${card.localId}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
