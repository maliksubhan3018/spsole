import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController {
  // TextEditingControllers for product fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "products"; // your Firestore collection

  // Function to add product to Firestore and show snackbar
  Future<void> submitProduct(BuildContext context) async {
    String name = nameController.text.trim();
    String category = categoryController.text.trim();
    String description = descriptionController.text.trim();

    if (name.isEmpty || category.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _firestore.collection(collectionName).add({
        'name': name,
        'category': category,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("Product added to Firestore successfully");

      // Clear text fields
      nameController.clear();
      categoryController.clear();
      descriptionController.clear();

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error adding product: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error adding product: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Dispose controllers when not needed
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
  }
}
