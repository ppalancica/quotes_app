import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quotes_provider.dart';
import 'screens/quotes_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuotesProvider()..loadQuotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quotes Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const QuotesHomePage(title: "Quotes"),
      ),
    );
  }
}

class QuotesHomePage extends StatefulWidget {
  const QuotesHomePage({super.key, required this.title});

  final String title;

  @override
  State<QuotesHomePage> createState() => _QuotesHomePageState();
}

class _QuotesHomePageState extends State<QuotesHomePage> {
  int _currentIndex = 0;

  final _screens = const [
    QuotesScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}