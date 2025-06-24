import 'package:flutter/material.dart';

import 'components/profile_menu.dart';
import "package:proyecto_final/services/auth_service.dart";

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Mi Cuenta",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
                text: "Ordenes",
                icon: "assets/icons/Bill Icon.svg",
                press: () {
                  Navigator.pushNamed(context, "/orders");
                }),
            ProfileMenu(
              text: "Cerrar sesión",
              icon: "assets/icons/Log out.svg",
              press: () async {
                final confirmLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Cerrar sesión"),
                    content: const Text(
                        "¿Estás seguro de que deseas cerrar sesión?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Cerrar sesión"),
                      ),
                    ],
                  ),
                );

                if (confirmLogout == true) {
                  if (!context.mounted) return;
                  await authService.logout(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
