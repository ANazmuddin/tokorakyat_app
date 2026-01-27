import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/cart_controller.dart';
import 'package:toko_rakyat/models/product_model.dart';
import 'package:toko_rakyat/views/detail_page.dart';
import 'package:toko_rakyat/views/cart_page.dart'; // IMPORT PENTING: Panggil halaman keranjang

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Data Produk Dummy
  final List<Product> listProduk = [
    Product(
      name: "Sepatu Ultraboost Running",
      price: "Rp 2.100.000",
      category: "Sepatu",
      image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=500&auto=format&fit=crop",
    ),
    Product(
      name: "Tas Carrier Gunung 45L",
      price: "Rp 850.000",
      category: "Outdoor",
      image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=500&auto=format&fit=crop",
    ),
    Product(
      name: "Kacamata Hitam Polarized",
      price: "Rp 150.000",
      category: "Aksesoris",
      image: "https://images.unsplash.com/photo-1572635196237-14b3f281503f?q=80&w=500&auto=format&fit=crop",
    ),
    Product(
      name: "Jaket Denim Vintage",
      price: "Rp 450.000",
      category: "Pakaian",
      image: "https://images.unsplash.com/photo-1576995853123-5a10305d93c0?q=80&w=500&auto=format&fit=crop",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Toko Rakyat",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          // --- BAGIAN ICON KERANJANG ---
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                // PERUBAHAN DISINI: Navigasi ke Halaman Keranjang
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              ),
              // Notifikasi Angka Merah (Badge)
              Consumer<CartController>(
                builder: (context, controller, child) {
                  if (controller.itemCount == 0) return const SizedBox();

                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        controller.itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
            const Text(
              "Koleksi Terbaru",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Temukan produk impian Anda sekarang",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // GridView Produk
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6, // Rasio aman anti garis kuning
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: listProduk.length,
                itemBuilder: (context, index) {
                  final produk = listProduk[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(product: produk),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar Produk
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              produk.image,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                  height: 150, color: Colors.grey[200], child: const Icon(Icons.broken_image)
                              ),
                            ),
                          ),
                          // Info Produk
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produk.category,
                                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  produk.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  produk.price,
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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