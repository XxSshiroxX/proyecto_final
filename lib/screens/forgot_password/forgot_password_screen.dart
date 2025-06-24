import 'package:flutter/material.dart';

import 'components/forgot_pass_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: const SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "Recuperar Contraseña",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ingresa tu email y te enviaremos \ntu nueva contraseña",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ForgotPassForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
