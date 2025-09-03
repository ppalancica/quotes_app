import 'package:flutter_test/flutter_test.dart';
import 'package:quotes_app/models/quote.dart';

void main() {
  test('Quote model should serialize and deserialize correctly', () {
    final quote = Quote(id: 1, quote: 'Be yourself.', author: 'Oscar Wilde');

    final json = quote.toJson();
    final fromJson = Quote.fromJson(json);

    expect(fromJson.id, 1);
    expect(fromJson.quote, 'Be yourself.');
    expect(fromJson.author, 'Oscar Wilde');
    expect(fromJson.isFavorite, false);
  });
}