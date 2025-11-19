// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:spsole/widgets/mycolors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showPlusButton;
  final VoidCallback? onPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.showPlusButton = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.fgcolor,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      centerTitle: false,
      elevation: 0,
      actions: [
        if (showPlusButton)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints:
                    const BoxConstraints(),
                icon: const Icon(Icons.add, color: Colors.white, size: 26),
                onPressed: onPressed,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
