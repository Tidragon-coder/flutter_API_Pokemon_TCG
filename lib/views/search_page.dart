import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/search_viewmodel.dart';
import '../models/search_result.dart';

class SecondPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Recherche de cartes Pokémon')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // ── Barre de recherche ──────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Nom du Pokémon...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => viewModel.onSearchPressed(_controller.text),
                  child: Text('Rechercher'),
                ),
              ],
            ),

            SizedBox(height: 16),

            if (viewModel.isLoading)
              Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (viewModel.errorMessage != null)
              Expanded(
                child: Center(
                  child: Text(
                    viewModel.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (viewModel.result == null || viewModel.result!.isEmpty)
              Expanded(
                child: Center(child: Text('Recherchez un autre Pokémon !')),
              )
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: viewModel.result?.length ?? 0,
itemBuilder: (context, index) {
  final card = viewModel.result![index];
                    return _CardTile(card: card);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Tuile d'une carte ────────────────────────────────────────────────
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
  



//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showCardDetail(context, card),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [

//             // Image de la carte
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                 child: card.images?.small != null
//                     ? Image.network(
//                         card.images!.small!,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) =>
//                             Icon(Icons.broken_image, size: 60),
//                       )
//                     : Icon(Icons.image_not_supported, size: 60),
//               ),
//             ),

//             // Nom + rareté
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     card.name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   if (card.rarity != null)
//                     Text(
//                       card.rarity!,
//                       style: TextStyle(color: Colors.grey, fontSize: 11),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Détail de la carte en popup ───────────────────────────────────
//   void _showCardDetail(BuildContext context, CardModel card) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) => DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.85,
//         builder: (_, scrollController) => SingleChildScrollView(
//           controller: scrollController,
//           padding: EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               // Image grande
//               Center(
//                 child: card.images?.large != null
//                     ? Image.network(card.images!.large!, height: 280)
//                     : Icon(Icons.image_not_supported, size: 100),
//               ),
//               SizedBox(height: 16),

//               // Nom
//               Text(
//                 card.name,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),

//               if (card.supertype != null)
//                 Text(card.supertype!, style: TextStyle(color: Colors.grey)),

//               SizedBox(height: 12),
//               Divider(),
//               SizedBox(height: 8),

//               // Infos générales
//               if (card.hp != null)        _infoLine('HP', card.hp!),
//               if (card.types != null)     _infoLine('Types', card.types!.join(', ')),
//               if (card.rarity != null)    _infoLine('Rareté', card.rarity!),
//               if (card.artist != null)    _infoLine('Illustrateur', card.artist!),
//               if (card.evolvesFrom != null) _infoLine('Évolue de', card.evolvesFrom!),
//               if (card.set != null)       _infoLine('Extension', '${card.set!.name} (${card.set!.series ?? ''})'),
//               if (card.number != null && card.set?.total != null)
//                 _infoLine('Numéro', '${card.number} / ${card.set!.total}'),

//               // Attaques
//               if (card.attacks != null && card.attacks!.isNotEmpty) ...[
//                 SizedBox(height: 12),
//                 Text('Attaques', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 6),
//                 ...card.attacks!.map((attack) => _attackTile(attack)),
//               ],

//               // Faiblesses / Résistances
//               if (card.weaknesses != null && card.weaknesses!.isNotEmpty)
//                 _infoLine('Faiblesse(s)', card.weaknesses!.map((w) => '${w.type} ${w.value}').join(', ')),
//               if (card.resistances != null && card.resistances!.isNotEmpty)
//                 _infoLine('Résistance(s)', card.resistances!.map((r) => '${r.type} ${r.value}').join(', ')),

//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _infoLine(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('$label : ', style: TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }

//   Widget _attackTile(Attack attack) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(attack.name, style: TextStyle(fontWeight: FontWeight.bold)),
//                 if (attack.text != null && attack.text!.isNotEmpty)
//                   Text(attack.text!, style: TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//           ),
//           if (attack.damage != null && attack.damage!.isNotEmpty)
//             Text(
//               attack.damage!,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//             ),
//         ],
//       ),
//     );
//   }
// }
