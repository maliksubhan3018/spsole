// lib/screens/add_product.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/controllers/product_controller.dart';
import 'package:spsole/widgets/appbar.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/customtextfield.dart';
import 'package:spsole/widgets/mycolors.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductController productController = Get.put(ProductController());

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: CustomAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              label: 'Product Name',
              hintText: 'Enter product name',
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Category',
              hintText: 'Enter product category',
              controller: categoryController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Price',
              hintText: 'Enter product price',
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Description',
              hintText: 'Enter product description',
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 30),
            Button(
              text: 'Add Product',
              onPressed: () async {
                final String name = nameController.text.trim();
                final String category = categoryController.text.trim();
                final String price = priceController.text.trim();
                final String description = descriptionController.text.trim();

                if (name.isEmpty ||
                    category.isEmpty ||
                    price.isEmpty ||
                    description.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please fill all fields',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  return;
                }

                // Add product to Firestore and include userId
                await productController.addProduct(
                  name: name,
                  category: category,
                  price: price,
                  description: description,
                );

                // Clear input fields
                nameController.clear();
                categoryController.clear();
                priceController.clear();
                descriptionController.clear();

                // Immediately update Products list
                productController.fetchProducts();

                // Navigate back to Products screen
                // Get.back();
                Get.toNamed(MyPagesName.products);
              },
            ),
          ],
        ),
      ),
    );
  }
}
