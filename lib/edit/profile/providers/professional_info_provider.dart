import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/professional_info_notifier.dart';
import '../state/professional_info_state.dart';

final professionalInfoProvider =
StateNotifierProvider<ProfessionalInfoNotifier, ProfessionalInfoState>((ref) {
  return ProfessionalInfoNotifier();
});