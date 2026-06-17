import '../models/setup_models.dart';
import '../sources/remote/setup_api_service.dart';

class SetupRepository {
  final SetupApiService remoteSource;

  SetupRepository({required this.remoteSource});

  Future<bool> submitSetup(SetupRequest request) {
    return remoteSource.submitSetup(request);
  }

  Future<SetupResponse?> getSetupData() {
    return remoteSource.getSetupData();
  }

  Future<bool> updateSetup(SetupRequest request) {
    return remoteSource.updateSetup(request);
  }

  Future<bool> deleteSetup() {
    return remoteSource.deleteSetup();
  }

  Future<List<FinancialCommitmentData>> getDebts() {
    return remoteSource.getDebts();
  }

  Future<List<SavingsGoalData>> getSavingGoals() {
    return remoteSource.getSavingGoals();
  }

  Future<List<FinancialCommitmentData>> getMonthlyBills() {
    return remoteSource.getMonthlyBills();
  }

  Future<List<IncomeData>> getPayIncomes() {
    return remoteSource.getPayIncomes();
  }

  Future<FinancialCommitmentData?> getBillById(int id) {
    return remoteSource.getBillById(id);
  }

  Future<bool> deleteSavingGoal(String id) {
    return remoteSource.deleteSavingGoal(id);
  }

  Future<bool> deleteBill(int id) {
    return remoteSource.deleteBill(id);
  }

  Future<bool> updateSavingGoal({
    required String id,
    String? goalName,
    double? targetAmount,
    double? contribution,
    String? frequency,
  }) {
    return remoteSource.updateSavingGoal(
      id: id,
      goalName: goalName,
      targetAmount: targetAmount,
      contribution: contribution,
      frequency: frequency,
    );
  }

  Future<bool> updateBill({
    required int id,
    String? category,
    String? name,
    double? amount,
    int? dueDay,
    String? frequency,
    bool? isRecurring,
  }) {
    return remoteSource.updateBill(
      id: id,
      category: category,
      name: name,
      amount: amount,
      dueDay: dueDay,
      frequency: frequency,
      isRecurring: isRecurring,
    );
  }

  Future<bool> updateIncome({
    required int id,
    String? incomeType,
    String? payFrequency,
    double? baseIncome,
  }) {
    return remoteSource.updateIncome(
      id: id,
      incomeType: incomeType,
      payFrequency: payFrequency,
      baseIncome: baseIncome,
    );
  }

  Future<bool> addNewGoal({
    required String goalName,
    required double targetAmount,
    required double contribution,
    required String frequency,
  }) {
    return remoteSource.addNewGoal(
      goalName: goalName,
      targetAmount: targetAmount,
      contribution: contribution,
      frequency: frequency,
    );
  }

  Future<bool> addBill({
    required String category,
    required String name,
    required double amount,
    int? dueDay,
    String? frequency,
    bool isRecurring = false,
  }) {
    return remoteSource.addBill(
      category: category,
      name: name,
      amount: amount,
      dueDay: dueDay,
      frequency: frequency,
      isRecurring: isRecurring,
    );
  }
}
