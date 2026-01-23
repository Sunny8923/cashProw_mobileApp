import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_leads_usecase.dart';
import '../../models/lead_model.dart';
import 'leads_providers.dart';

class LeadsState {
  final bool isLoading;
  final List<LeadModel> leads;
  final String? error;

  const LeadsState({this.isLoading = false, this.leads = const [], this.error});

  LeadsState copyWith({
    bool? isLoading,
    List<LeadModel>? leads,
    String? error,
  }) {
    return LeadsState(
      isLoading: isLoading ?? this.isLoading,
      leads: leads ?? this.leads,
      error: error,
    );
  }
}

class LeadsController extends Notifier<LeadsState> {
  late final GetLeadsUseCase _getLeadsUseCase;

  @override
  LeadsState build() {
    _getLeadsUseCase = ref.read(getLeadsUseCaseProvider);
    return const LeadsState();
  }

  Future<void> fetchLeads() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final leads = await _getLeadsUseCase();
      state = state.copyWith(isLoading: false, leads: leads);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst("Exception: ", ""),
      );
    }
  }
}

final leadsControllerProvider = NotifierProvider<LeadsController, LeadsState>(
  LeadsController.new,
);
