import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(MyImages.boximage),
            const SizedBox(height: 8),
            const Text(
              "Welcome To spsole",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
            const Text(
              "Help you manage your inventory in \n offline App. Help yomanage your.",
              style: TextStyle(fontSize: 12, color: AppColors.white),
            ),
            const SizedBox(height: 10),
           Button(
  text: "Get Started",
  onPressed: () {
    Get.toNamed(MyPagesName.getstarted);
  },
),

          ],
        ),
      ),
    );
  }
}
