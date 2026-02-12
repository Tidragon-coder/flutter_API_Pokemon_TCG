import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchService {
  final String _baseUrl = 'https://api.pokemontcg.io/v2/cards';
  String get _apiKey => dotenv.env['POKE_API_KEY'] ?? '';

  Future<List<CardModel>> search(String query) async {
    final uri = Uri.parse('$_baseUrl?q=name:$query');
    final response = await http.get(
      uri,
      headers: {'X-Api-Key': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((json) => CardModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Erreur lors de la recherche : ${response.statusCode}');
    }
  }
}