// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spsole/widgets/list_tile.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.fgcolor,
                  child: const CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(MyImages.circleimg),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Store Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Category | propriter',
                  style: TextStyle(fontSize: 14, color: AppColors.white),
                ),
              ],
            ),
          ),

          CustomListTile(
            icon: Icons.person,
            title: 'Store Setting',
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.surface,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MORE ACTIONS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),

          const CustomListTile(
            icon: Icons.info_outline,
            title: 'About More',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.surface,
            ),
            onTap: null, // no action
          ),

          const CustomListTile(
            icon: Icons.help,
            title: 'Help and Support',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.surface,
            ),
            onTap: null,
          ),

          const CustomListTile(
            icon: Icons.share,
            title: 'Share App',
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.surface,
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
