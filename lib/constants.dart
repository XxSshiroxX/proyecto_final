import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF0000); // Rojo puro
const kPrimaryLightColor = Color(0xFFFFC1C1); // Rojo claro
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFF4D4D), Color(0xFFFF0000)], // Gradiente de tonos rojizos
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor ingresa tu correo electrónico";
const String kInvalidEmailError = "Por favor ingresa un correo electrónico válido";
const String kPassNullError = "Por favor ingresa tu contraseña";
const String kShortPassError = "La contraseña es demasiado corta";
const String kMatchPassError = "Las contraseñas no coinciden";
const String kNamelNullError = "Por favor ingresa tu nombre";
const String kPhoneNumberNullError = "Por favor ingresa tu número de teléfono";
const String kAddressNullError = "Por favor ingresa tu dirección";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
