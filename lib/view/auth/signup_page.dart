import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ram_niwas_singh_assignment/config/sp_key.dart';

import '../../config/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_click_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loader_button.dart';
import '../../widgets/small_text.dart';
import '../../widgets/validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isShowPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.width20),
          child: Form(
            key: _formKey,
            child: GetBuilder<AuthController>(builder: (authCtrl) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Center(
                              child: FlutterLogo(
                                size: 100,
                                style: FlutterLogoStyle.markOnly,
                                textColor: Colors.teal,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: Dimensions.height20),
                                SmallText(
                                  text: "Sign Up",
                                  size: Dimensions.font24,
                                  weight: FontWeight.bold,
                                ),
                                //=== Email login
                                SizedBox(height: Dimensions.height20),
                                CustomTextField(
                                  labelText: "Email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapital: TextCapitalization.none,
                                  textInputAction: TextInputAction.next,
                                  validator: Validator(errorText: "").email,
                                ),
                                SizedBox(height: Dimensions.height15),
                                CustomTextField(
                                  labelText: "Password",
                                  controller: passController,
                                  obscureText: isShowPass,
                                  textCapital: TextCapitalization.none,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: Validator(errorText: "").password,
                                  textInputAction: TextInputAction.done,
                                  onSuffixTap: () {
                                    setState(() {
                                      isShowPass = !isShowPass;
                                    });
                                  },
                                  iconSuffix: isShowPass
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),

                                SizedBox(height: Dimensions.height30),
                                authCtrl.isLoading
                                    ? const LoaderButton()
                                    : CustomClickButton(
                                        title: "Sign Up",
                                        onTap: () async {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await authCtrl
                                                .createUserWithEmailPassword(
                                                    email: emailController.text,
                                                    password:
                                                        passController.text,
                                                    onSuccess: (uid) {
                                                      if (uid != null) {
                                                        authCtrl.prefs.setBool(
                                                            SpKey.isSigned,
                                                            true);
                                                        Get.offAllNamed(
                                                            AppRoutes.homePage);
                                                      }
                                                    });
                                          }
                                        },
                                      ),
                                SizedBox(height: Dimensions.height10),
                                SmallText(
                                  text: "Or",
                                  size: Dimensions.font16,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(AppRoutes.login);
                                  },
                                  child: SmallText(
                                    text: "Already have account? Login",
                                    size: Dimensions.font16,
                                    weight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
