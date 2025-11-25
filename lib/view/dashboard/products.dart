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
        onPressed: () {
          // Navigator.pushNamed(context, MyPagesName.addproduct);
          Get.toNamed(MyPagesName.addproduct);
        },
      ),
      body: Column(
        children: [
          // Product count
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grid,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: controller.fetchProducts(), // <-- fetch products
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Loading products...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text(
                      'Error loading products',
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  final productCount = snapshot.data?.length ?? 0;
                  return Text(
                    '$productCount products',
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

          // Search / Filter UI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.fgcolor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 12),
                          child: Icon(
                            Icons.search,
                            color: AppColors.surface,
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search item',
                              hintStyle: TextStyle(
                                color: AppColors.surface.withOpacity(0.7),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white, size: 28),
                    onPressed: () {
                      print("Filter pressed");
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Product List
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Error loading products',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                final products = snapshot.data ?? [];

                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(color: AppColors.white),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 10,
                    thickness: 1,
                    color: AppColors.border,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _ProductItem(
                      title: product['name'] ?? 'No Title',
                      category: product['category'] ?? 'No Category',
                      price: product['price']?.toString() ?? '0',
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
}

class _ProductItem extends StatelessWidget {
  final String title;
  final String category;
  final String price;

  const _ProductItem({
    Key? key,
    required this.title,
    required this.category,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: AppColors.surface, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '@ $category',
                      style: TextStyle(color: AppColors.surface, fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      'RS $price',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
