import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_products_shopping_app/core/app_motion.dart';
import 'package:skincare_products_shopping_app/presentation/screens/cart_screen.dart';
import 'package:skincare_products_shopping_app/presentation/screens/explore_screen.dart';
import 'package:skincare_products_shopping_app/presentation/screens/favorites_screen.dart';
import 'package:skincare_products_shopping_app/presentation/screens/home_screen.dart';
import 'package:skincare_products_shopping_app/presentation/screens/main_shell_screen.dart';
import 'package:skincare_products_shopping_app/presentation/screens/product_detail_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainShellScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.home.routeName, builder: (context, state) => const HomeScreen(),),],),
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.favorites.routeName, builder: (context, state) => const FavoritesScreen(),),],),
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.cart.routeName, builder: (context, state) => const CartScreen(),),],),
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.explore.routeName, builder: (context, state) => const ExploreScreen(),),],),
      ],
    ),
    GoRoute(
      path: '${NamedRoutes.product.routeName}/:id',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: ProductDetailScreen(productId: state.pathParameters['id']!),
          transitionDuration: AppMotion.page,
          reverseTransitionDuration: AppMotion.medium,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: AppMotion.curve);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
                child: child,
              ),
            );
          },
        );
      },
    ),
  ],
);

enum NamedRoutes {
  home('/home'),
  favorites('/favorites'),
  cart('/cart'),
  explore('/explore'),
  product('/product');

  final String routeName;
  const NamedRoutes(this.routeName);

  static String productDetails(String id) => '${NamedRoutes.product.routeName}/$id';
}
