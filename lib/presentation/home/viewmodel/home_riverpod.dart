import 'package:bendrummond1819_fo529642dc3c7/presentation/auth/signup/setup/viewmodel/setup_data_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/incomes_provider.dart';

class HomeSummary {
  final double safeToSpend;
  final double monthlyIncome;
  final double bills;
  final String payFrequencyLabel;
  final int billsCount;

  const HomeSummary({
    this.safeToSpend = 0,
    this.monthlyIncome = 0,
    this.bills = 0,
    this.payFrequencyLabel = 'monthly paycheck',
    this.billsCount = 0,
  });
}

class HomeViewModel {
  static const Map<String, double> _payFrequencyMultipliers = {
    'WEEKLY': 4.33,
    'EVERY_2_WEEKS': 2.17,
    'TWICE_A_MONTH': 2.0,
    'MONTHLY': 1.0,
  };

  static const List<double> _indexMultipliers = [4.33, 2.17, 2.0, 1.0];

  static const List<String> _payFrequencyLabels = [
    'weekly',
    'every 2 weeks',
    'twice a month',
    'monthly',
  ];

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  HomeSummary compute({
    required IncomesState incomeState,
    required SetupDataState setupData,
  }) {
    if (incomeState.incomes.isNotEmpty) {
      final monthlyIncome = incomeState.incomes.fold<double>(
        0,
        (sum, i) => sum + i.baseIncome * _multiplier(i.payFrequency),
      );
      final totalBills = incomeState.financialCommitments.fold<double>(
        0,
        (sum, c) => sum + c.amount,
      );
      final totalSavings = incomeState.savingsGoals.fold<double>(
        0,
        (sum, g) => sum + g.contribution,
      );
      return HomeSummary(
        safeToSpend: monthlyIncome - totalBills - totalSavings,
        monthlyIncome: monthlyIncome,
        bills: totalBills,
        payFrequencyLabel:
            '${incomeState.incomes.first.payFrequency.replaceAll('_', ' ').toLowerCase()} paycheck',
        billsCount: incomeState.financialCommitments.length,
      );
    }

    if (setupData.baseIncome.isNotEmpty) {
      final income = double.tryParse(setupData.baseIncome) ?? 0;
      final monthlyIncome =
          income * _indexMultiplier(setupData.payFrequencyIndex);
      final rent = double.tryParse(setupData.rentAmount) ?? 0;
      final carPayment = double.tryParse(setupData.carPaymentAmount) ?? 0;
      final billsTotal = setupData.bills.fold<double>(
        0,
        (sum, bill) => sum + (double.tryParse(bill['amount'] ?? '0') ?? 0),
      );
      final debtsTotal = setupData.debts.fold<double>(
        0,
        (sum, debt) => sum + (double.tryParse(debt['amount'] ?? '0') ?? 0),
      );
      final savingsTotal = setupData.savings.fold<double>(
        0,
        (sum, goal) => sum + (double.tryParse(goal['amount'] ?? '0') ?? 0),
      );
      return HomeSummary(
        safeToSpend:
            monthlyIncome -
            rent -
            carPayment -
            billsTotal -
            debtsTotal -
            savingsTotal,
        monthlyIncome: monthlyIncome,
        bills: rent + carPayment + billsTotal + debtsTotal,
        payFrequencyLabel: _payFrequencyLabel(setupData.payFrequencyIndex),
        billsCount: setupData.bills.length + setupData.debts.length,
      );
    }

    return const HomeSummary();
  }

  double _multiplier(String frequency) =>
      _payFrequencyMultipliers[frequency] ?? 1;

  double _indexMultiplier(int index) =>
      index >= 0 && index < _indexMultipliers.length
      ? _indexMultipliers[index]
      : 1;

  String _payFrequencyLabel(int index) =>
      index >= 0 && index < _payFrequencyLabels.length
      ? '${_payFrequencyLabels[index]} paycheck'
      : 'monthly paycheck';
}
