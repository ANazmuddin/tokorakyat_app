import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';
import 'package:toko_rakyat/views/history_page.dart';
import 'package:toko_rakyat/views/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user yang sedang login dari Controller
    final user = context.read<AuthController>().currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 1. FOTO PROFIL (Avatar Dummy)
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // 2. INFO USER
              Text(
                user?.email ?? "Tamu", // Menampilkan email user
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text("Member Setia", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 40),

              // 3. MENU: RIWAYAT PESANAN
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Riwayat Pesanan"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigasi ke Halaman History
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
              ),
              const Divider(),

              // 4. MENU: PENGATURAN (Dummy)
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Pengaturan Akun"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fitur Pengaturan segera hadir!")),
                  );
                },
              ),

              const Spacer(), // Mendorong tombol logout ke bawah

              // 5. TOMBOL LOGOUT
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50], // Latar belakang merah muda
                    foregroundColor: Colors.red,     // Teks & Ikon merah
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    // Proses Logout dari Firebase
                    await context.read<AuthController>().logout();

                    // Kembali ke Halaman Login & hapus jejak navigasi sebelumnya
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Keluar Aplikasi"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}