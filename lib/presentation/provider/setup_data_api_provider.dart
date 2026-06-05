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

  SetupApiDataState copyWith({SetupResponse? data, bool? isLoading, String? error}) =>
      SetupApiDataState(data: data ?? this.data, isLoading: isLoading ?? this.isLoading, error: error);
}

class SetupApiDataNotifier extends Notifier<SetupApiDataState> {
  @override
  SetupApiDataState build() => const SetupApiDataState();

  Future<void> fetchData() async {
    if (state.data != null) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = SetupRepository(
        remoteSource: SetupApiService(apiClient: ApiClient()),
      );
      final data = await repository.getSetupData();
      state = SetupApiDataState(data: data, isLoading: false);
    } catch (e) {
      state = SetupApiDataState(isLoading: false, error: e.toString());
    }
  }

  void refresh() {
    state = const SetupApiDataState();
    fetchData();
  }
}

final setupApiDataProvider = NotifierProvider<SetupApiDataNotifier, SetupApiDataState>(
  SetupApiDataNotifier.new,
);
