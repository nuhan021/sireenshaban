import 'package:sireenshaban/features/authentication/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Color(0xFF103161),
      ),
      body: Center(
        child: Text("Login", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
