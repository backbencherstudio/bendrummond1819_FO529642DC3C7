import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_clients.dart';
import '../../data/models/setup_models.dart';
import '../../data/repositories/setup_repository.dart';
import '../../data/sources/remote/setup_api_service.dart';

class IncomesState {
  final List<IncomeData> incomes;
  final List<FinancialCommitmentData> financialCommitments;
  final double safeToSpend;
  final bool isLoading;
  final String? error;

  const IncomesState({
    this.incomes = const [],
    this.financialCommitments = const [],
    this.safeToSpend = 0,
    this.isLoading = false,
    this.error,
  });

  IncomesState copyWith({
    List<IncomeData>? incomes,
    List<FinancialCommitmentData>? financialCommitments,
    double? safeToSpend,
    bool? isLoading,
    String? error,
  }) => IncomesState(
    incomes: incomes ?? this.incomes,
    financialCommitments: financialCommitments ?? this.financialCommitments,
    safeToSpend: safeToSpend ?? this.safeToSpend,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class IncomesNotifier extends Notifier<IncomesState> {
  @override
  IncomesState build() => const IncomesState();

  double _monthlyMultiplier(String frequency) {
    switch (frequency) {
      case 'WEEKLY':
        return 4.33;
      case 'EVERY_2_WEEKS':
        return 2.17;
      case 'TWICE_A_MONTH':
        return 2;
      case 'MONTHLY':
        return 1;
      default:
        return 1;
    }
  }

  Future<void> fetchIncomes() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final data = await repository.getSetupData();
      debugPrint("Incomes provider $data");

      final incomes = data?.incomes ?? [];
      final commitments = data?.financialCommitments ?? [];
      final savings = data?.savingsGoals ?? [];

      final monthlyIncome = incomes.fold<double>(
        0,
        (sum, i) => sum + i.baseIncome * _monthlyMultiplier(i.payFrequency),
      );
      final totalCommitments = commitments.fold<double>(
        0, (sum, c) => sum + c.amount,
      );
      final totalSavings = savings.fold<double>(
        0, (sum, g) => sum + g.contribution,
      );

      final safeToSpend = monthlyIncome > 0
          ? (monthlyIncome - totalCommitments - totalSavings) / 4.33
          : 0.0;

      state = IncomesState(
        incomes: incomes,
        financialCommitments: commitments,
        safeToSpend: safeToSpend,
        isLoading: false,
      );
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

  Future<bool> addCommitment({
    required String category,
    required String name,
    required double amount,
    int? dueDay,
    String? frequency,
    bool isRecurring = false,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.addCommitment(
        category: category,
        name: name,
        amount: amount,
        dueDay: dueDay,
        frequency: frequency,
        isRecurring: isRecurring,
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
