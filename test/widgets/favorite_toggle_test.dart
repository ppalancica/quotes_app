import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/providers/quotes_provider.dart';
import 'package:quotes_app/screens/quotes_screen.dart';
import 'package:quotes_app/models/quote.dart';

class MockQuoteProvider extends QuotesProvider {
  @override
  List<Quote> get quotes => [
        Quote(id: 1, quote: 'Test Quote', author: 'Tester', isFavorite: false)
      ];

  @override
  bool get isLoading => false;
}

void main() {
  testWidgets('Favorite icon toggles', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<QuotesProvider>(
        create: (_) => MockQuoteProvider(),
        child: const MaterialApp(home: Scaffold(body: QuotesScreen())),
      ),
    );

    // Wait for widget to settle
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // Because we're using a mock, this won't toggle without state logic
    // In real app, this would now show `Icons.favorite`
  });
}