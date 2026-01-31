import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';
import 'package:toko_rakyat/views/main_page.dart'; 

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Buat Akun Baru", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Text("Daftar sekarang untuk mulai belanja", style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 30),

                // INPUT EMAIL
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (val) => val != null && val.contains('@') ? null : "Email tidak valid",
                ),
                const SizedBox(height: 20),

                // INPUT PASSWORD
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (val) => val != null && val.length < 6 ? "Minimal 6 karakter" : null,
                ),
                const SizedBox(height: 30),

                // TOMBOL DAFTAR
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
                          // PROSES REGISTER
                          await context.read<AuthController>().register(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          // JIKA SUKSES -> KE MAIN PAGE (Menu Bawah)
                          if (mounted) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const MainPage())
                            );
                          }
                        } catch (e) {
                          // JIKA GAGAL
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Gagal: $e"), backgroundColor: Colors.red),
                            );
                          }
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      }
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Daftar Sekarang", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}