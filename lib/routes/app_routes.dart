import 'package:get/get.dart';
import 'package:ram_niwas_singh_assignment/view/auth/login_page.dart';
import 'package:ram_niwas_singh_assignment/view/auth/signup_page.dart';
import 'package:ram_niwas_singh_assignment/view/home/home_page.dart';

import '../view/splash/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const homePage = '/home-page';
  static const signUp = '/signup';
  static const login = '/login';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
  ];
}
