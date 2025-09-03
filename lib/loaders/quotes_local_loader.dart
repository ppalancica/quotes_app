import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quote.dart';

class QuotesLocalLoader {

  Future<void> cacheQuotes(List<Quote> quotes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonQuotes = quotes
      .map((quote) => json.encode(quote.toJson()))
      .toList();
    await prefs.setStringList('cached_quotes', jsonQuotes);
  }

  Future<List<Quote>> getCachedQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonQuotes = prefs.getStringList('cached_quotes') ?? [];
    return jsonQuotes
      .map((q) => Quote.fromJson(json.decode(q)))
      .toList();
  }
}
