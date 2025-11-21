import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spsole/services/user_services.dart';
import 'package:spsole/view/dashboard/dashboard.dart'; // make sure filename is user_service.dart

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final pin = pinController.text.trim();

    if (name.isEmpty) {
      Get.snackbar('Error', 'Please enter your full name');
      return;
    }
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Enter a valid email');
      return;
    }
    if (pin.isEmpty || pin.length != 6) {
      Get.snackbar('Error', 'Enter a 6-digit PIN');
      return;
    }

    try {
      // Create user with email and PIN
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pin);

      final uid = userCredential.user!.uid;

      // Save user info to Firestore
      await UserService.instance.createUser(
        uid: uid,
        name: name,
        email: email,
        pin: pin,
      );

      Get.snackbar('Success', 'User created successfully!');
      Get.off(() => Dashboard());
    } catch (e, stacktrace) {
      Get.snackbar('Error', 'Failed to create user: $e');
      debugPrint('SignUpController Error: $e');
      debugPrintStack(stackTrace: stacktrace);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    pinController.dispose();
    super.onClose();
  }
}
