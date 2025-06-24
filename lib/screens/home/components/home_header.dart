import 'package:flutter/material.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(child: SearchField()),
                  const SizedBox(width: 16),
                  const SizedBox(width: 46),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 20,
          child: IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ),
      ],
    );
  }
}
