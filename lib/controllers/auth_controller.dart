import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Cek apakah user sudah login atau belum (untuk auto-login nanti)
  User? get currentUser => _auth.currentUser;

  // 1. Fungsi LOGIN (Masuk)
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners(); // Kabari aplikasi kalau login berhasil
    } on FirebaseAuthException catch (e) {
      // Jika gagal (misal password salah), lempar error agar bisa ditangkap UI
      throw e.message ?? "Login gagal";
    }
  }

  // 2. Fungsi REGISTER (Daftar Baru)
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Registrasi gagal";
    }
  }

  // 3. Fungsi LOGOUT (Keluar)
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}