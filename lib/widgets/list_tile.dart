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
    if (isHeader) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.surface,
          ),
        ),
      );
    } else {
      final border = Border(
        bottom: BorderSide(color: AppColors.white.withOpacity(0.3), width: 1.0),
      );

      return Container(
        decoration: BoxDecoration(border: border),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 1.5,
          ),
          leading: icon != null
              ? Icon(icon, color: iconColor ?? AppColors.white, size: 24)
              : const SizedBox(width: 24),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: AppColors.white),
          ),
          trailing:
              trailing ??
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.white,
              ),
          onTap: onTap,
        ),
      );
    }
  }
}
