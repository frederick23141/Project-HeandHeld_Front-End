import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handheld_beta/MVC/views/Ppal/Home.dart';
import 'package:handheld_beta/MVC/views/Ppal/login.dart';
import 'package:handheld_beta/core/route/unknown_page.dart';
import 'package:handheld_beta/features/auth/auth_injection.dart';
import 'package:handheld_beta/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:handheld_beta/features/auth/presentation/views/login_page.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const Login());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const Home());

      case AppRoutes.loginpage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AuthBloc>(
                create: (_) => sl<AuthBloc>(), child: const LoginPage()));

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
