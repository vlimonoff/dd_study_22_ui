import 'package:dd_study_22_ui/ui/widgets/roots/app.dart';
import 'package:dd_study_22_ui/ui/widgets/roots/auth.dart';
import 'package:dd_study_22_ui/ui/widgets/roots/loader.dart';
import 'package:dd_study_22_ui/ui/widgets/roots/register.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const app = '/app';
  static const register = "/register";
}

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

  static Future toLoader() async {
    return await key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loaderWidget, (route) => false);
  }

  static Future toAuth() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, (route) => false);
  }

  static Future toHome() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.app, (route) => false);
  }

  static Future toRegister() async {
    return await key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.register, (route) => false);
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loaderWidget:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => LoaderWidget.create()));
      case NavigationRoutes.auth:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Auth.create());
      case NavigationRoutes.app:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => App.create());
      case NavigationRoutes.register:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Register.create());
    }
    return null;
  }
}
