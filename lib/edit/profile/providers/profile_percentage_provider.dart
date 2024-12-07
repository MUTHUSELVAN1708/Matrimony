import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_state.dart';
import 'package:http/http.dart' as http;

class IncompleteFieldsNotifier extends StateNotifier<IncompleteFieldsState> {
  IncompleteFieldsNotifier()
      : super(IncompleteFieldsState(
            incompleteFields: IncompleteFields(
                completionPercentage: 0.0,
                govtIdProof: true,
                horoscope: true,
                location: true,
                professional: true,
                registration: true,
                religious: true,
                uploadPhoto: true)));

  Future<void> getIncompleteFields() async {
    if (state.incompleteFields.completionPercentage.toInt() != 100) {
      state = state.copyWith(isLoading: true);
      try {
        final int? userId = await SharedPrefHelper.getUserId();

        final response = await http.post(
          Uri.parse(Api.profilePercentage),
          headers: {
            'Content-Type': 'application/json',
            'AppId': '1',
          },
          body: jsonEncode({
            'userId': userId,
          }),
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          state = state.copyWith(
              incompleteFields: IncompleteFields.fromJson(data),
              isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
          );
        }
      } catch (e) {
        print(e);
        state = state.copyWith(
          isLoading: false,
        );
      }
    }
  }
}
