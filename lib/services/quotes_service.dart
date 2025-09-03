import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quote.dart';

class QuotesService {
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
