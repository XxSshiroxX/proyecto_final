import 'package:flutter/widgets.dart';
import 'package:proyecto_final/screens/products/products_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import "screens/categories/categories_screen.dart";
import "screens/subCategories/sub_categories_screen.dart";
import "screens/checkout/payment_result_screen.dart";
import 'screens/orders_screens/order_detail_screen.dart';
import 'screens/orders_screens/orders_list_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  CategoriesScreen.routeName: (context) => const CategoriesScreen(),
  SubCategoriesScreen.routeName: (context) => const SubCategoriesScreen(),
  PaymentResultScreen.routeName: (context) => const PaymentResultScreen(
        paymentStatus: 'Status',
      ),
  OrderListScreen.routeName: (context) => const OrderListScreen(),
  OrderDetailScreen.routeName: (context) => OrderDetailScreen(
        orderId: ModalRoute.of(context)?.settings.arguments as String,
      ),
};
