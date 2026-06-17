import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/forget_password/set_new_password/set_new_password_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/forget_password/view/forgot_password.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signin/view/signin_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/view/signup_screen.dart';

import 'package:bendrummond1819_fo529642dc3c7/presentation/bills/addBills/view/add_bill_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/bills/editBill/view/edit_bill_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/goals/addGoal/view/add_goal_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/about/view/about_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/account/view/account_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/notification/view/notification_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/settings/view/home_settings_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/pay/view/pay_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/complete_payment/complete_payment_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/results/result_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/subscription/view/choose_your_plan_screen.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/forget_password/otp/otp_screen.dart';
import '../../presentation/auth/signup/otp/signup_otp_screen.dart';
import '../../presentation/auth/signup/setup/setup_screen/set_up_screen.dart';
import '../../presentation/bottomNav/view/bottom_nav_bar_screen.dart';
import '../../presentation/onboading/view/onboading_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/constants/strings_manager.dart';
import 'routes_name.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: routeSettings);

      /// ****************** auth ******************
      case RoutesName.signInRoute:
        return MaterialPageRoute(builder: (_) => SigningScreen(), settings: routeSettings);
      case RoutesName.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen(), settings: routeSettings);
      case RoutesName.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPassword(), settings: routeSettings);
      case RoutesName.forgotPasswordOtpRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordOtpScreen(), settings: routeSettings);
      case RoutesName.resetNewPasswordRoute:
        return MaterialPageRoute(builder: (_) => SetNewPasswordScreen(), settings: routeSettings);

      /// *************** bottom nav ****************
      case RoutesName.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => BottomNavBarScreen(), settings: routeSettings);
      case RoutesName.payScreen:
        return MaterialPageRoute(builder: (_) => PayScreen(), settings: routeSettings);
      case RoutesName.addGoalScreen:
        return MaterialPageRoute(builder: (_) => AddGoalScreen(), settings: routeSettings);
      case RoutesName.addBillScreen:
        return MaterialPageRoute(builder: (_) => AddBillScreen(), settings: routeSettings);
      case RoutesName.editBillScreen:
        return MaterialPageRoute(builder: (_) => EditBillScreen(), settings: routeSettings);
      case RoutesName.homeSettingsScreen:
        return MaterialPageRoute(builder: (_) => HomeSettingsScreen(), settings: routeSettings);
      case RoutesName.accountScreen:
        return MaterialPageRoute(builder: (_) => AccountScreen(), settings: routeSettings);
      case RoutesName.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen(), settings: routeSettings);
      case RoutesName.aboutScreen:
        return MaterialPageRoute(builder: (_) => AboutScreen(), settings: routeSettings);
      case RoutesName.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen(), settings: routeSettings);
      // ================ Subscription ================
      case RoutesName.chooseYourPlainScreen:
        return MaterialPageRoute(builder: (_) => ChooseYourPlanScreen(), settings: routeSettings);
      case RoutesName.completePaymentScreen:
        return MaterialPageRoute(builder: (_) => CompletePaymentScreen(), settings: routeSettings);
      case RoutesName.resultScreen:
        return MaterialPageRoute(builder: (_) => ResultScreen(), settings: routeSettings);
      case RoutesName.signupOtpScreen:
        return MaterialPageRoute(builder: (_) => SignupOtpScreen(), settings: routeSettings);
      case RoutesName.setUpScreen:
        return MaterialPageRoute(builder: (_) => SetUpScreen(), settings: routeSettings);
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
