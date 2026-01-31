import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil ID user yang sedang login
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Riwayat Pesanan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // QUERY PENTING: Ambil data dari 'orders' DIMANA userId == uid saya
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Belum ada riwayat belanja", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // Data ditemukan
          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final order = orders[index];
              final data = order.data() as Map<String, dynamic>;

              // Ambil daftar barang di dalam order tersebut
              final List<dynamic> items = data['items'] ?? [];
              final firstItemName = items.isNotEmpty ? items[0]['name'] : 'Barang';
              final otherItemsCount = items.length - 1;

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Status & Tanggal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              data['status'] ?? 'Diproses',
                              style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Text(
                            "Order ID: ...${order.id.substring(order.id.length - 6)}", // Tampilkan 6 digit terakhir ID
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(height: 20),

                      // Body: Barang yang dibeli
                      Text(
                        items.length > 1
                            ? "$firstItemName (+ $otherItemsCount barang lainnya)"
                            : firstItemName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text("Total Belanja: ${data['totalPrice']}", style: const TextStyle(color: Colors.grey)),

                      // Footer: Tombol Detail (Opsional)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}