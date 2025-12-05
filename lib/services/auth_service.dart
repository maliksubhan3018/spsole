// lib/services/auth_service.dart
// ignore_for_file: unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/widgets/mycolors.dart';

class AuthService {
  // Singleton
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpWithEmailAndPin({
    required String email,
    required String pin,
  }) async {
    try {
      Get.snackbar(
        'Creating Account...',
        'Please wait',
        duration: const Duration(seconds: 2),
      );

      // Simple Firebase signup (no Firestore)
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: pin,
      );

      User? user = result.user;

      if (user != null) {
        Get.offAllNamed(MyPagesName.dashboard);

        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: AppColors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Print exact error in terminal
      print("===== AUTH SIGNUP ERROR =====");
      print("Code       : ${e.code}");
      print("Message    : ${e.message}");
      print("Exception  : $e");
      print("==================================");

      final errorMessages = {
        'weak-password': 'PIN is too weak. Use 6 digits.',
        'email-already-in-use': 'This email is already registered.',
        'invalid-email': 'Invalid email address.',
      };

      final message = errorMessages[e.code] ?? 'Sign up failed. Try again.';

      Get.snackbar('Error', message, backgroundColor: AppColors.primary);
    } catch (e) {
      print("Unexpected ERROR → $e");
      Get.snackbar(
        'Error',
        'Something went wrong.',
        backgroundColor: AppColors.primary,
      );
    }
  }

  /// Login with Email + 6-digit PIN
  Future<void> loginWithEmailAndPin({
    required String email,
    required String pin,
  }) async {
    if (email.isEmpty || pin.isEmpty || pin.length != 6) {
      Get.snackbar('Invalid Input', 'Enter valid email and 6-digit PIN');
      return;
    }

    try {
      Get.snackbar(
        'Signing in...',
        'Please wait',
        duration: const Duration(seconds: 2),
      );

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: pin,
      );

      Get.offAllNamed(MyPagesName.dashboard);
      Get.snackbar(
        'Success',
        'Logged in successfully!',
        backgroundColor: Get.theme.primaryColor,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect PIN.';
          break;
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try again later.';
          break;
        default:
          message = 'Login failed. Please try again.';
      }
      Get.snackbar('Login Failed', message, backgroundColor: AppColors.primary);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong.',
        backgroundColor: AppColors.primary,
      );
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
