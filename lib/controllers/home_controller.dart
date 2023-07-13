import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ram_niwas_singh_assignment/controllers/auth_controller.dart';

class HomeController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<bool> sendFcmMessage(String title, String message) async {
    try {
      _isLoading = true;
      update();
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAu5Kj_VI:APA91bEVn7vGGljauStapife6P46xxgTN9jRluG5sh1kKECcFYxyo-6pCmqT34VtGCsX1f8wg9O8sC71A_A3wvCzaAV5qeAHSZxnoglhgc3t1DaKx5ePFe6XG0UpwI84TI6mVNpslF0Q",
      };
      var request = {
        "notification": {
          "title": title,
          "body": message,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        'to': await Get.find<AuthController>().getFcmToken()
      };

      var client = http.Client();
      var response = await client.post(Uri.parse(url),
          headers: header, body: json.encode(request));
      log(response.body);
      _isLoading = false;
      update();
      return true;
    } catch (e) {
      _isLoading = false;
      update();
      return false;
    }
  }
}
