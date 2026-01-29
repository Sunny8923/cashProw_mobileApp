import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/leads_remote_data_source.dart';

class LeadsState {
  final bool loading;
  final String? error;

  const LeadsState({this.loading = false, this.error});

  LeadsState copyWith({bool? loading, String? error}) {
    return LeadsState(loading: loading ?? this.loading, error: error);
  }
}

class LeadsController extends Notifier<LeadsState> {
  @override
  LeadsState build() => const LeadsState();

  Future<void> createReferralLead({
    required String name,
    required String phone,
    required String product,
    required String location,
  }) async {
    try {
      state = state.copyWith(loading: true, error: null);

      final remote = ref.read(leadsRemoteProvider);

      await remote.createLead(
        name: name,
        phone: phone,
        product: product,
        location: location,
      );

      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      rethrow;
    }
  }
}

final leadsControllerProvider = NotifierProvider<LeadsController, LeadsState>(
  LeadsController.new,
);
