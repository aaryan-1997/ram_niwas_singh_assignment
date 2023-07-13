import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ram_niwas_singh_assignment/controllers/auth_controller.dart';
import 'package:ram_niwas_singh_assignment/controllers/home_controller.dart';
import 'package:ram_niwas_singh_assignment/routes/app_routes.dart';

import '../../config/dimensions.dart';
import '../../widgets/custom_click_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loader_button.dart';
import '../../widgets/small_text.dart';
import '../../widgets/validator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.find<AuthController>()
                  .userSignOut()
                  .then((value) => Get.offAllNamed(AppRoutes.login));
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.width20),
          child: Form(
            key: _formKey,
            child: GetBuilder<HomeController>(builder: (homeCtrl) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SmallText(
                              text: "Send Notification",
                              size: Dimensions.font24,
                              weight: FontWeight.bold,
                            ),
                            //SizedBox(height: Dimensions.height20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: Dimensions.height20),
                                SizedBox(height: Dimensions.height20),
                                CustomTextField(
                                  labelText: "Title",
                                  controller: titleController,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapital: TextCapitalization.none,
                                  textInputAction: TextInputAction.next,
                                  validator: Validator(errorText: "").notEmpty,
                                ),
                                SizedBox(height: Dimensions.height15),
                                CustomTextField(
                                  labelText: "Body",
                                  controller: bodyController,
                                  textCapital: TextCapitalization.none,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: Validator(errorText: "").notEmpty,
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(height: Dimensions.height30),
                                homeCtrl.isLoading
                                    ? const LoaderButton()
                                    : CustomClickButton(
                                        title: "Send",
                                        onTap: () async {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await homeCtrl.sendFcmMessage(
                                              titleController.text.trim(),
                                              bodyController.text.trim(),
                                            );
                                          }
                                        },
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
