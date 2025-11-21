import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spsole/controllers/signup_controller.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/customtextfield.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(MyImages.circleimg),
                const SizedBox(height: 25),

                // Full Name
                CustomTextField(
                  label: "Full Name",
                  hintText: "Enter your full name",
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),

                // Email
                CustomTextField(
                  label: "Email Address",
                  hintText: "Enter your email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // PIN Title
                const Text(
                  'Create Your Secret PIN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // PIN Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: controller.pinController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      inactiveColor: AppColors.white.withAlpha(77),
                      selectedColor: AppColors.white,
                      activeColor: AppColors.primary.withAlpha(77),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 30),

                // Sign Up Button
                Button(
                  text: 'Sign Up',
                  onPressed: controller.signUp,
                  isSubmit: true,
                ),
                const SizedBox(height: 10),

                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: AppColors.white),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Fingerprint
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.fgcolor,
                    border: Border.all(color: AppColors.border, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.fingerprint,
                    color: AppColors.surface,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 40),

                // Version
                const Text(
                  'Version 1.15.25 by spsole offer',
                  style: TextStyle(color: AppColors.white, fontSize: 12),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
