import 'package:http/http.dart' as http;
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
}
