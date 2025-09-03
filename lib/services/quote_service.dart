import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quote.dart';

class QuoteService {
  static const _apiUrl = 'https://dummyjson.com/quotes';

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final List quotesJson = json.decode(response.body)['quotes'];
      final List<Quote> quotes =
          quotesJson.map((q) => Quote.fromJson(q)).toList();
      return quotes;
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  Future<void> saveFavorites(List<Quote> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = favorites.map((q) => q.id.toString()).toList();
    await prefs.setStringList('favorite_ids', ids);
  }

  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorite_ids') ?? [];
    return ids.map(int.parse).toList();
  }
}
