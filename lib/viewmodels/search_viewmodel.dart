import 'package:flutter/material.dart';
import '../models/search_result.dart';
import '../services/search_service.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchService _service = SearchService();

  bool isLoading = false;
  String? errorMessage;

  List<CardModel>? result; // ← plus une List, un seul objet nullable

Future<void> onSearchPressed(String query) async {
  if (query.isEmpty) return;

  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    result = await _service.search(query);  // ← on stocke un seul résultat
  } catch (e) {
    errorMessage = 'Erreur : $e';
    result = null;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}