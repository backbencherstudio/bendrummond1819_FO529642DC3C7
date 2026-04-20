import 'package:bendrummond1819_fo529642dc3c7/presentation/bills/addBills/view/add_bill_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/goals/addGoal/view/add_goal_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/about/view/about_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/account/view/account_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/notification/view/notification_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/view/home_settings_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/pay/view/pay_screen.dart';
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
      case RoutesName.payScreen:
        return MaterialPageRoute(builder: (_) => PayScreen());
      case RoutesName.addGoalScreen:
        return MaterialPageRoute(builder: (_) => AddGoalScreen());
      case RoutesName.addBillScreen:
        return MaterialPageRoute(builder: (_) => AddBillScreen());
      case RoutesName.homeSettingsScreen:
        return MaterialPageRoute(builder: (_) => HomeSettingsScreen());
      case RoutesName.accountScreen:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case RoutesName.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case RoutesName.aboutScreen:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case RoutesName.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

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
