import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toko_rakyat/models/product_model.dart';

class ProductController {
  // Mengambil referensi koleksi 'products' di Firebase
  final CollectionReference _productCollection =
  FirebaseFirestore.instance.collection('products');

  // Mengambil Data secara Realtime (Stream)
  Stream<List<Product>> getProducts() {
    return _productCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Ubah setiap dokumen Firebase menjadi object Product
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Product.fromMap(doc.id, data);
      }).toList();
    });
  }
}