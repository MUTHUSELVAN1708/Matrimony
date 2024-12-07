import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/payment_provider.dart';
import 'package:matrimony/models/plan_model.dart';

class PaymentState {
  final List<Plan> planLists;
  final Plan? plan;
  final bool isLoading;

  PaymentState({
    this.planLists = const [],
    this.plan,
    this.isLoading = false,
  });

  PaymentState copyWith({List<Plan>? planLists, bool? isLoading, Plan? plan}) {
    return PaymentState(
        isLoading: isLoading ?? this.isLoading,
        planLists: planLists ?? this.planLists,
        plan: plan ?? this.plan);
  }
}

final paymentNotifier = StateNotifierProvider<PaymentNotifier, PaymentState>(
  (ref) => PaymentNotifier(),
);
