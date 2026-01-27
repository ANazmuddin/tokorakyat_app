import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Wajib import Provider
import 'package:toko_rakyat/controllers/auth_controller.dart'; // Import Auth Controller
import 'package:toko_rakyat/views/home_page.dart'; // Import Home
import 'package:toko_rakyat/views/register_page.dart'; // Import Register

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil teks inputan user
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Status loading agar tombol tidak diklik 2x
  bool _isLoading = false;

  @override
  void dispose() {
    // Bersihkan memori saat halaman ditutup
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // Pasang kunci validasi
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- BAGIAN HEADER (LOGO & JUDUL) ---
                    const Icon(Icons.storefront, size: 80, color: Colors.blue),
                    const SizedBox(height: 20),
                    const Text(
                      "Selamat Datang!",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Silakan masuk untuk mulai belanja",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),

                    // --- INPUT EMAIL ---
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Contoh: ahmad@gmail.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      // Validasi Email
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- INPUT PASSWORD ---
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Sembunyikan karakter password
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      // Validasi Password
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),

                    // Tombol Lupa Password (Hanya Hiasan Dulu)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Lupa Password?"),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- TOMBOL LOGIN UTAMA ---
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // Jika sedang loading, tombol mati (null)
                        onPressed: _isLoading ? null : () async {
                          // 1. Cek Validasi Form
                          if (_formKey.currentState!.validate()) {

                            // 2. Set Loading Aktif
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              // 3. Panggil Fungsi Login dari AuthController
                              await context.read<AuthController>().login(
                                _emailController.text.trim(), // trim() hapus spasi di ujung
                                _passwordController.text.trim(),
                              );

                              // 4. Jika Berhasil, Pindah ke Home
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              }

                            } catch (e) {
                              // 5. Jika Gagal, Tampilkan Pesan Error
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Login Gagal: $e"),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            } finally {
                              // 6. Matikan Loading (Apapun yang terjadi)
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          }
                        },
                        // Ubah tampilan tombol saat loading
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          "Masuk Sekarang",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- TOMBOL REGISTER ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                          onPressed: () {
                            // Navigasi ke Halaman Register
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            "Daftar Disini",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}