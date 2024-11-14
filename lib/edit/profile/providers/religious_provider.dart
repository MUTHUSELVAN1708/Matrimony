import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/religious_state.dart';
import '../notifier/religious_notifier.dart';

final religiousProvider =
    StateNotifierProvider<ReligiousNotifier, ReligiousState>((ref) {
  return ReligiousNotifier();
});
