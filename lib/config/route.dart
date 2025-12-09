import 'package:get/get.dart';
import 'package:spsole/config/route_name.dart';
import 'package:spsole/view/auth/login.dart';
import 'package:spsole/view/auth/signup.dart';
import 'package:spsole/view/dashboard/dashboard.dart';
import 'package:spsole/view/dashboard/products.dart';
import 'package:spsole/view/onboarding/get_started.dart';
import 'package:spsole/view/onboarding/onboarding.dart';
import 'package:spsole/view/onboarding/splash.dart';
import 'package:spsole/view/product/add_product.dart';
import 'package:spsole/view/product/product_details.dart';

class AppRoutes {
  static routes() => [
    GetPage(name: MyPagesName.onboarding, page: () => const Onboarding()),
    GetPage(name: MyPagesName.splash, page: () => const Splash()),
    GetPage(name: MyPagesName.getstarted, page: () => const Getstarted()),
    GetPage(name: MyPagesName.login, page: () => Login()),
    GetPage(name: MyPagesName.dashboard, page: () => const Dashboard()),
    GetPage(name: MyPagesName.addproduct, page: () => const AddProduct()),
    GetPage(name: MyPagesName.productDetails, page: () => const ProductDetails()),
    GetPage(name: MyPagesName.signUp, page: () =>  SignUp()),
    GetPage(name: MyPagesName.products, page: () =>  Products()),
  ];
}
