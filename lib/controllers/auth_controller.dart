// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_utils.dart';
import '../config/sp_key.dart';

class AuthController extends GetxController {
  SharedPreferences prefs;
  AuthController({required this.prefs});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  Future<String> getFcmToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var fcm = await firebaseMessaging.getToken() ?? "";
    //log(fcm);
    return fcm;
  }

  bool checkSign() {
    _isSignedIn = prefs.getBool(SpKey.isSigned) ?? false;
    return _isSignedIn;
  }

  Future setSignIn() async {
    prefs.setBool(SpKey.isSigned, true);
    _isSignedIn = true;
    update();
  }

  Future<void> createUserWithEmailPassword({
    String email = "",
    password = "",
    required Function onSuccess,
  }) async {
    try {
      _isLoading = true;
      update();
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) {
        _isLoading = false;
        update();
        if (userCredential.user != null) {
          _uid = userCredential.user!.uid;

          onSuccess(_uid);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        AppUtils.showCustomSnackBar("Email already in use", isError: true);
      } else if (e.code == "invalid-email") {
        AppUtils.showCustomSnackBar("Invalid Email.", isError: true);
      } else if (e.code == "weak-password") {
        AppUtils.showCustomSnackBar("Weak password", isError: true);
      } else {
        AppUtils.showCustomSnackBar("Some error occure.", isError: true);
      }

      _isLoading = false;
      update();
    }
  }

  Future<void> signInWithEmailPassword({
    String email = "",
    password = "",
    required Function onSuccess,
  }) async {
    try {
      _isLoading = true;
      update();
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) {
        _isLoading = false;
        update();
        if (userCredential.user != null) {
          _uid = userCredential.user!.uid;
          onSuccess(_uid);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppUtils.showCustomSnackBar(
          "User not found!",
          isError: true,
        );
      } else if (e.code == "invalid-email") {
        AppUtils.showCustomSnackBar("Invalid Email.", isError: true);
      } else if (e.code == 'wrong-password') {
        AppUtils.showCustomSnackBar(
          e.message.toString(),
          isError: true,
        );
      }
      _isLoading = false;
      update();
    }
  }

  Future userSignOut() async {
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    prefs.clear();
  }
}
