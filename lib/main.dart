import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Import Firebase
import 'package:toko_rakyat/firebase_options.dart'; // 2. Import Options yang baru dibuat
import 'package:toko_rakyat/controllers/cart_controller.dart';
import 'package:toko_rakyat/views/login_page.dart';
import 'package:toko_rakyat/controllers/auth_controller.dart';

// 3. Ubah main() jadi async
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib ada jika main() async

  // 4. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Rakyat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}