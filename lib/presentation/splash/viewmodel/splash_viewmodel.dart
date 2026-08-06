import 'package:bendrummond1819_fo529642dc3c7/core/network/api_clients.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/network/api_endpoints.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/repositories/setup_repository.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/sources/local/shared_preference/shared_preference.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/sources/remote/setup_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = NotifierProvider<SplashNotifier, void>(
  SplashNotifier.new,
);

class SplashNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<String> decideInitialRoute() async {
    final token = await SharedPreferenceData.getToken();
    if (token == null || token.isEmpty || token == "null") {
      await SharedPreferenceData.removeToken();
      return RoutesName.onBoardingRoute;
    }

    try {
      final apiClient = ApiClient();
      await apiClient.getRequest(endpoints: ApiEndpoints.loadUser);
    } catch (_) {
      await SharedPreferenceData.removeToken();
      return RoutesName.onBoardingRoute;
    }

    final repository = SetupRepository(
      remoteSource: SetupApiService(apiClient: ApiClient()),
    );
    try {
      final data = await repository.getSetupData();
      if (data != null &&
          (data.incomes.isNotEmpty ||
              data.financialCommitments.isNotEmpty ||
              data.savingsGoals.isNotEmpty)) {
        return RoutesName.bottomNavRoute;
      }
      return RoutesName.setUpScreen;
    } catch (_) {
      return RoutesName.setUpScreen;
    }
  }
}
