import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';

init() async {
  var prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => prefs);

  Get.lazyPut(() => AuthController(prefs: prefs));
}
