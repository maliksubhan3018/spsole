// lib/controllers/product_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Add a new product to Firestore
  Future<void> addProduct({
    required String name,
    required String category,
    required String price,
    required String description,
  }) async {
    if (currentUser == null) {
      Get.snackbar('Error', 'You must be logged in to add a product');
      return;
    }

    try {
      double priceValue = double.tryParse(price) ?? 0.0;

      await _firestore.collection('products').add({
        'name': name,
        'category': category,
        'price': priceValue,
        'description': description,
        'userId': currentUser!.uid,
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Product added successfully');

      // Refresh local list
      await fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// Fetch products from Firestore
  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();

      products.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': data['name'] ?? '',
          'category': data['category'] ?? '',
          'price': (data['price'] ?? 0).toString(),
          'description': data['description'] ?? '',
          'userId': data['userId'] ?? '',
          'created_at': data['created_at'] ?? null,
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// Stream products for real-time updates
  Stream<List<Map<String, dynamic>>> streamProducts() {
    return _firestore
        .collection('products')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'name': data['name'] ?? '',
          'category': data['category'] ?? '',
          'price': (data['price'] ?? 0).toString(),
          'description': data['description'] ?? '',
          'userId': data['userId'] ?? '',
          'created_at': data['created_at'] ?? null,
        };
      }).toList();
    });
  }

  /// Delete a product safely
  Future<void> deleteProduct(String id) async {
    try {
      final doc = await _firestore.collection('products').doc(id).get();
      if (doc.exists && doc['userId'] == currentUser?.uid) {
        await _firestore.collection('products').doc(id).delete();
        Get.snackbar('Deleted', 'Product removed successfully');
        await fetchProducts();
      } else {
        Get.snackbar('Error', 'You are not authorized to delete this product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
