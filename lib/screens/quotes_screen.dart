import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/providers/quotes_provider.dart';
import '../widgets/quote_row.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);

    return RefreshIndicator(
      onRefresh: () => provider.loadQuotes(forceRefresh: true),
      child: Column(
        children: [
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.quotes.isEmpty
                    ? const Center(child: Text('No quotes found'))
                    : ListView.builder(
                        itemCount: provider.quotes.length,
                        itemBuilder: (context, index) {
                          final quote = provider.quotes[index];
                          return QuoteRow(
                            quote: quote,
                            onFavoriteToggle: () =>
                                provider.toggleFavorite(quote),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}