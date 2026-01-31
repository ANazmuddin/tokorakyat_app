import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/cart_controller.dart';
import 'package:toko_rakyat/controllers/product_controller.dart'; 
import 'package:toko_rakyat/models/product_model.dart';
import 'package:toko_rakyat/views/cart_page.dart';
import 'package:toko_rakyat/views/detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Panggil Controller Produk
  final ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Toko Rakyat", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              ),
              Consumer<CartController>(
                builder: (context, controller, child) {
                  if (controller.itemCount == 0) return const SizedBox();
                  return Positioned(
                    right: 8, top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text(controller.itemCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Koleksi Terbaru", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Temukan produk impian Anda sekarang", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // --- BAGIAN UTAMA: STREAM BUILDER ---
            Expanded(
              child: StreamBuilder<List<Product>>(
                stream: _productController.getProducts(), // Minta data ke Firebase
                builder: (context, snapshot) {
                  // 1. Jika Error
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  // 2. Jika Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 3. Jika Data Kosong
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Belum ada produk."));
                  }

                  // 4. Jika Data Ada -> Tampilkan Grid
                  final products = snapshot.data!;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final produk = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(product: produk)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.network(
                                  produk.image,
                                  height: 150, width: double.infinity, fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stack) => Container(height: 150, color: Colors.grey[200], child: const Icon(Icons.broken_image)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(produk.category, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                                    const SizedBox(height: 4),
                                    Text(produk.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 8),
                                    Text(produk.price, style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 15)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}