// lib/screens/products.dart
// ignore_for_file: deprecated_member_use, avoid_print, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/controllers/get_product_controller.dart';
import 'package:spsole/widgets/appbar.dart';
import 'package:spsole/widgets/mycolors.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GetProductController controller = GetProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: CustomAppBar(
        title: 'Products',
        showBackButton: false,
        showPlusButton: true,
        onPressed: () => Get.toNamed(MyPagesName.addproduct),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grid,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: FutureBuilder(
                future: controller.fetchProducts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return _loadingCount();
                  return Text(
                    '${snapshot.data!.length} products',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: controller.streamProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final products = snapshot.data!;
                if (products.isEmpty) return const Center(child: Text('No products found', style: TextStyle(color: AppColors.white)));

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => Divider(height: 10, thickness: 1, color: AppColors.border),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final id = product['id']?.toString() ?? "";
                    final name = product['name']?.toString() ?? "No Name";
                    final category = product['category']?.toString() ?? "No Category";
                    final price = product['price']?.toString() ?? "0";

                    return GestureDetector(
                      onLongPress: () {
                        if (id.isNotEmpty) {
                          _showDeleteDialog(id);
                        }
                      },
                      child: _ProductItem(title: name, category: category, price: price),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingCount() => const Text('Loading products...', style: TextStyle(color: AppColors.white));

  /// Confirmation dialog for deleting a product
  void _showDeleteDialog(String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () => Navigator.pop(ctx),
          ),
          TextButton(
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
            onPressed: () async {
              await controller.deleteProduct(productId);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final String title, category, price;

  const _ProductItem({required this.title, required this.category, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.image, color: AppColors.surface, size: 28),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text('@ $category', style: const TextStyle(color: AppColors.surface, fontSize: 14)),
                  const Spacer(),
                  Text('RS $price', style: const TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
