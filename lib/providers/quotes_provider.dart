
import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class QuotesProvider with ChangeNotifier {
  final QuoteService _quoteService = QuoteService();

  List<Quote> _allQuotes = [];
  List<Quote> get quotes => _allQuotes;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Quote> get favorites =>
      _allQuotes.where((q) => q.isFavorite).toList();
  
  List<int> _favoriteIds = [];

  Future<void> loadQuotes({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    final isOnline = await _checkConnectivity();

    try {
      if (isOnline || forceRefresh) {
        _allQuotes = await _quoteService.fetchQuotes();
        await _quoteService.cacheQuotes(_allQuotes);
      } else {
        _allQuotes = await _quoteService.getCachedQuotes();
      }

      _favoriteIds = await _quoteService.getFavoriteIds();
      for (var quote in _allQuotes) {
        quote.isFavorite = _favoriteIds.contains(quote.id);
      }

      // Apply some Filtering if needed
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

  void toggleFavorite(Quote quote) {
    quote.isFavorite = !quote.isFavorite;

    if (quote.isFavorite) {
      _favoriteIds.add(quote.id);
    } else {
      _favoriteIds.remove(quote.id);
    }

    _quoteService.saveFavorites(
        _allQuotes.where((q) => q.isFavorite).toList());
    notifyListeners();
  }
}
