import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_clients.dart';
import '../../../data/models/setup_models.dart';
import '../../../data/repositories/setup_repository.dart';
import '../../../data/sources/remote/setup_api_service.dart';

class SetupApiDataState {
  final SetupResponse? data;
  final bool isLoading;
  final String? error;

  const SetupApiDataState({this.data, this.isLoading = false, this.error});

  SetupApiDataState copyWith({
    SetupResponse? data,
    bool? isLoading,
    String? error,
  }) => SetupApiDataState(
    data: data ?? this.data,
    isLoading: isLoading ?? this.isLoading,
    error: error,
  );
}

class SetupApiDataNotifier extends Notifier<SetupApiDataState> {
  @override
  SetupApiDataState build() => const SetupApiDataState();
  //fetchData
  Future<void> fetchData() async {
    if (state.data != null) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final data = await repository.getSetupData();
      debugPrint("Data inside $data");
      state = SetupApiDataState(data: data, isLoading: false);
    } catch (e) {
      state = SetupApiDataState(isLoading: false, error: e.toString());
    }
  }

  //deletegoal

  Future<bool> deleteGoal(String id) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );

      final success = await repository.deleteSavingGoal(id);
      if (success) {
        refresh();
      }
      return success;
    } catch (e) {
      debugPrint("Delete error $e");
      return false;
    }
  }

  void refresh() {
    state = const SetupApiDataState();
    fetchData();
  }
}

final setupApiDataProvider =
    NotifierProvider<SetupApiDataNotifier, SetupApiDataState>(
      SetupApiDataNotifier.new,
    );

class SavingGoalsNotifier extends Notifier<List<SavingsGoalData>> {
  @override
  List<SavingsGoalData> build() => [];

  Future<void> fetchGoals() async {
    state = [];
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final goals = await repository.getSavingGoals();
      state = goals;
    } catch (e) {
      debugPrint("Fetch saving goals error: $e");
    }
  }

  void refresh() {
    state = [];
    fetchGoals();
  }

  Future<bool> deleteGoal(String id) async {
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final success = await repository.deleteSavingGoal(id);
      if (success) {
        refresh();
      }
      return success;
    } catch (e) {
      debugPrint("Delete saving goal error: $e");
      return false;
    }
  }
}

final savingGoalsProvider =
    NotifierProvider<SavingGoalsNotifier, List<SavingsGoalData>>(
      SavingGoalsNotifier.new,
    );
