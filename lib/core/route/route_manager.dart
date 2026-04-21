import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/forget_password/view/forgot_password.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signin/view/signin_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import '../../presentation/onboading/view/onboading_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/constants/strings_manager.dart';
import 'routes_name.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => BottomNavBarScreen());
      case RoutesName.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case RoutesName.signInRoute:
        return MaterialPageRoute(builder: (_) => SigningScreen());
      case RoutesName.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case RoutesName.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(StringManager.noRoute)),
        body: Center(child: Text(StringManager.noRoute)),
      ),
    );
  }
}
