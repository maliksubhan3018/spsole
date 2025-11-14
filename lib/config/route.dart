import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/view/auth/login.dart';
import 'package:spsole/view/onboarding/get_started.dart';
import 'package:spsole/view/onboarding/onboarding.dart';

class AppRoutes {
  static routes() => [
    GetPage(name: MyPagesName.onboarding, page: () => const Onboarding()),
    GetPage(name: MyPagesName.getstarted, page: () => const Getstarted()),
    GetPage(name: MyPagesName.login, page: () => Login()),
  ];
}
