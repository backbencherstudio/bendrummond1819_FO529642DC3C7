import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../models/setup_models.dart';

class SetupApiService {
  final ApiClient apiClient;
  SetupApiService({required this.apiClient});

  Future<bool> submitSetup(SetupRequest request) async {
    try {
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.setUp,
        body: request.toJson(),
      );

      if (response == null) return false;

      log("Setup response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Setup error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateSetup(SetupRequest request) async {
    try {
      final response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.setUp,
        body: request.toJson(),
      );

      if (response == null) return false;

      log("Update setup response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Update setup error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> deleteSetup() async {
    try {
      final response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.setUp,
      );

      if (response == null) return false;

      log("Delete setup response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Delete setup error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> addNewGoal({
    required String goalName,
    required double targetAmount,
    required double contribution,
    required String frequency,
  }) async {
    try {
      final body = {
        'goal_name': goalName,
        'target_amount': targetAmount,
        'contribution': contribution,
        'frequency': frequency,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addNewGoal,
        body: body,
      );

      if (response == null) return false;

      log("Add goal response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Add goal error: ${e.toString()}");
      rethrow;
    }
  }

  Future<SetupResponse?> getSetupData() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.setUp,
      );

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final testJson = SetupResponse.fromJson(
            response['data'] as Map<String, dynamic>,
          );
          debugPrint("TEST JSON $testJson");
          return testJson;
        }
      }

      return null;
    } catch (e) {
      log("Get setup data error: $e");
      return null;
    }
  }

  Future<List<FinancialCommitmentData>> getDebts() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.debts,
      );

      if (response == null) return [];

      log("Get debts response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final list = response['data'] as List<dynamic>;
          return list
              .map(
                (e) =>
                    FinancialCommitmentData.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        }
      }

      return [];
    } catch (e) {
      log("Get debts error: ${e.toString()}");
      return [];
    }
  }

  Future<List<SavingsGoalData>> getSavingGoals() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.savingGoals,
      );

      if (response == null) return [];

      log("Get saving goals response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final data = response['data'] as Map<String, dynamic>;
          final rawList = data['saving_goals'] ?? data['savingsGoals'] ?? [];
          final list = rawList as List<dynamic>;
          return list
              .map((e) => SavingsGoalData.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e) {
      log("Get saving goals error: ${e.toString()}");
      return [];
    }
  }

  Future<List<FinancialCommitmentData>> getMonthlyBills() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.monthlyBills,
      );

      if (response == null) return [];

      log("Get monthly bills response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final data = response['data'] as Map<String, dynamic>;
          final list = data['financialCommitments'] as List<dynamic>;
          return list
              .map(
                (e) =>
                    FinancialCommitmentData.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        }
      }

      return [];
    } catch (e) {
      log("Get monthly bills error: ${e.toString()}");
      return [];
    }
  }

  Future<bool> deleteSavingGoal(String id) async {
    try {
      final response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.deletSavingGoalById(id),
      );

      if (response == null) return false;

      log("Delete saving goal response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Delete saving goal error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> deleteBill(String id) async {
    try {
      final response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.billById(id),
      );

      if (response == null) return false;

      log("Delete bill response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Delete bill error: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<IncomeData>> getPayIncomes() async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.payIncomes,
      );

      if (response == null) return [];

      log("Get pay incomes response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          final list = response['data'] as List<dynamic>;
          return list
              .map((e) => IncomeData.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e) {
      log("Get pay incomes error: ${e.toString()}");
      return [];
    }
  }

  Future<bool> updateSavingGoal({
    required String id,
    String? goalName,
    double? targetAmount,
    double? contribution,
    String? frequency,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (goalName != null) body['goal_name'] = goalName;
      if (targetAmount != null) body['target_amount'] = targetAmount;
      if (contribution != null) body['contribution'] = contribution;
      if (frequency != null) body['frequency'] = frequency;

      final response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.savingGoalById(id),
        body: body,
      );

      if (response == null) return false;

      log("Update saving goal response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Update saving goal error: ${e.toString()}");
      rethrow;
    }
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
      final body = <String, dynamic>{};
      if (category != null) body['category'] = category;
      if (name != null) body['name'] = name;
      if (amount != null) body['amount'] = amount;
      if (dueDay != null) body['due_day'] = dueDay;
      if (frequency != null) body['frequency'] = frequency;
      if (isRecurring != null) body['is_recurring'] = isRecurring;

      final response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.billForPatch(id),
        body: body,
      );

      if (response == null) return false;

      log("Update bill response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Update bill error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateIncome({
    required String id,
    String? incomeType,
    String? payFrequency,
    double? baseIncome,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (incomeType != null) body['income_type'] = incomeType;
      if (payFrequency != null) body['pay_frequency'] = payFrequency;
      if (baseIncome != null) body['base_income'] = baseIncome;

      final response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.incomeForPatch(id),
        body: body,
      );

      if (response == null) return false;

      log("Update income response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Update income error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> deleteIncome(String id) async {
    try {
      final response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.deleteIncomeById(id),
      );

      if (response == null) return false;

      log("Delete income response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Delete income error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> addIncome({
    required String incomeType,
    required String payFrequency,
    required double baseIncome,
  }) async {
    try {
      final body = {
        'income_type': incomeType,
        'pay_frequency': payFrequency,
        'base_income': baseIncome,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addIncome,
        body: body,
      );

      if (response == null) return false;

      log("Add income response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Add income error: ${e.toString()}");
      rethrow;
    }
  }

  Future<FinancialCommitmentData?> getBillById(String id) async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.billById(id),
      );

      if (response == null) return null;

      log("Get bill by id response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true && response['data'] != null) {
          return FinancialCommitmentData.fromJson(
            response['data'] as Map<String, dynamic>,
          );
        }
      }

      return null;
    } catch (e) {
      log("Get bill by id error: ${e.toString()}");
      return null;
    }
  }

  Future<bool> addBill({
    required String category,
    required String name,
    required double amount,
    int? dueDay,
    String? frequency,
    bool isRecurring = false,
  }) async {
    try {
      final body = {
        'category': category,
        'name': name,
        'amount': amount,
        if (dueDay != null) 'due_day': dueDay,
        if (frequency != null) 'frequency': frequency,
        'is_recurring': isRecurring,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addBill,
        body: body,
      );

      if (response == null) return false;

      log("Add bill response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Add bill error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> addDebt({
    required String name,
    required double amount,
    int? dueDay,
  }) async {
    try {
      final body = <String, dynamic>{
        'name': name,
        'amount': amount,
        if (dueDay != null) 'due_day': dueDay,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.addDebt,
        body: body,
      );

      if (response == null) return false;

      log("Add debt response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Add debt error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> deleteDebt(String id) async {
    try {
      final response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.debtById(id),
      );

      if (response == null) return false;

      log("Delete debt response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Delete debt error: ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateDebt({
    required String id,
    String? name,
    double? amount,
    int? dueDay,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (amount != null) body['amount'] = amount;
      if (dueDay != null) body['due_day'] = dueDay;

      final response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.debtById(id),
        body: body,
      );

      if (response == null) return false;

      log("Update debt response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Update debt error: ${e.toString()}");
      rethrow;
    }
  }
}
