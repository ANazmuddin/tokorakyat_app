import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  int _parsePrice(String priceString) {
    String cleanString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }

  String get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += _parsePrice(item.price);
    }
    return "Rp ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  Future<void> checkout(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw "Anda harus login untuk checkout!";
    }

    if (_items.isEmpty) {
      throw "Keranjang kosong!";
    }

    List<Map<String, dynamic>> orderItems = _items.map((item) => {
      'name': item.name,
      'price': item.price,
      'image': item.image,
    }).toList();

    await FirebaseFirestore.instance.collection('orders').add({
      'userId': user.uid,                  // ID Pembeli
      'userEmail': user.email,             // Email Pembeli
      'items': orderItems,                 // Barang yang dibeli
      'totalPrice': totalPrice,            // Total Bayar
      'status': 'Diproses',                // Status awal
      'createdAt': FieldValue.serverTimestamp(), // Waktu transaksi
    });

    clearCart();
  }
}