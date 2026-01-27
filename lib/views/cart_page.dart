import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Keranjang Saya", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              // Tombol hapus semua (opsional)
              context.read<CartController>().clearCart();
            },
          )
        ],
      ),
      // Menggunakan Consumer agar halaman ini selalu update jika ada barang masuk/keluar
      body: Consumer<CartController>(
        builder: (context, controller, child) {
          // KONDISI 1: Jika Keranjang Kosong
          if (controller.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text("Keranjang masih kosong", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Mulai Belanja"),
                  )
                ],
              ),
            );
          }

          // KONDISI 2: Jika Ada Barang
          return Column(
            children: [
              // DAFTAR BARANG
              Expanded(
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final produk = controller.items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(produk.image, width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        title: Text(produk.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(produk.price, style: TextStyle(color: Colors.blue[800])),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            // Hapus barang spesifik
                            controller.removeItem(produk);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              // BAGIAN BAWAH (TOTAL HARGA & CHECKOUT)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Harga", style: TextStyle(fontSize: 16, color: Colors.grey)),
                        Text(
                          controller.totalPrice, // Mengambil total dari Controller
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          // Nanti disambungkan ke Payment Gateway / Firebase
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fitur Checkout akan segera hadir!")),
                          );
                        },
                        child: const Text("Checkout Sekarang", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}