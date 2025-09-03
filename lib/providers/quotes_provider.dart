
import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class QuoteProvider with ChangeNotifier {
  final QuoteService _quoteService = QuoteService();

  List<Quote> _allQuotes = [];
  bool _isLoading = false;

  Future<void> loadQuotes({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    final isOnline = await _checkConnectivity();

    try {
      if (isOnline || forceRefresh) {
        _allQuotes = await _quoteService.fetchQuotes();
      } else {
        _allQuotes = []; // Load from cache later
      }
    } catch (e) {
      print("Error loading quotes: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> _checkConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }
}
