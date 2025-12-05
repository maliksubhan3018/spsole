// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController(); // Added
  final TextEditingController descriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Submit product into that user's collection
  Future<void> submitProduct(BuildContext context) async {
    String name = nameController.text.trim();
    String category = categoryController.text.trim();
    String price = priceController.text.trim(); // Added
    String description = descriptionController.text.trim();

    if (name.isEmpty || category.isEmpty || price.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("products")
          .add({
        'name': name,
        'category': category,
        'price': price, // Added
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Clear text fields
      nameController.clear();
      categoryController.clear();
      priceController.clear(); // Added
      descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error adding product: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose(); // Added
    descriptionController.dispose();
  }
}
