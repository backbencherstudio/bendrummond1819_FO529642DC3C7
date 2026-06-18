import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_clients.dart';
import '../../data/models/setup_models.dart';
import '../../data/repositories/setup_repository.dart';
import '../../data/sources/remote/setup_api_service.dart';

class BalancesState {
  final List<FinancialCommitmentData> debts;
  final bool isLoading;
  final String? error;

  const BalancesState({this.debts = const [], this.isLoading = false, this.error});

  BalancesState copyWith({
    List<FinancialCommitmentData>? debts,
    bool? isLoading,
    String? error,
  }) =>
      BalancesState(
        debts: debts ?? this.debts,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class BalancesNotifier extends Notifier<BalancesState> {
  @override
  BalancesState build() => const BalancesState();

  Future<void> fetchDebts() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final bills = await repository.getMonthlyBills();
      final debts = bills.where((b) => b.category == 'DEBT').toList();
      state = BalancesState(debts: debts, isLoading: false);
    } catch (e) {
      state = BalancesState(isLoading: false, error: e.toString());
    }
  }

  void refresh() {
    state = const BalancesState();
    fetchDebts();
  }

  Future<bool> addDebt({
    required String name,
    required double amount,
    int? dueDay,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.addBill(
        category: 'DEBT',
        name: name,
        amount: amount,
        dueDay: dueDay,
        frequency: 'WEEKLY',
        isRecurring: true,
      );
      if (success) {
        refresh();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDebt(String id) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.deleteBill(id);
      if (success) {
        refresh();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateDebt({
    required String id,
    String? name,
    double? amount,
    int? dueDay,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.updateBill(
        id: id,
        category: 'DEBT',
        name: name,
        amount: amount,
        dueDay: dueDay,
        frequency: 'WEEKLY',
        isRecurring: true,
      );
      if (success) {
        refresh();
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}

final balancesProvider = NotifierProvider<BalancesNotifier, BalancesState>(
  BalancesNotifier.new,
);
