import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';
import 'package:toko_rakyat/views/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Untuk efek loading muter-muter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
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

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (val) => val!.contains('@') ? null : "Email tidak valid",
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (val) => val!.length < 6 ? "Minimal 6 karakter" : null,
                ),
                const SizedBox(height: 30),

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
                        setState(() => _isLoading = true); // Mulai loading
                        try {
                          // Panggil fungsi REGISTER di Controller
                          await context.read<AuthController>().register(
                            _emailController.text,
                            _passwordController.text,
                          );

                          // Jika sukses, langsung masuk ke Home
                          if (mounted) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                          }
                        } catch (e) {
                          // Jika gagal, munculkan pesan error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
                        } finally {
                          if (mounted) setState(() => _isLoading = false); // Stop loading
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