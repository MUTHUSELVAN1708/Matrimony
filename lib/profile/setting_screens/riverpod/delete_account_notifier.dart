import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:http/http.dart' as http;

class DeleteAccountNotifier extends StateNotifier<DeleteAccountState> {
  DeleteAccountNotifier() : super(DeleteAccountState());

  void updateReason(String reason) {
    state = state.copyWith(reason: reason);
  }

  void updateAlreadyMarried(String alreadyMarried) {
    state = state.copyWith(alreadyMarried: alreadyMarried);
  }

  void updateSiteName(String siteName) {
    state = state.copyWith(siteName: siteName, sourceName: '');
  }

  void updateSourceName(String sourceName) {
    state = state.copyWith(sourceName: sourceName, siteName: '');
  }

  void updateDecision(String decision) {
    state = state.copyWith(decision: decision);
  }

  void updateOtherDecision(String otherDecision) {
    state = state.copyWith(otherDecision: otherDecision);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateWeddingDate(String weddingDate) {
    state = state.copyWith(weddingDate: weddingDate);
  }

  void updateImage(String image) {
    state = state.copyWith(image: image);
  }

  void updateSuccessStory(String successStory) {
    state = state.copyWith(successStory: successStory);
  }

  void clearReason() {
    state = DeleteAccountState(reason: state.reason);
  }

  void clearAhathirumanam() {
    state = DeleteAccountState(
        reason: state.reason, alreadyMarried: state.alreadyMarried);
  }

  void clearSiteName() {
    state = DeleteAccountState(
        reason: state.reason,
        alreadyMarried: state.alreadyMarried,
        siteName: state.siteName);
  }

  void clearSourceName() {
    state = DeleteAccountState(
        reason: state.reason,
        alreadyMarried: state.alreadyMarried,
        sourceName: state.sourceName);
  }

  void clearDecision() {
    state = DeleteAccountState(
        reason: state.reason,
        alreadyMarried: state.alreadyMarried,
        decision: state.decision,
        otherDecision: state.otherDecision);
  }

  void clearWeddingName() {
    state = DeleteAccountState(
        reason: state.reason,
        alreadyMarried: state.alreadyMarried,
        sourceName: state.sourceName,
        siteName: state.siteName,
        weddingDate: state.weddingDate,
        name: state.name);
  }

  void clearImage() {
    state = DeleteAccountState(
        reason: state.reason,
        alreadyMarried: state.alreadyMarried,
        sourceName: state.sourceName,
        siteName: state.siteName,
        weddingDate: state.weddingDate,
        name: state.name,
        image: state.image);
  }

  void clearState() {
    state = DeleteAccountState();
  }

  Future<bool> deleteAccount() async {
    state = state.copyWith(isLoading: true);

    final int? userId = await SharedPrefHelper.getUserId();
    // print(jsonEncode({
    //   'userId': userId,
    //   'reason': state.reason,
    //   'siteName': state.alreadyMarried.isNotEmpty
    //       ? state.alreadyMarried != 'Aha Thirumanam'
    //       ? state.siteName.isNotEmpty
    //       ? state.siteName
    //       : null
    //       : state.alreadyMarried
    //       : null,
    //   'sourceName': state.alreadyMarried.isNotEmpty
    //       ? state.alreadyMarried != 'Aha Thirumanam'
    //       ? state.sourceName.isNotEmpty
    //       ? state.sourceName
    //       : null
    //       : null
    //       : null,
    //   'nameOfPartner': state.name.isNotEmpty ? state.name : null,
    //   'weddingDate':
    //   state.weddingDate.isNotEmpty ? state.weddingDate : null,
    //   // 'image': state.image.isNotEmpty ? state.image : null,
    //   'successStory':
    //   state.successStory.isNotEmpty ? state.successStory : null,
    //   'otherDeleteReason': state.decision.isNotEmpty
    //       ? state.decision == 'Any other reason'
    //       ? state.otherDecision
    //       : state.decision
    //       : null,
    // }));
    try {
      final response = await http.delete(
        Uri.parse(Api.deleteAccount),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'reason': state.reason,
          'siteName': state.alreadyMarried.isNotEmpty
              ? state.alreadyMarried != 'Aha Thirumanam'
                  ? state.siteName.isNotEmpty
                      ? state.siteName
                      : ''
                  : state.alreadyMarried
              : '',
          'sourceName': state.alreadyMarried.isNotEmpty
              ? state.alreadyMarried != 'Aha Thirumanam'
                  ? state.sourceName.isNotEmpty
                      ? state.sourceName
                      : ''
                  : ''
              : '',
          'nameOfPartner': state.name.isNotEmpty ? state.name : '',
          'weddingDate': state.weddingDate.isNotEmpty ? state.weddingDate : '',
          'successStory':
              state.successStory.isNotEmpty ? state.successStory : '',
          'otherDeleteReason': state.decision.isNotEmpty
              ? state.decision == 'Any other reason'
                  ? state.otherDecision
                  : state.decision
              : '',
          'image': state.image.isNotEmpty ? state.image : '',
        }),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}
