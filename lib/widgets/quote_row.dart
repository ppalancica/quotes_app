import 'package:flutter/material.dart';
import '../models/quote.dart';

class QuoteRow extends StatelessWidget {
  final Quote quote;
  final VoidCallback onFavoriteToggle;

  const QuoteRow({
    super.key,
    required this.quote,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: ListTile(
        title: Text(
          quote.quote,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text('- ${quote.author}'),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}