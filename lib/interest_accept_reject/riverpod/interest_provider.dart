import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:http/http.dart' as http;

class InterestModelNotifier extends Notifier<InterestModelState> {
  @override
  InterestModelState build() {
    return const InterestModelState();
  }

  void addSendInterest(SentModel model) {
    final updatedList = List<SentModel>.from(state.sentInterests)..add(model);
    state = state.copyWith(sentInterests: updatedList);
  }

  void addReceivedInterest(ReceiveModel model) {
    final updatedList = List<ReceiveModel>.from(state.receivedInterests)
      ..add(model);
    state = state.copyWith(receivedInterests: updatedList);
  }

  void clearAll() {
    state = state
        .copyWith(sentInterests: [], receivedInterests: [], isLoading: false);
  }

  Future<void> getReceivedInterests() async {
    state = state.copyWith(isLoading: true, receivedInterests: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getReceivedList}?receiverId=$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final receivedInterests =
            data.map((e) => ReceiveModel.fromJson(e, true)).toList();
        state = state.copyWith(
            isLoading: false, receivedInterests: receivedInterests);
      } else {
        state = state.copyWith(isLoading: false, receivedInterests: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, receivedInterests: []);
    }
  }

  Future<void> getSentInterests() async {
    state = state.copyWith(isLoading: false, sentInterests: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getSentList}?senderId=$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final sentInterests =
            data.map((e) => SentModel.fromJson(e, null)).toList();
        state = state.copyWith(isLoading: false, sentInterests: sentInterests);
      } else {
        state = state.copyWith(isLoading: false, sentInterests: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, sentInterests: []);
    }
  }
}
