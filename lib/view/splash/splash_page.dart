import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Dimensions.width10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                    child: FlutterLogo(
                      size: 150,
                      style: FlutterLogoStyle.stacked,
                      textColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
              width: Dimensions.width30,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 3),
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  color: Colors.teal,
                  backgroundColor: Colors.teal.withAlpha(100),
                ),
                onEnd: () async {
                  AuthController authCtrl = Get.find<AuthController>();
                  if (authCtrl.checkSign()) {
                    Get.offAllNamed(AppRoutes.homePage);
                  } else {
                    Get.offAllNamed(AppRoutes.login);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
