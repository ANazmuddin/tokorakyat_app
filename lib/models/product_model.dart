class Product {
  final String id;
  final String name;
  final String price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });

  // Fungsi untuk mengubah Data Firebase (Map) menjadi Object Product
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? 'Tanpa Nama',
      price: map['price'] ?? 'Rp 0',
      image: map['image'] ?? 'https://via.placeholder.com/150', // Gambar default jika kosong
      category: map['category'] ?? 'Umum',
    );
  }
}