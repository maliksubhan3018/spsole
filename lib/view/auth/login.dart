import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spsole/widgets/button.dart';
import 'package:spsole/widgets/customtextfield.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              /// LOGO
              Image.asset(MyImages.circleimg),
              const SizedBox(height: 25),

              /// EMAIL FIELD
              CustomTextField(
                label: "Email Address",
                hintText: "Enter your email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// TITLE
              const Text(
                'Enter Your Secret password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 16),

              /// OTP FIELD WITH CONTROLLER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: pinController, // ⭐ Added Controller
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 55,
                    fieldWidth: 50,
                    inactiveColor: AppColors.white.withAlpha(77),
                    selectedColor: AppColors.white,
                    activeColor: AppColors.primary.withAlpha(77),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                  enableActiveFill: false,

                  onChanged: (value) {},

                  onCompleted: (value) {
                    debugPrint("PIN entered: $value");
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// LOGIN BUTTON WITH VALIDATION
              Button(
                text: 'Login',
                onPressed: () {
                  if (emailController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Email is required")),
                    );
                    return;
                  }

                  if (pinController.text.trim().length != 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("login successfully")),
                    );
                    return;
                  }

                  // VALID → Navigate
                  // Get.toNamed(MyPagesName.dashboard);
                },
                isSubmit: true,
              ),

              const SizedBox(height: 10),

              /// RESET PIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Remember PIN? ",
                    style: TextStyle(color: AppColors.white),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Reset PIN",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              /// FINGERPRINT
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

              /// VERSION
              const Text(
                'Version 1.15.25 by spsole offer',
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
