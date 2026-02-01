import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';
import 'package:toko_rakyat/views/login_page.dart';
import 'package:toko_rakyat/views/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() {
    // 1. Ambil user yang sedang aktif dari Controller
    final user = context.read<AuthController>().currentUser;

    // 2. Logika Pengecekan
    if (user != null) {
      // JIKA SUDAH LOGIN -> Masuk ke Main (Home)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      // JIKA BELUM LOGIN -> Masuk ke Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Toko Rakyat",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Belanja Murah & Mudah",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}