import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_clients.dart';
import '../../data/models/setup_models.dart';
import '../../data/repositories/setup_repository.dart';
import '../../data/sources/remote/setup_api_service.dart';

class IncomesState {
  final List<IncomeData> incomes;
  final bool isLoading;
  final String? error;

  const IncomesState({
    this.incomes = const [],
    this.isLoading = false,
    this.error,
  });

  IncomesState copyWith({
    List<IncomeData>? incomes,
    bool? isLoading,
    String? error,
  }) => IncomesState(
    incomes: incomes ?? this.incomes,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class IncomesNotifier extends Notifier<IncomesState> {
  @override
  IncomesState build() => const IncomesState();

  Future<void> fetchIncomes() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final data = await repository.getSetupData();
      debugPrint("Incomes provider $data");
      state = IncomesState(incomes: data?.incomes ?? [], isLoading: false);
    } catch (e) {
      state = IncomesState(isLoading: false, error: e.toString());
    }
  }

  void refresh() {
    state = const IncomesState();
    fetchIncomes();
  }

  Future<bool> addIncome({
    required String incomeType,
    required String payFrequency,
    required double baseIncome,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.addIncome(
        incomeType: incomeType,
        payFrequency: payFrequency,
        baseIncome: baseIncome,
      );
      if (success) refresh();
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteIncome(String id) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.deleteIncome(id);
      if (success) refresh();
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateIncome({
    required String id,
    String? incomeType,
    String? payFrequency,
    double? baseIncome,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.updateIncome(
        id: id,
        incomeType: incomeType,
        payFrequency: payFrequency,
        baseIncome: baseIncome,
      );
      if (success) refresh();
      return success;
    } catch (e) {
      return false;
    }
  }
}

final incomesProvider = NotifierProvider<IncomesNotifier, IncomesState>(
  IncomesNotifier.new,
);
