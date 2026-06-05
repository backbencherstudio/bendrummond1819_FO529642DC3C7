import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/network/api_clients.dart';
import '../../../../../data/models/setup_models.dart';
import '../../../../../data/repositories/setup_repository.dart';
import '../../../../../data/sources/remote/setup_api_service.dart';

class SetupDataState {
  final int incomeTypeIndex;
  final int payFrequencyIndex;
  final String baseIncome;
  final bool isRecurringIncome;
  final String rentAmount;
  final String carPaymentAmount;
  final List<Map<String, String>> bills;
  final List<Map<String, String>> debts;
  final List<Map<String, String>> savings;
  final bool isSubmitting;
  final bool? isSuccess;
  final String? errorMessage;

  SetupDataState({
    this.incomeTypeIndex = 0,
    this.payFrequencyIndex = 0,
    this.baseIncome = '',
    this.isRecurringIncome = false,
    this.rentAmount = '',
    this.carPaymentAmount = '',
    this.bills = const [],
    this.debts = const [],
    this.savings = const [],
    this.isSubmitting = false,
    this.isSuccess,
    this.errorMessage,
  });

  SetupDataState copyWith({
    int? incomeTypeIndex,
    int? payFrequencyIndex,
    String? baseIncome,
    bool? isRecurringIncome,
    String? rentAmount,
    String? carPaymentAmount,
    List<Map<String, String>>? bills,
    List<Map<String, String>>? debts,
    List<Map<String, String>>? savings,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SetupDataState(
      incomeTypeIndex: incomeTypeIndex ?? this.incomeTypeIndex,
      payFrequencyIndex: payFrequencyIndex ?? this.payFrequencyIndex,
      baseIncome: baseIncome ?? this.baseIncome,
      isRecurringIncome: isRecurringIncome ?? this.isRecurringIncome,
      rentAmount: rentAmount ?? this.rentAmount,
      carPaymentAmount: carPaymentAmount ?? this.carPaymentAmount,
      bills: bills ?? this.bills,
      debts: debts ?? this.debts,
      savings: savings ?? this.savings,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SetupDataNotifier extends Notifier<SetupDataState> {
  @override
  SetupDataState build() => SetupDataState();

  void setIncomeTypeIndex(int index) => state = state.copyWith(incomeTypeIndex: index);
  void setPayFrequencyIndex(int index) => state = state.copyWith(payFrequencyIndex: index);
  void setBaseIncome(String value) => state = state.copyWith(baseIncome: value);
  void setIsRecurringIncome(bool value) => state = state.copyWith(isRecurringIncome: value);
  void setRentAmount(String value) => state = state.copyWith(rentAmount: value);
  void setCarPaymentAmount(String value) => state = state.copyWith(carPaymentAmount: value);
  void setBills(List<Map<String, String>> bills) => state = state.copyWith(bills: bills);
  void setDebts(List<Map<String, String>> debts) => state = state.copyWith(debts: debts);
  void setSavings(List<Map<String, String>> savings) => state = state.copyWith(savings: savings);

  String _incomeTypeValue(int index) {
    switch (index) {
      case 0: return 'SAME_EVERY_PAYCHECK';
      case 1: return 'VARIES_A_LITTLE';
      case 2: return 'VARIES_A_LOT';
      default: return 'SAME_EVERY_PAYCHECK';
    }
  }

  String _payFrequencyValue(int index) {
    switch (index) {
      case 0: return 'WEEKLY';
      case 1: return 'EVERY_2_WEEKS';
      case 2: return 'TWICE_A_MONTH';
      case 3: return 'MONTHLY';
      case 4: return 'INCONSISTENT';
      default: return 'WEEKLY';
    }
  }

  SetupRequest _buildRequest() {
    final incomes = <IncomeData>[];
    if (state.baseIncome.isNotEmpty) {
      incomes.add(IncomeData(
        incomeType: _incomeTypeValue(state.incomeTypeIndex),
        payFrequency: _payFrequencyValue(state.payFrequencyIndex),
        baseIncome: double.tryParse(state.baseIncome) ?? 0,
      ));
    }

    final commitments = <FinancialCommitmentData>[];
    if (state.rentAmount.isNotEmpty) {
      commitments.add(FinancialCommitmentData(
        category: 'HOUSING',
        name: 'Rent',
        amount: double.tryParse(state.rentAmount) ?? 0,
        dueDay: 1,
        frequency: 'WEEKLY',
        isRecurring: true,
      ));
    }
    if (state.carPaymentAmount.isNotEmpty) {
      commitments.add(FinancialCommitmentData(
        category: 'CAR_PAYMENT',
        name: 'Car Payment',
        amount: double.tryParse(state.carPaymentAmount) ?? 0,
        dueDay: 1,
        frequency: 'MONTHLY',
        isRecurring: true,
      ));
    }
    for (final bill in state.bills) {
      commitments.add(FinancialCommitmentData(
        category: 'REGULAR_BILL',
        name: bill['name'] ?? 'Bill',
        amount: double.tryParse(bill['amount'] ?? '0') ?? 0,
        dueDay: int.tryParse(bill['day'] ?? ''),
        frequency: 'MONTHLY',
        isRecurring: true,
      ));
    }
    for (final debt in state.debts) {
      commitments.add(FinancialCommitmentData(
        category: 'DEBT',
        name: debt['name'] ?? 'Debt',
        amount: double.tryParse(debt['amount'] ?? '0') ?? 0,
        frequency: 'MONTHLY',
        isRecurring: true,
      ));
    }

    final savings = <SavingsGoalData>[];
    for (final goal in state.savings) {
      savings.add(SavingsGoalData(
        goalName: goal['savingName'] ?? 'Goal',
        targetAmount: double.tryParse(goal['amount'] ?? '0') ?? 0,
        contribution: double.tryParse(goal['amount'] ?? '0') ?? 0,
        frequency: 'MONTHLY',
      ));
    }

    return SetupRequest(
      incomes: incomes,
      financialCommitments: commitments,
      savingsGoals: savings,
    );
  }

  Future<bool> submitSetup() async {
    state = state.copyWith(isSubmitting: true, isSuccess: null, errorMessage: null);

    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );

      final success = await repository.submitSetup(_buildRequest());

      state = state.copyWith(isSubmitting: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString(), isSuccess: false);
      return false;
    }
  }

  Future<bool> updateSetup() async {
    state = state.copyWith(isSubmitting: true, isSuccess: null, errorMessage: null);

    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );

      final success = await repository.updateSetup(_buildRequest());

      state = state.copyWith(isSubmitting: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString(), isSuccess: false);
      return false;
    }
  }
}

final setupDataProvider = NotifierProvider<SetupDataNotifier, SetupDataState>(
  SetupDataNotifier.new,
);
