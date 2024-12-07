import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/state/interest_state.dart';
import 'package:matrimony/models/block_dontshow_model.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:http/http.dart' as http;

final interestProvider =
    StateNotifierProvider<InterestProvider, InterestState>((ref) {
  return InterestProvider();
});

class InterestProvider extends StateNotifier<InterestState> {
  InterestProvider() : super(InterestState.initial());

  void setStatus(
      List<SentModel> requestModelList,
      List<ReceiveModel> receivedModelList,
      List<BlockModel> blockList,
      List<DoNotShowModel> ignoredList,
      int userId) {
    final blockModel = blockList.firstWhere((model) => model.userId == userId,
        orElse: () => const BlockModel());
    state = state.copyWith(isBlocked: blockModel.userId != null ? true : false);
    final ignoreModel = ignoredList.firstWhere(
        (model) => model.userId == userId,
        orElse: () => const DoNotShowModel());
    state =
        state.copyWith(isIgnored: ignoreModel.userId != null ? true : false);
    String status = '';
    final matchModel = receivedModelList.firstWhere(
      (model) => model.userId == userId,
      orElse: () => const ReceiveModel(),
    );
    status = matchModel.status ?? '';
    state = state.copyWith(receiveStatus: status);
    final matchingModel = requestModelList.firstWhere(
      (model) => model.userId == userId,
      orElse: () => const SentModel(),
    );
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
        body: {'userId': '$userId', 'hiddenUserId': '$receiverId'},
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
        body: {'blockerId': '$userId', 'blockedId': '$blockedId'},
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

  Future<bool> unblockProfile(int blockedId) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.unblock),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'blockerId': '$userId', 'blockedId': '$blockedId'},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false, isBlocked: false);
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

  Future<bool> showAgain(int hiddenUserId) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.delete(
        Uri.parse(Api.unDontShow),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'userId': '$userId', 'hiddenUserId': '$hiddenUserId'},
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false, isIgnored: false);
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

  Future<bool> reportProfile(int reportedId, String reason) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.report),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'reporterId': '$userId',
          'reportedId': '$reportedId',
          'reason': reason
        },
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

  Future<int?> getUserIdWithUniqueId(String uniqueId) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(Api.getUserIdWithUniqueId),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'uniqueId': uniqueId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        state = state.copyWith(isLoading: false);
        return data['userId'];
      } else {
        state = state.copyWith(isLoading: false);
        return null;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  Future<void> viewUser(int viewId) async {
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse("${Api.profileView}?viewerId=$userId&viewedId=$viewId"),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
      );
      if (response.statusCode == 200) {
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<void> shortListUser(int shortListId) async {
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(
            "${Api.shortList}?favoriterUserId=$userId&favoritedUserId=$shortListId"),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (error) {
      print(error);
    }
  }

  Future<void> unShortListUser(int shortListId) async {
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.delete(
        Uri.parse(
            "${Api.unShortList}?favoriterUserId=$userId&favoritedUserId=$shortListId"),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (error) {
      print(error);
    }
  }

  void disposeState() {
    state = InterestState.initial();
  }
}
