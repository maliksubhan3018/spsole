// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spsole/services/auth_service.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // LOGO
                Image.asset(MyImages.circleimg),
                const SizedBox(height: 25),

                // EMAIL FIELD
                CustomTextField(
                  label: "Email Address",
                  hintText: "Enter your email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // TITLE
                const Text(
                  'Enter Your Secret password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // PIN FIELD - NOW 6 DIGITS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6, // ← Changed to 6 digits
                    controller: pinController,
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
                    onCompleted: (value) => debugPrint("PIN: $value"),
                  ),
                ),
                const SizedBox(height: 30),

                // LOGIN BUTTON
                Button(
                  text: 'Login',
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final pin = pinController.text.trim();

                    if (email.isEmpty || !GetUtils.isEmail(email)) {
                      Get.snackbar('Error', 'Enter a valid email');
                      return;
                    }
                    if (pin.isEmpty || pin.length != 6) {
                      Get.snackbar('Error', 'Enter a 6-digit PIN');
                      return;
                    }

                    // Call Auth Service
                    await AuthService.instance.loginWithEmailAndPin(
                      email: email,
                      pin: pin,
                    );
                  },
                  isSubmit: true,
                ),

                const SizedBox(height: 10),

                // RESET PIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Remember PIN? ",
                      style: TextStyle(color: AppColors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar('Coming Soon', 'PIN reset feature');
                      },
                      child: const Text(
                        "Reset PIN",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // FINGERPRINT
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

                // VERSION
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

// my code
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:spsole/config/route_name.dart';
// import 'package:spsole/widgets/button.dart';
// import 'package:spsole/widgets/customtextfield.dart';
// import 'package:spsole/widgets/mycolors.dart';
// import 'package:spsole/widgets/myimages.dart';

// class Login extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController pinController = TextEditingController();

//   Login({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgcolor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),

//               Image.asset(MyImages.circleimg),
//               const SizedBox(height: 25),

//               CustomTextField(
//                 label: "Email Address",
//                 hintText: "Enter your email",
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Email is required";
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               const Text(
//                 'Enter Your Secret password',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: PinCodeTextField(
//                   appContext: context,
//                   length: 6,
//                   controller: pinController,
//                   keyboardType: TextInputType.number,
//                   animationType: AnimationType.fade,
//                   pinTheme: PinTheme(
//                     shape: PinCodeFieldShape.box,
//                     borderRadius: BorderRadius.circular(8),
//                     fieldHeight: 55,
//                     fieldWidth: 50,
//                     inactiveColor: AppColors.white.withAlpha(77),
//                     selectedColor: AppColors.white,
//                     activeColor: AppColors.primary.withAlpha(77),
//                   ),
//                   textStyle: const TextStyle(
//                     fontSize: 20,
//                     color: AppColors.white,
//                   ),
//                   enableActiveFill: false,

//                   onChanged: (value) {},

//                   onCompleted: (value) {
//                     debugPrint("PIN entered: $value");
//                   },
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Button(
//                 text: 'Login',
//                 onPressed: () {
//                   final email = emailController.text.trim();
//                   final pin = pinController.text.trim();

//                   if (email.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Email is required")),
//                     );
//                     return;
//                   }

//                   if (pin.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("PIN is required")),
//                     );
//                     return;
//                   }

//                   if (pin.length != 4) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("PIN must be 4 digits")),
//                     );
//                     return;
//                   }

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Login successfully")),
//                   );

//                   Get.toNamed(MyPagesName.dashboard);
//                 },
//                 isSubmit: true,
//               ),

//               const SizedBox(height: 10),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Don't Remember PIN? ",
//                     style: TextStyle(color: AppColors.white),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const Text(
//                       "Reset PIN",
//                       style: TextStyle(color: AppColors.primary),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 25),

//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   color: AppColors.fgcolor,
//                   border: Border.all(color: AppColors.border, width: 1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Icon(
//                   Icons.fingerprint,
//                   color: AppColors.surface,
//                   size: 30,
//                 ),
//               ),
//               const SizedBox(height: 30),

//               const Text(
//                 'Version 1.15.25 by spsole offer',
//                 style: TextStyle(color: AppColors.white, fontSize: 12),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
