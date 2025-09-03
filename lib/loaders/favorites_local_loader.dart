import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';

class FavoritesLocalLoader {

  Future<void> saveFavorites(List<Quote> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = favorites.map((q) => q.id.toString()).toList();
    await prefs.setStringList('favorite_ids', ids);
  }

  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorite_ids') ?? [];
    return ids.map(int.parse).toList();
  }
}
