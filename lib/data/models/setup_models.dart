class IncomeData {
  final String? id;
  final String incomeType;
  final String payFrequency;
  final double baseIncome;

  IncomeData({
    this.id,
    required this.incomeType,
    required this.payFrequency,
    required this.baseIncome,
  });

  factory IncomeData.fromJson(Map<String, dynamic> json) => IncomeData(
    id: json['id']?.toString(),
    incomeType: json['income_type'] ?? '',
    payFrequency: json['pay_frequency'] ?? '',
    baseIncome: (json['base_income'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'income_type': incomeType,
    'pay_frequency': payFrequency,
    'base_income': baseIncome,
  };
}

class FinancialCommitmentData {
  final String? id;
  final String category;
  final String name;
  final double amount;
  final int? dueDay;
  final String? frequency;
  final bool isRecurring;

  FinancialCommitmentData({
    this.id,
    required this.category,
    required this.name,
    required this.amount,
    this.dueDay,
    this.frequency,
    this.isRecurring = false,
  });

  factory FinancialCommitmentData.fromJson(Map<String, dynamic> json) =>
      FinancialCommitmentData(
        id: json['id']?.toString(),
        category: json['category'] ?? '',
        name: json['name'] ?? '',
        amount: double.tryParse(json['amount']?.toString() ?? '') ?? 0,
        dueDay: json['due_day'] is int ? json['due_day'] as int : int.tryParse(json['due_day']?.toString() ?? ''),
        frequency: json['frequency'],
        isRecurring: json['is_recurring'] == true || json['is_recurring'] == 1,
      );

  Map<String, dynamic> toJson() => {
    'category': category,
    'name': name,
    'amount': amount,
    if (dueDay != null) 'due_day': dueDay,
    if (frequency != null) 'frequency': frequency,
    'is_recurring': isRecurring,
  };
}

class SavingsGoalData {
  final String? id;
  final String goalName;
  final double targetAmount;
  final double contribution;
  final String frequency;

  SavingsGoalData({
    this.id,
    required this.goalName,
    required this.targetAmount,
    required this.contribution,
    required this.frequency,
  });

  factory SavingsGoalData.fromJson(Map<String, dynamic> json) =>
      SavingsGoalData(
        id: json['id']?.toString(),
        goalName: json['goal_name'] ?? '',
        targetAmount: double.tryParse(json['target_amount'].toString()) ?? 0,
        contribution: double.tryParse(json['contribution'].toString()) ?? 0,
        frequency: json['frequency'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'goal_name': goalName,
    'target_amount': targetAmount,
    'contribution': contribution,
    'frequency': frequency,
  };
}

class SetupRequest {
  final List<IncomeData> incomes;
  final List<FinancialCommitmentData> financialCommitments;
  final List<SavingsGoalData> savingsGoals;

  SetupRequest({
    required this.incomes,
    required this.financialCommitments,
    required this.savingsGoals,
  });

  Map<String, dynamic> toJson() => {
    'incomes': incomes.map((e) => e.toJson()).toList(),
    'financialCommitments': financialCommitments
        .map((e) => e.toJson())
        .toList(),
    'savingsGoals': savingsGoals.map((e) => e.toJson()).toList(),
  };
}

class SetupResponse {
  final List<IncomeData> incomes;
  final List<FinancialCommitmentData> financialCommitments;
  final List<SavingsGoalData> savingsGoals;

  SetupResponse({
    required this.incomes,
    required this.financialCommitments,
    required this.savingsGoals,
  });

  factory SetupResponse.fromJson(Map<String, dynamic> json) => SetupResponse(
    incomes:
        (json['incomes'] as List<dynamic>?)
            ?.map((e) => IncomeData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    financialCommitments:
        (json['financialCommitments'] as List<dynamic>?)
            ?.map(
              (e) =>
                  FinancialCommitmentData.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [],
    savingsGoals:
        (json['savingsGoals'] as List<dynamic>?)
            ?.map((e) => SavingsGoalData.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
