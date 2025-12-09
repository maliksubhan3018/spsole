import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch all products for current user (Future)
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return [];

      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('userId', isEqualTo: uid)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return {
          'id': doc.id,
          'name': data['name']?.toString() ?? 'No Name',
          'category': data['category']?.toString() ?? 'No Category',
          'price': data['price']?.toString() ?? '0',
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }

  // Stream products of current user
  Stream<List<Map<String, dynamic>>> streamProducts() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('products')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return {
          'id': doc.id,
          'name': data['name']?.toString() ?? 'No Name',
          'category': data['category']?.toString() ?? 'No Category',
          'price': data['price']?.toString() ?? '0',
        };
      }).toList();
    });
  }

  // Add product
  Future<void> addProduct({
    required String name,
    required String price,
    required String description,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      double priceValue = double.tryParse(price) ?? 0.0;

      await _firestore.collection('products').add({
        'name': name,
        'price': priceValue,
        'description': description,
        'userId': uid, // MUST match rules
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      final docRef = _firestore.collection('products').doc(productId);
      final doc = await docRef.get();

      if (doc.exists && doc['userId'] == uid) {
        await docRef.delete();
        Get.snackbar('Deleted', 'Product removed successfully');
      } else {
        Get.snackbar('Error', 'You are not allowed to delete this product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
