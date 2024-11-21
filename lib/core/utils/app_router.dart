import 'package:electronics_shop/features/auth/presentation/views/login_view.dart';
import 'package:electronics_shop/features/auth/presentation/views/register_view.dart';
import 'package:electronics_shop/features/auth/presentation/views/widgets/control_flow.dart';
import 'package:electronics_shop/features/home/presentation/view_models/category_index_cubit/category_index_cubit.dart';
import 'package:electronics_shop/features/home/presentation/view_models/products_filter_cubit/products_filter_cubit.dart';
import 'package:electronics_shop/features/home/presentation/views/home_page_view.dart';
import 'package:electronics_shop/features/home/presentation/views/home_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/nottfications_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/product_screen.dart';
import 'package:electronics_shop/features/home/presentation/views/profile_screen.dart';
import 'package:electronics_shop/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String homePageView = '/home_page_view';
  static const String notifications = '/notifications';
  static const String login = '/login';
  static const String register = '/register';
  static const String product = '/product';
  static const String profile = '/profile';
  static const String controlFlow = '/controlFlow';
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/home_page_view',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const HomePageView(),
        ),
      ),
      GoRoute(
        path: '/notifications',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const SignupScreen(),
        ),
      ),
      GoRoute(
        path: '/product',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ProductScreen(
            product: state.extra as Map<String, dynamic>,
          ),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/controlFlow',
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CategoryIndexCubit>(
                create: (context) => CategoryIndexCubit(),
              ),
              BlocProvider<ProductsFilterCubit>(
                create: (context) => ProductsFilterCubit(),
              ),
            ],
            child: const ControlFlow(),
          ),
        ),
      ),
    ],
  );
}

CustomTransitionPage buildPageWithFadeTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
