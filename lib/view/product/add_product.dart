// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spsole/controllers/product_controller.dart';
import 'package:spsole/widgets/appbar.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/mycolors.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductController controller = ProductController();

  @override
  void dispose() {
    controller.dispose(); // Dispose all controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: CustomAppBar(
        title: 'Add Products',
        showBackButton: true,
        showPlusButton: false,
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Name'),
            _buildSimpleTextField(
              controller.nameController,
              hint: 'Product title',
            ),

            const SizedBox(height: 20),
            _buildLabel('Category'),
            _buildSimpleTextField(
              controller.categoryController,
              hint: 'Category',
            ),

            const SizedBox(height: 20),
            _buildLabel('Price'),
            _buildSimpleTextField(
              controller.priceController,
              hint: 'Price',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            _buildLabel('Description'),
            _buildSimpleTextField(
              controller.descriptionController,
              hint: 'Description',
              maxLines: 3,
            ),

            const SizedBox(height: 40),
            Center(
              child: Button(
                text: 'Add',
                onPressed: () {
                  controller.submitProduct(context);
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.surface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSimpleTextField(
    TextEditingController controller, {
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
        filled: true,
        fillColor: AppColors.fgcolor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
