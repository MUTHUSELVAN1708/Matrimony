import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/payment_state.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/models/plan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentNotifier extends StateNotifier<PaymentState> {
  PaymentNotifier() : super(PaymentState());

  void clearState() {
    state = PaymentState();
  }

  Future<void> getAllPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final plans = prefs.getString('plans');
    if (plans == null || plans.isEmpty) {
      final response = await http.get(Uri.parse(Api.getAllPlans));
      if (response.statusCode == 200) {
        await prefs.setString('plans', response.body);
      }
    }
    if (state.planLists.isEmpty) {
      await setPlans();
    }
  }

  Future<void> setPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final plans = prefs.getString('plans');

    if (plans != null && plans.isNotEmpty) {
      final List<dynamic> decodedPlans = jsonDecode(plans);
      final List<Plan> planList = decodedPlans.map((planJson) {
        return Plan.fromJson(planJson);
      }).toList();
      state = state.copyWith(planLists: planList);
    }
  }

  void getPlan(int planId) async {
    final plan = state.planLists.firstWhere(
      (plan) => plan.planId == planId,
    );
    state = state.copyWith(plan: plan);
  }
}
