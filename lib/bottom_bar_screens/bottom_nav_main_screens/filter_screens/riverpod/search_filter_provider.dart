import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/model/search_model.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_state.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;

class SearchFilterProvider extends Notifier<SearchFilterState> {
  @override
  SearchFilterState build() {
    return const SearchFilterState();
  }

  void clearAll() {
    state = state.copyWith(searchModels: [], isLoading: false);
  }

  Future<bool> searchResults(SearchFilterInput search) async {
    state = state.copyWith(isLoading: true, searchModels: []);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      // print(jsonEncode({
      //   'fromAge': search.fromAge ?? '18',
      //   'toAge': search.toAge ?? '40',
      //   'fromHeight': search.fromHeight ?? '4 ft 6 in (137 cm)',
      //   'toHeight': search.toHeight ?? '6 ft 9 in (206 cm)',
      //   'maritalStatus': search.maritalStatus,
      //   'physicalStatus': search.physicalStatus,
      //   'mothertongue': search.motherTongue,
      //   'caste': search.caste,
      //   'religion': search.religion,
      //   'subcaste': search.subcaste,
      //   'occupation': search.profession,
      //   'annualIncome': search.annualIncome,
      //   'employType': search.employedIn,
      //   'education': search.education,
      //   'city': search.city,
      //   'State': search.states,
      //   'country': search.country,
      //   'drinkingHabits': search.drinkingHabits,
      //   'smokingHabits': search.smokingHabits,
      //   'eatingHabits': search.eatingHabits,
      //   'userId': userId
      // }));
      // state = state.copyWith(isLoading: false, searchModels: []);
      // return true;
      final response = await http.post(
        Uri.parse(Api.search),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'fromAge': search.fromAge ?? '18',
          'toAge': search.toAge ?? '40',
          'fromHeight': search.fromHeight ?? '4 ft 6 in (137 cm)',
          'toHeight': search.toHeight ?? '6 ft 9 in (206 cm)',
          'maritalStatus': search.maritalStatus,
          'physicalStatus': search.physicalStatus,
          'mothertongue': search.motherTongue,
          'caste': search.caste,
          'religion': search.religion,
          'subcaste': search.subcaste,
          'occupation': search.profession,
          'annualIncome': search.annualIncome,
          'employType': search.employedIn,
          'education': search.education,
          'city': search.city,
          'State': search.states,
          'country': search.country,
          'drinkingHabits': search.drinkingHabits,
          'smokingHabits': search.smokingHabits,
          'eatingHabits': search.eatingHabits,
          'userId': userId
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final searchModels = data.map((e) => SearchModel.fromJson(e)).toList();
        // print('Otha');
        // print(receivedInterests.first.userId);
        state = state.copyWith(isLoading: false, searchModels: searchModels);
        return true;
      } else {
        state = state.copyWith(isLoading: false, searchModels: []);
        return true;
      }
    } catch (error) {
      state = state.copyWith(isLoading: false, searchModels: []);
      return false;
    }
  }
}
