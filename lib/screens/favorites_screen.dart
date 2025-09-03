import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quotes_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuotesProvider>(context);
    final favorites = provider.favorites;

    return favorites.isEmpty
        ? const Center(child: Text('No favorite quotes yet.'))
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final quote = favorites[index];
              return Text(quote.quote);
            },
          );
  }
}