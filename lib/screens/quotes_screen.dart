import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/providers/quotes_provider.dart';
import '../widgets/quote_row.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);

    return RefreshIndicator(
      onRefresh: () => provider.loadQuotes(forceRefresh: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by text or author',
                border: OutlineInputBorder(),
              ),
              onChanged: provider.updateSearchQuery,
              onSubmitted: (value) {
                provider.resetListViewToNormalState();
                _searchController.clear();
              },
            ),
          ),
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