import 'package:flutter/material.dart';
import 'package:toko_rakyat/models/product_model.dart';

class CartController extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;
  int get itemCount => _items.length;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // --- LOGIKA BARU: MENGHITUNG TOTAL HARGA ---

  // 1. Fungsi mengubah "Rp 2.100.000" menjadi angka 2100000
  int _parsePrice(String priceString) {
    // Hapus semua karakter yang bukan angka
    String cleanString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }

  // 2. Menghitung Total Belanja
  String get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += _parsePrice(item.price);
    }
    // Mengembalikan format Rupiah (Contoh: "Rp 2.250.000")
    return "Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }
}