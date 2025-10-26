import 'package:go_router/go_router.dart';

import 'package:teslo_shop/features/auth/auth_export.dart';
import 'package:teslo_shop/features/products/products_export.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    //* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    //* Product Routes
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsScreen(),
    ),
  ],
  ///! TODO: Bloquear si no se está autenticado de alguna manera
);