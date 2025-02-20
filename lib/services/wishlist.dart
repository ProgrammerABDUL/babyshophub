import 'package:shared_preferences/shared_preferences.dart';

class WishlistService {
  static const _key = 'wishlist';

  static Future<void> saveItem(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getItems();
    items.add(productId);
    await prefs.setStringList(_key, items);
  }

  static Future<List<String>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> removeItem(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getItems();
    items.remove(productId);
    await prefs.setStringList(_key, items);
  }
}
