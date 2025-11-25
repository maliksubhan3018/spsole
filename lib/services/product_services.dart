import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "products";

  // Add a new product
  Future<void> addProduct({
    required String name,
    required String category,
    required String description,
  }) async {
    try {
      await _firestore.collection(collectionName).add({
        'name': name,
        'category': category,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Product added successfully");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  // Update existing product by document ID
  Future<void> updateProduct({
    required String productId,
    required String name,
    required String category,
    required String description,
  }) async {
    try {
      await _firestore.collection(collectionName).doc(productId).update({
        'name': name,
        'category': category,
        'description': description,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Product updated successfully");
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  // Delete a product by document ID
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(collectionName).doc(productId).delete();
      print("Product deleted successfully");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  // Get all products as a stream
  Stream<QuerySnapshot> getProducts() {
    return _firestore.collection(collectionName).orderBy('createdAt', descending: true).snapshots();
  }

  // Get a single product by ID
  Future<DocumentSnapshot> getProductById(String productId) async {
    return await _firestore.collection(collectionName).doc(productId).get();
  }
}
