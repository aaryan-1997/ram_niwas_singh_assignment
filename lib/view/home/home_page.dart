import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ram_niwas_singh_assignment/controllers/auth_controller.dart';
import 'package:ram_niwas_singh_assignment/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
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
      body: const Center(
        child: Text(
          'HomePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
