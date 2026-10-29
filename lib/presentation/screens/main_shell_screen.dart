import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_products_shopping_app/constants/number_constant.dart';
import 'package:skincare_products_shopping_app/presentation/widgets/floating_bottom_nav.dart';

class MainShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Align(
            alignment: .bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: .only(bottom: NumberConstant.contentGap),
                child: FloatingBottomNav(
                  currentIndex: navigationShell.currentIndex,
                  onTap: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
