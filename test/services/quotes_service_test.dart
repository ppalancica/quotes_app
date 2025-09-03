import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/services/quotes_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'quotes_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('fetchQuotes returns list of Quote from API', () async {
    final client = MockClient();
    final service = QuotesService();

    final responseJson = jsonEncode({
      "quotes": [
        {
          "id": 1,
          "quote": "Be yourself.",
          "author": "Oscar Wilde"
        }
      ]
    });

    when(client.get(Uri.parse('https://dummyjson.com/quotes')))
        .thenAnswer((_) async => http.Response(responseJson, 200));

    final quotes = await service.fetchQuotes();
    expect(quotes, isA<List<Quote>>());
    expect(quotes.first.quote, "Be yourself.");
  });
}