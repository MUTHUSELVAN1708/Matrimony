import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/state/interest_state.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:http/http.dart' as http;

final interestProvider =
    StateNotifierProvider<InterestProvider, InterestState>((ref) {
  return InterestProvider();
});

class InterestProvider extends StateNotifier<InterestState> {
  InterestProvider() : super(InterestState.initial());

  void setStatus(List<SentModel> requestModelList,
      List<ReceiveModel> receivedModelList, String uniqueId) {
    String status = '';
    final matchModel = receivedModelList.firstWhere(
      (model) => model.uniqueId == uniqueId,
      orElse: () => const ReceiveModel(),
    );
    status = matchModel.status ?? '';
    state = state.copyWith(receiveStatus: status);
    print(requestModelList);
    final matchingModel = requestModelList.firstWhere(
      (model) => model.uniqueId == uniqueId,
      orElse: () => const SentModel(),
    );
    print(status);
    status = matchingModel.status ?? '';
    state = state.copyWith(sentStatus: status);
  }

  Future<bool> sendInterest(int receiverId) async {
    state = state.copyWith(isLoading: true, sentStatus: '');

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.send),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'senderId': '$userId', 'receiverId': '$receiverId'},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(sentStatus: 'Pending', isLoading: false);
        return true;
      } else {
        state = state.copyWith(sentStatus: '', isLoading: false);
        return false;
      }
    } catch (error) {
      print(error);
      state = state.copyWith(sentStatus: '', isLoading: false);
      return false;
    }
  }

  Future<bool> doNotShow(int receiverId) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.dontShow),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'userId': userId, 'hiddenUserId': receiverId},
      );
      print(response.body);
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> acceptProfile(String status, int interestId) async {
    state = state.copyWith(isLoading: true);

    try {
      // final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
        Uri.parse('${Api.acceptOrReject}$interestId'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'status': status},
      );

      print(response.body);
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> rejectProfile(String status, int interestId) async {
    state = state.copyWith(isLoading: true);

    try {
      // final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
        Uri.parse('${Api.acceptOrReject}$interestId'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'status': status},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> blockProfile(int blockedId) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.block),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'blockerId': userId, 'blockedId': blockedId},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  Future<bool> reportProfile(int reportedId) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.report),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'reporterId': userId, 'reportedId': reportedId, 'reason': ''},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void disposeState() {
    state = InterestState.initial();
  }
}