import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/complete_profile_form.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = arguments['email'];
    final String password = arguments['password'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completar Perfil'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Completar Perfil", style: headingStyle),
                  const Text(
                    "Completa tu información",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CompleteProfileForm(
                    email: email,
                    password: password,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Al continuar, confirmas que estás de acuerdo \ncon nuestros Términos y Condiciones",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
