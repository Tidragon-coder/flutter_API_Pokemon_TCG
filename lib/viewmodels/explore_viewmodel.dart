import 'package:flutter/material.dart';
import '../models/search_result.dart';
import '../services/explore_service.dart';

class ExploreViewmodel extends ChangeNotifier {
  final SearchService _service = SearchService();

  bool isLoading = false;
  String? errorMessage;

  List<CardModel>? result; 

Future<void> onSearchPressed() async {

  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    result = await _service.search(); 
  } catch (e) {
    errorMessage = 'Erreur : $e';
    result = null;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}