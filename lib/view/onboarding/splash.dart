import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:spsole/view/onboarding/onboarding.dart';
import 'package:spsole/widgets/mycolors.dart';
import 'package:spsole/widgets/myimages.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColors.bgcolor,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      centered: true,
      splash: Image.asset(
        MyImages.circleimg,
        width: 120,
        height: 120,
        fit: BoxFit.contain,
      ),  
      // SvgPicture.asset(
      //   'assets/svg/app_logo.svg',
      //   semanticsLabel: 'App_Name',
      //   height: 80,
      // ),
      nextScreen: const Onboarding(),
    );
  }
}
//      Scaffold(
//       backgroundColor: AppColors.bgcolor,
//       body: Column(
//         children: [
//           const Spacer(),

//           Center(
//             child: Image.asset(
//               MyImages.circleimg,
//               width: 120,
//               height: 120,
//               fit: BoxFit.contain,
//             ),
//           ),

//           const Spacer(),

//           const Padding(
//             padding: EdgeInsets.only(bottom: 50),
//             child: Text(
//               "Provided By Spsole",
//               style: TextStyle(
//                 color: AppColors.fgcolor,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
