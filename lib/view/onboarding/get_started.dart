import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class Getstarted extends StatelessWidget {
  const Getstarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset(MyImages.circleimg, height: 100, width: 100),
              const SizedBox(height: 15),
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
              const SizedBox(height: 40),
              Button(
                text: "Create and Register Store",
                onPressed: () {
                  Get.toNamed(MyPagesName.login);
                },
              ),
              const SizedBox(height: 20),
              Button(
                text: "Signin Using Google Account",
                onPressed: () {
 Get.toNamed(MyPagesName.signUp);                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
