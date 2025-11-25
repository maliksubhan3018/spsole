// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spsole/services/auth_service.dart';
import 'package:spsole/widgets/list_tile.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  Future<Map<String, dynamic>> getUserInfo() async {
    final uid = AuthService.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    return doc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              }
              if (snapshot.hasError) {
                return const Text(
                  'Error loading user info',
                  style: TextStyle(color: AppColors.white),
                );
              }

              final userData = snapshot.data!;
              final name = userData["name"] ?? "No Name";
              final email = userData["email"] ?? "No Name";

              return Container(
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
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: AppColors.white),
                    ),
                  ],
                ),
              );
            },
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
