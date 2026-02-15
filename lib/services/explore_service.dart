import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_result.dart';

class SearchService {

  final String _baseUrl = 'https://api.tcgdex.net/v2/fr/cards';

  Future<List<CardModel>> search() async {
  final response = await http.get(Uri.parse(_baseUrl));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final List list = data is List ? data : (data['data'] as List);

    return list.map((json) => CardModel.fromJson(json)).toList();
  } else {
    throw Exception('Erreur lors de la recherche : ${response.statusCode}');
  }
}
}