import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../logger/logger.dart';

class RevenueCatService {
  static const String entitlementId = 'premium';

  static Future<void> initialize() async {
    final apiKey = Platform.isIOS
        ? dotenv.env['REVENUECAT_IOS_API_KEY'] ?? ''
        : dotenv.env['REVENUECAT_ANDROID_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw StateError(
        'RevenueCat API key is missing for '
        '${Platform.operatingSystem}. '
        'Set REVENUECAT_${Platform.isIOS ? 'IOS' : 'ANDROID'}_API_KEY in .env',
      );
    }
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(apiKey));
    log.d("RevenueCat initialized successfully");
  }

  static Future<Offerings> getOfferings() async {
    final offerings = await Purchases.getOfferings();
    log.d("Offerings fetched: ${offerings.current?.identifier}");
    return offerings;
  }

  static Future<CustomerInfo?> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      log.d("Purchase successful: ${result.customerInfo.entitlements}");
      return result.customerInfo;
    } catch (e) {
      log.d("Purchase failed: $e");
      return null;
    }
  }

  static Future<bool> isPro() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive == true;
    } catch (e) {
      log.d("Failed to check entitlement: $e");
      return false;
    }
  }

  static Future<CustomerInfo?> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      log.d("Restore successful: ${customerInfo.entitlements.all}");
      return customerInfo;
    } catch (e) {
      log.d("Restore failed: $e");
      return null;
    }
  }
}
