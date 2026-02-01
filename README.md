```markdown
# Toko Rakyat 🛒

**Toko Rakyat** adalah aplikasi mobile e-commerce sederhana namun *full-stack* yang dibangun menggunakan **Flutter** dan **Firebase**. Aplikasi ini mencakup siklus bisnis lengkap mulai dari autentikasi pengguna, penelusuran produk, manajemen keranjang, hingga riwayat pemesanan.

Proyek ini dibuat sebagai demonstrasi kemampuan pengembangan aplikasi Android dengan integrasi backend real-time.

## 📱 Fitur Utama

* **Splash Screen & Auto Login:** Pengecekan sesi pengguna otomatis saat aplikasi dibuka.
* **Autentikasi Pengguna:** Login dan Register menggunakan Email & Password (Firebase Auth).
* **Katalog Produk Real-time:** Menampilkan data produk langsung dari Cloud Firestore.
* **Pencarian & Filter:** Cari produk berdasarkan nama dan filter berdasarkan kategori (Sepatu, Outdoor, dll).
* **Keranjang Belanja (State Management):** Menambah barang dan menghitung total harga secara dinamis.
* **Checkout System:** Menyimpan pesanan ke database dan mengosongkan keranjang.
* **Riwayat Pesanan:** Melihat daftar belanjaan yang pernah dilakukan oleh pengguna yang sedang login.
* **Profil Pengguna:** Menampilkan info user dan fitur Logout.

## 🛠️ Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Firebase (Authentication, Cloud Firestore)
* **State Management:** Provider
* **Architecture:** MVC (Model-View-Controller) pattern

## 📋 Prasyarat

Sebelum menjalankan proyek ini, pastikan komputer Anda sudah terinstal:

1.  **Flutter SDK** (Versi terbaru stabil)
2.  **Git**
3.  **Android Studio / VS Code**
4.  **Akun Google** (Untuk akses Firebase Console)

## 🚀 Cara Menjalankan (Installation)

Ikuti langkah-langkah berikut untuk menjalankan aplikasi di komputer lokal Anda:

### 1. Clone Repository
```bash
git clone [https://github.com/ANazmuddin/tokorakyat_app.git]
cd toko_rakyat

```

### 2. Install Dependencies

Download semua library yang dibutuhkan (Provider, Firebase, dll):

```bash
flutter pub get

```

### 3. Konfigurasi Firebase (Penting!)

Karena alasan keamanan, file konfigurasi Firebase tidak disertakan. Anda perlu menghubungkan ke project Firebase Anda sendiri:

1. Buka [Firebase Console](https://console.firebase.google.com/).
2. Buat project baru (misal: `toko-rakyat-db`).
3. Aktifkan **Authentication**: Pilih *Sign-in method* -> *Email/Password* -> *Enable*.
4. Aktifkan **Firestore Database**: Pilih *Create Database* -> *Start in Test Mode*.
5. Di terminal komputer Anda, jalankan:
```bash
flutterfire configure

```


*(Pilih project yang baru Anda buat tadi).*

### 4. Isi Data Dummy (Seeding Database)

Agar aplikasi tidak kosong, isi data produk di Firestore Database Anda secara manual:

* Buat Collection baru bernama: **`products`**
* Tambahkan Document dengan field berikut:
* `name` (string): Contoh "Sepatu Keren"
* `price` (string): Contoh "Rp 500.000"
* `category` (string): Contoh "Sepatu" (Pilihan: Sepatu, Outdoor, Aksesoris, Pakaian)
* `image` (string): URL gambar (bisa pakai link dari Unsplash/Google)



### 5. Jalankan Aplikasi

Pastikan Emulator Android sudah nyala atau HP fisik tercolok.

```bash
flutter run

```

## 📂 Struktur Folder

```
lib/
├── controllers/      # Logika Bisnis (Cart, Auth, Product)
├── models/           # Struktur Data (Product Model)
├── views/            # Tampilan UI (Halaman-halaman)
│   ├── login_page.dart
│   ├── home_page.dart
│   ├── cart_page.dart
│   └── ...
└── main.dart         # Entry point & Setup Provider

```

## 🤝 Kontribusi

Jika Anda ingin menambahkan fitur baru atau memperbaiki bug, silakan buat *Pull Request*. Ide pengembangan selanjutnya:

* Integrasi Payment Gateway (Midtrans/Xendit).
* Fitur Edit Profil & Upload Foto.
* Halaman Admin untuk tambah produk lewat aplikasi.

---

Dibuat dengan ❤️ menggunakan Flutter.

```

***

### Tips Tambahan untuk Anda:
1.  **Upload ke GitHub:** Setelah membuat file ini, sangat disarankan untuk meng-upload seluruh kodingan Anda ke GitHub.
    * `git init`
    * `git add .`
    * `git commit -m "Aplikasi Toko Rakyat Selesai"`
    * `git push` (ke repository github Anda).
2.  **Screenshots:** Jika nanti Anda upload ke GitHub, ambil screenshot aplikasi (Halaman Login, Home, Keranjang) lalu tempel di file README agar orang bisa melihat visualnya tanpa harus install dulu.

Selamat! Anda sekarang memiliki portofolio Full Stack Mobile App yang solid. Ada lagi yang bisa saya bantu?

```