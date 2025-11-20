// lib/widgets/list_tile.dart
import 'package:flutter/material.dart';
import 'package:spsole/widgets/mycolors.dart';

class CustomListTile extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isHeader;

  const CustomListTile({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    this.trailing,
    this.onTap,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    // Section Header (like "OTHERS")
    if (isHeader) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, top: 24, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.surface,
            letterSpacing: 1.2,
          ),
        ),
      );
    }

    // Regular tile — EXACTLY like your screenshot (no border, no divider)
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0.5),
      decoration: const BoxDecoration(
        color: AppColors.gray, // Dark tile background
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // Border completely removed as requested
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4, // Perfect compact height
        ),
        leading: icon != null
            ? Icon(icon, color: iconColor ?? AppColors.surface, size: 24)
            : null,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.surface),
        ),
        trailing:
            trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.surface,
            ),
        onTap: onTap,
      ),
    );
  }
}
