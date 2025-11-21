import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserService {
  UserService._privateConstructor();
  static final UserService instance = UserService._privateConstructor();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user document in Firestore
  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    String? pin,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'pin': pin ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e, stacktrace) {
      debugPrint('UserService Error: Failed to create user: $e');
      debugPrintStack(stackTrace: stacktrace);
      throw Exception('Failed to create user: $e');
    }
  }
}
