import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_clients.dart';
import '../../data/models/setup_models.dart';
import '../../data/repositories/setup_repository.dart';
import '../../data/sources/remote/setup_api_service.dart';

class BillsState {
  final List<FinancialCommitmentData> bills;
  final bool isLoading;
  final String? error;

  const BillsState({this.bills = const [], this.isLoading = false, this.error});

  BillsState copyWith({
    List<FinancialCommitmentData>? bills,
    bool? isLoading,
    String? error,
  }) =>
      BillsState(
        bills: bills ?? this.bills,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class BillsNotifier extends Notifier<BillsState> {
  @override
  BillsState build() => const BillsState();

  Future<void> fetchBills() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final bills = await repository.getMonthlyBills();
      state = BillsState(bills: bills, isLoading: false);
    } catch (e) {
      state = BillsState(isLoading: false, error: e.toString());
    }
  }

  void refresh() {
    state = const BillsState();
    fetchBills();
  }

  Future<bool> updateBill({
    required String id,
    String? category,
    String? name,
    double? amount,
    int? dueDay,
    String? frequency,
    bool? isRecurring,
  }) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.updateBill(
        id: id,
        category: category,
        name: name,
        amount: amount,
        dueDay: dueDay,
        frequency: frequency,
        isRecurring: isRecurring,
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

final billsProvider = NotifierProvider<BillsNotifier, BillsState>(
  BillsNotifier.new,
);
