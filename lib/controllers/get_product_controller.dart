import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetProductController {
  // TextEditingControllers for product fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "products";

  // Loading state (optional)
  bool isLoading = false;

  // Add product to Firestore
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
      isLoading = true;

      await _firestore.collection(collectionName).add({
        'name': name,
        'category': category,
        'description': description,
        'price': 0, // Optional field
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Clear fields after success
      nameController.clear();
      categoryController.clear();
      descriptionController.clear();

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
    } finally {
      isLoading = false;
    }
  }

  // Fetch all products from Firestore
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collectionName)
          .orderBy('createdAt', descending: true)
          .get();

      // Convert each document to a map
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID if needed
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  // Dispose controllers when not needed
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
  }
}
