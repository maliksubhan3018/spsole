// ignore_for_file: deprecated_member_use, curly_braces_in_flow_control_structures, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:spsole/widgets/mycolors.dart';

enum FilterType { all, complete, newPending, canceled, returned }

enum Status { complete, pending, canceled, returned }

class Order {
  final String name;
  final String id;
  final String phone;
  final String time;
  final String address;
  final String price;
  final Status status;

  Order({
    required this.name,
    required this.id,
    required this.phone,
    required this.time,
    required this.address,
    required this.price,
    required this.status,
  });
}

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late FilterType selectedFilter = FilterType.all;

  final List<Order> orders = [
    Order(
      name: 'Bilal Khan',
      id: '#5612312121',
      phone: '+92 3421585',
      time: '2 July 25 12:25pm',
      address: 'Address city, punjab, pakistan.',
      price: 'Rs 150',
      status: Status.complete,
    ),
    Order(
      name: 'Bilal Khan',
      id: '#5612312121',
      phone: '+92 3421585',
      time: '2 July 25 12:25pm',
      address: 'Address city, punjab, pakistan.',
      price: 'Rs 150',
      status: Status.complete,
    ),
    Order(
      name: 'Bilal Khan',
      id: '#5612312121',
      phone: '+92 3421585',
      time: '2 July 25 12:25pm',
      address: 'Address city, punjab, pakistan.',
      price: 'Rs 150',
      status: Status.pending,
    ),
    Order(
      name: 'Bilal Khan',
      id: '#5612312121',
      phone: '+92 3421585',
      time: '2 July 25 12:25pm',
      address: 'Address city, punjab, pakistan.',
      price: 'Rs 150',
      status: Status.canceled,
    ),
    Order(
      name: 'Bilal Khan',
      id: '#5612312121',
      phone: '+92 3421585',
      time: '2 July 25 12:25pm',
      address: 'Address city, punjab, pakistan.',
      price: 'Rs 150',
      status: Status.returned,
    ),
  ];

  static const Map<Status, Color> priceColors = {
    Status.complete: AppColors.green,
    Status.pending: AppColors.orange,
    Status.canceled: AppColors.red,
    Status.returned: AppColors.red,
  };

  List<Order> getFilteredOrders() {
    return orders.where((order) {
      switch (selectedFilter) {
        case FilterType.all:
          return true;
        case FilterType.complete:
          return order.status == Status.complete;
        case FilterType.newPending:
          return order.status == Status.pending;
        case FilterType.canceled:
          return order.status == Status.canceled;
        case FilterType.returned:
          return order.status == Status.returned;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = getFilteredOrders();
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'All Orders',
                          style: TextStyle(
                            color: AppColors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '100',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Complete',
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '12,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Pending',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '50,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                      // ignore: avoid_print
                      print("Filter pressed");
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: selectedFilter == FilterType.all,
                          onSelected: (value) {
                            if (value)
                              setState(() => selectedFilter = FilterType.all);
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors
                              .blue, // using your custom blue for "All"
                          side: BorderSide(
                            color: selectedFilter == FilterType.all
                                ? Colors.transparent
                                : AppColors.border,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Complete'),
                          selected: selectedFilter == FilterType.complete,
                          onSelected: (value) {
                            if (value)
                              setState(
                                () => selectedFilter = FilterType.complete,
                              );
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.green,
                          side: BorderSide(
                            color: selectedFilter == FilterType.complete
                                ? Colors.transparent
                                : AppColors.border,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('New & Pending'),
                          selected: selectedFilter == FilterType.newPending,
                          onSelected: (value) {
                            if (value)
                              setState(
                                () => selectedFilter = FilterType.newPending,
                              );
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.orange,
                          side: BorderSide(
                            color: selectedFilter == FilterType.newPending
                                ? Colors.transparent
                                : AppColors.border,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Canceled'),
                          selected: selectedFilter == FilterType.canceled,
                          onSelected: (value) {
                            if (value)
                              setState(
                                () => selectedFilter = FilterType.canceled,
                              );
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.red,
                          side: BorderSide(
                            color: selectedFilter == FilterType.canceled
                                ? Colors.transparent
                                : AppColors.border,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Returned'),
                          selected: selectedFilter == FilterType.returned,
                          onSelected: (value) {
                            if (value)
                              setState(
                                () => selectedFilter = FilterType.returned,
                              );
                          },
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.red,
                          side: BorderSide(
                            color: selectedFilter == FilterType.returned
                                ? Colors.transparent
                                : AppColors.border,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 80), // space to scroll last chip
                      ],
                    ),
                  ),
                ),

                // Your original count badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${filteredOrders.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ListView of orders
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredOrders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _OrderItem(order: filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Order order;

  const _OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isPending = order.status == Status.pending;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPending) ...[
            const Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Icon(Icons.circle, color: Colors.red, size: 8),
            ),
            const SizedBox(width: 8),
          ] else
            const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        order.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        order.id,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        order.phone,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        order.time,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        order.address,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      order.price,
                      style: TextStyle(
                        color: _OrdersState.priceColors[order.status],
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
