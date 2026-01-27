import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Wajib import ini
import 'package:toko_rakyat/controllers/cart_controller.dart';
import 'package:toko_rakyat/models/product_model.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Gambar Background Full
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Tombol Navigasi Atas
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Panel Informasi Bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50, height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          product.price,
                          style: TextStyle(fontSize: 20, color: Colors.blue[800], fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(product.category, style: const TextStyle(color: Colors.grey)),

                    const SizedBox(height: 20),
                    const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    const Text(
                      "Produk kualitas premium ini dirancang untuk menunjang gaya hidup modern Anda. Terbuat dari bahan pilihan yang awet dan nyaman digunakan sehari-hari.",
                      style: TextStyle(color: Colors.black54, height: 1.5),
                    ),

                    const Spacer(),

                    // TOMBOL BELI YANG AKTIF
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          // LOGIKA PENYIMPANAN DATA
                          context.read<CartController>().addItem(product);

                          // Notifikasi Sukses
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Berhasil masuk keranjang!"),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: const Text("Tambah ke Keranjang", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}