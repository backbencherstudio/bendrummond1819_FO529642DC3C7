import 'dart:developer';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static const String _apiKey = 'appl_zbZpgJctbSRcdUyFTmOeQcXXMXz';
  static const String entitlementId = 'premium';

  static Future<void> initialize() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);
      PurchasesConfiguration configuration;
      configuration = PurchasesConfiguration(_apiKey);
      await Purchases.configure(configuration);
      log("RevenueCat initialized successfully");
    } catch (e) {
      log("RevenueCat initialization failed: $e");
    }
  }

  static Future<Offerings?> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      log("Offerings fetched: ${offerings.current?.identifier}");
      return offerings;
    } catch (e) {
      log("Failed to fetch offerings: $e");
      return null;
    }
  }

  static Future<CustomerInfo?> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      log("Purchase successful: ${result.customerInfo.entitlements}");
      return result.customerInfo;
    } catch (e) {
      log("Purchase failed: $e");
      return null;
    }
  }

  static Future<bool> isPro() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive == true;
    } catch (e) {
      log("Failed to check entitlement: $e");
      return false;
    }
  }

  static Future<CustomerInfo?> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      log("Restore successful: ${customerInfo.entitlements.all}");
      return customerInfo;
    } catch (e) {
      log("Restore failed: $e");
      return null;
    }
  }
}
