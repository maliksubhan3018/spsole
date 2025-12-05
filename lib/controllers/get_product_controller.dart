// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch only products for current logged-in user
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('products')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> streamProducts() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList(),
        );
  }
}
