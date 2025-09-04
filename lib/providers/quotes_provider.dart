import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quotes_service.dart';
import '../loaders/quotes_local_loader.dart';
import '../loaders/favorites_local_loader.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class QuotesProvider with ChangeNotifier {
  
  final QuotesService _quoteService = QuotesService();
  final QuotesLocalLoader _quotesLocalLoader = QuotesLocalLoader();
  final FavoritesLocalLoader _favoritesLocalLoader = FavoritesLocalLoader();

  List<Quote> _allQuotes = [];
  List<Quote> _filteredQuotes = [];
  List<int> _favoriteIds = [];

  bool _isLoading = false;
  String _searchQuery = '';  

  List<Quote> get quotes => _filteredQuotes;

  List<Quote> get favorites =>
      _allQuotes.where((q) => q.isFavorite).toList();
  
  bool get isLoading => _isLoading;

  Future<void> loadQuotes({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    final isOnline = await _checkConnectivity();

    try {
      if (isOnline || forceRefresh) {
        _allQuotes = await _quoteService.fetchQuotes();
        await _quotesLocalLoader.cacheQuotes(_allQuotes);
      } else {
        _allQuotes = await _quotesLocalLoader.getCachedQuotes();
      }

      _favoriteIds = await _favoritesLocalLoader.getFavoriteIds();
      for (var quote in _allQuotes) {
        quote.isFavorite = _favoriteIds.contains(quote.id);
      }

      _applyFilter();
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

    _favoritesLocalLoader.saveFavorites(
        _allQuotes.where((q) => q.isFavorite).toList());
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredQuotes = [..._allQuotes];
    } else {
      _filteredQuotes = _allQuotes.where((quote) {
        return quote.quote
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            quote.author
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilter();
    notifyListeners();
  }

  void resetFromSearchModeToNormalMode() {
    updateSearchQuery('');
  }
}
