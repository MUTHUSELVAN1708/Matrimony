import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/models/block_dontshow_model.dart';
import 'package:matrimony/models/interest_model.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/models/report_model.dart';
import 'package:matrimony/models/shortlist_model.dart';
import 'package:matrimony/models/view_model.dart';

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
    state = state.copyWith(
        sentInterests: [],
        receivedInterests: [],
        ignoredLists: [],
        blockLists: [],
        reportLists: [],
        blockedMeList: [],
        viewList: [],
        shortList: [],
        isLoading: false);
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
            data.map((e) => ReceiveModel.fromJson(e)).toList();
        // print('Otha');
        // print(receivedInterests.first.userId);
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
        final sentInterests = data.map((e) => SentModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, sentInterests: sentInterests);
      } else {
        state = state.copyWith(isLoading: false, sentInterests: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, sentInterests: []);
    }
  }

  Future<void> getBlockedUsers() async {
    state = state.copyWith(isLoading: false, blockLists: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.blocked}?blockerId=$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final blockLists = data.map((e) => BlockModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, blockLists: blockLists);
      } else {
        state = state.copyWith(isLoading: false, blockLists: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, blockLists: []);
    }
  }

  Future<void> getDoNotShowUsers() async {
    state = state.copyWith(isLoading: false, ignoredLists: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.dontShow}?userId=$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final ignoredLists =
            data.map((e) => DoNotShowModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, ignoredLists: ignoredLists);
      } else {
        state = state.copyWith(isLoading: false, ignoredLists: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, ignoredLists: []);
    }
  }

  Future<void> getReportedUsers() async {
    state = state.copyWith(isLoading: false, reportLists: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.reported}?reporterId=$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final reportLists = data.map((e) => ReportModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, reportLists: reportLists);
      } else {
        state = state.copyWith(isLoading: false, reportLists: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, reportLists: []);
    }
  }

  Future<void> getMeBlockedUsers() async {
    state = state.copyWith(isLoading: false, blockedMeList: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.myBlocked}$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final blockedMeList = List<int>.from(data);
        state = state.copyWith(isLoading: false, blockedMeList: blockedMeList);
      } else {
        state = state.copyWith(isLoading: false, blockedMeList: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, blockedMeList: []);
    }
  }

  Future<void> getViewedList() async {
    state = state.copyWith(isLoading: true, viewList: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getProfileView}/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final viewList = data.map((e) => ViewModel.fromJson(e)).toList();
        // print('Otha');
        // print(receivedInterests.first.userId);
        state = state.copyWith(isLoading: false, viewList: viewList);
      } else {
        state = state.copyWith(isLoading: false, viewList: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, viewList: []);
    }
  }

  Future<void> getViewedToMeList() async {
    state = state.copyWith(isLoading: true, viewListToMe: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getMyProfileViews}/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final viewList = data.map((e) => ViewModel.fromJson(e)).toList();
        // print('Otha');
        // print(receivedInterests.first.userId);
        state = state.copyWith(isLoading: false, viewListToMe: viewList);
      } else {
        state = state.copyWith(isLoading: false, viewListToMe: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, viewListToMe: []);
    }
  }

  Future<void> getShortList() async {
    state = state.copyWith(isLoading: true, shortList: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getShortListedYou}/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final shortlist = data.map((e) => ShortlistModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, shortList: shortlist);
      } else {
        state = state.copyWith(isLoading: false, shortList: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, shortList: []);
    }
  }

  Future<void> getShortListToMe() async {
    state = state.copyWith(isLoading: true, shortListToMe: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.get(
        Uri.parse("${Api.getShortListedMe}/$userId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final shortlist = data.map((e) => ShortlistModel.fromJson(e)).toList();
        state = state.copyWith(isLoading: false, shortListToMe: shortlist);
      } else {
        state = state.copyWith(isLoading: false, shortListToMe: []);
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, shortListToMe: []);
    }
  }

  void removeIgnoreList(int userId) {
    state = state.copyWith(
      ignoredLists:
          state.ignoredLists.where((model) => model.userId != userId).toList(),
    );
  }

  void removeBlockList(int userId) {
    state = state.copyWith(
      blockLists:
          state.blockLists.where((model) => model.userId != userId).toList(),
    );
  }
}
