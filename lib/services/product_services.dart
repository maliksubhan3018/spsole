import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new product under specific user
  Future<void> addProduct({
    required String userId,
    required String name,
    required String category,
    required String description,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("products")
          .add({
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

  // Update product
  Future<void> updateProduct({
    required String userId,
    required String productId,
    required String name,
    required String category,
    required String description,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("products")
          .doc(productId)
          .update({
        'name': name,
        'category': category,
        'description': description,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Product updated");
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  // Delete product
  Future<void> deleteProduct({
    required String userId,
    required String productId,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("products")
          .doc(productId)
          .delete();

      print("Product deleted");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  // Get all products for specific user
  Stream<QuerySnapshot> getProducts(String userId) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("products")
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Get single product by ID
  Future<DocumentSnapshot> getProductById({
    required String userId,
    required String productId,
  }) async {
    return await _firestore
        .collection("users")
        .doc(userId)
        .collection("products")
        .doc(productId)
        .get();
  }
}
