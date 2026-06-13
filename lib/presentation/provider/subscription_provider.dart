import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../core/services/revenuecat_service.dart';

class SubscriptionState {
  final bool isLoading;
  final bool isPro;
  final Offerings? offerings;
  final String? error;

  const SubscriptionState({
    this.isLoading = false,
    this.isPro = false,
    this.offerings,
    this.error,
  });

  SubscriptionState copyWith({
    bool? isLoading,
    bool? isPro,
    Offerings? offerings,
    String? error,
  }) =>
      SubscriptionState(
        isLoading: isLoading ?? this.isLoading,
        isPro: isPro ?? this.isPro,
        offerings: offerings ?? this.offerings,
        error: error,
      );
}

class SubscriptionNotifier extends Notifier<SubscriptionState> {
  @override
  SubscriptionState build() => const SubscriptionState();

  Future<void> loadOfferings() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final isPro = await RevenueCatService.isPro();
      final offerings = await RevenueCatService.getOfferings();
      if (offerings.current == null) {
        state = SubscriptionState(
          isLoading: false,
          isPro: isPro,
          error: 'No current offering configured. Please set up an offering in the RevenueCat dashboard.',
        );
        return;
      }
      state = SubscriptionState(
        isLoading: false,
        isPro: isPro,
        offerings: offerings,
      );
    } catch (e) {
      state = SubscriptionState(isLoading: false, error: e.toString());
    }
  }

  Future<bool> purchase(Package package) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final customerInfo = await RevenueCatService.purchasePackage(package);
      if (customerInfo != null) {
        final isPro =
            customerInfo.entitlements.all[RevenueCatService.entitlementId]
                ?.isActive ==
                true;
        state = SubscriptionState(
          isLoading: false,
          isPro: isPro,
          offerings: state.offerings,
        );
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: 'Purchase failed',
      );
      return false;
    } catch (e) {
      state = SubscriptionState(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> restore() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final customerInfo = await RevenueCatService.restorePurchases();
      final isPro =
          customerInfo?.entitlements.all[RevenueCatService.entitlementId]
              ?.isActive ==
              true;
      state = SubscriptionState(
        isLoading: false,
        isPro: isPro,
        offerings: state.offerings,
      );
      return customerInfo != null;
    } catch (e) {
      state = SubscriptionState(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final subscriptionProvider =
    NotifierProvider<SubscriptionNotifier, SubscriptionState>(
  SubscriptionNotifier.new,
);
