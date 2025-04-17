import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:quan_ly_muc/model/item_model.dart';


Future<void> saveItems(List<Item> items) async {
  final prefs = await SharedPreferences.getInstance();
  final itemsJson = jsonEncode(items.map((item) => item.toJson()).toList());
  prefs.setString('items', itemsJson);
}

Future<List<Item>> loadItems() async {
  final prefs = await SharedPreferences.getInstance();
  final itemsJson = prefs.getString('items');
  if (itemsJson != null) {
    final List<dynamic> itemsList = jsonDecode(itemsJson);
    return itemsList.map((item) => Item.fromJson(item)).toList();
  }
  return [];
}
