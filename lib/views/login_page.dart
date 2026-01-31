import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';
import 'package:toko_rakyat/views/main_page.dart';
import 'package:toko_rakyat/views/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LOGO & JUDUL
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

                    // INPUT EMAIL
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Contoh: ahmad@gmail.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Email wajib diisi';
                        if (!value.contains('@')) return 'Format email salah';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // INPUT PASSWORD
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) return 'Minimal 6 karakter';
                        return null;
                      },
                    ),

                    // LUPA PASSWORD (HIASAN)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {}, child: const Text("Lupa Password?")),
                    ),
                    const SizedBox(height: 20),

                    // TOMBOL LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: _isLoading ? null : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              // PROSES LOGIN
                              await context.read<AuthController>().login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );

                              // JIKA SUKSES -> KE MAIN PAGE (Menu Bawah)
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainPage()),
                                );
                              }
                            } catch (e) {
                              // JIKA GAGAL
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Masuk Sekarang", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // LINK KE REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text("Daftar Disini", style: TextStyle(fontWeight: FontWeight.bold)),
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