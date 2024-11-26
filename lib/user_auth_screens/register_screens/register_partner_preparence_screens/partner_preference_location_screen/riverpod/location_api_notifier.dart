import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';

class Country {
  final int id;
  final String countrys;

  Country({required this.id, required this.countrys});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      countrys: json['country'],
    );
  }
}

class StateModel {
  final int id;
  final String states;
  final int countryId;

  StateModel({required this.id, required this.states, required this.countryId});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'], states: json['state'], countryId: json['countryId']);
  }
}

class City {
  final int id;
  final String citys;
  final int stateId;
  final int? pincode;

  City(
      {required this.id,
      required this.citys,
      required this.stateId,
      this.pincode});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        citys: json['city'],
        stateId: json['stateId'],
        pincode: json['pincode']);
  }
}

class CountryState extends Equatable {
  final bool isLoading;
  final List<Country> countryList;
  final List<StateModel> stateList;
  final List<City> cityList;
  final String? errorMessage;

  CountryState({
    this.isLoading = false,
    List<Country>? countryList,
    List<StateModel>? stateList,
    List<City>? cityList,
    this.errorMessage,
  })  : countryList = countryList ?? [],
        stateList = stateList ?? [],
        cityList = cityList ?? [];

  CountryState copyWith({
    bool? isLoading,
    List<Country>? countryList,
    List<StateModel>? stateList,
    List<City>? cityList,
    String? errorMessage,
  }) {
    return CountryState(
      isLoading: isLoading ?? this.isLoading,
      countryList: countryList ?? this.countryList,
      stateList: stateList ?? this.stateList,
      cityList: cityList ?? this.cityList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        countryList,
        stateList,
        cityList,
        errorMessage,
      ];
}

class CountryNotifier extends StateNotifier<CountryState> {
  CountryNotifier() : super(CountryState());

  Future<void> getallCountryData() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(Uri.parse(Api.getallCountry));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        final countryData =
            jsonData.map((item) => Country.fromJson(item)).toList();

        state = state.copyWith(isLoading: false, countryList: countryData);
      } else {
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> getStateData(int countryId) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(Api.getState),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'countryId': countryId}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        final stateData =
            jsonData.map((item) => StateModel.fromJson(item)).toList();
        print(stateData.length);

        state = state.copyWith(isLoading: false, stateList: stateData);
      } else {
        state = state.copyWith(isLoading: false, stateList: []);
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, errorMessage: error.toString(), stateList: []);
    }
  }

  Future<void> getCityData(
    int stateId,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(Api.getcity),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'stateId': stateId}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        final cityData = jsonData.map((item) => City.fromJson(item)).toList();

        state = state.copyWith(isLoading: false, cityList: cityData);
      } else {
        state = state.copyWith(isLoading: false, cityList: []);
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, errorMessage: error.toString(), cityList: []);
    }
  }

  Future<void> editLocationApi(String country, String states, String pinCode,
      String city, String flatNumber, String address, bool ownHouse) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.editLocation),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'country': country,
          'state': states,
          'pincode': pinCode,
          'city': city,
          'flatNumber': flatNumber,
          'address': address,
          'ownHouse': ownHouse != null
              ? ownHouse
                  ? 'Yes'
                  : 'No'
              : null
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        final cityData = jsonData.map((item) => City.fromJson(item)).toList();

        state = state.copyWith(isLoading: false, cityList: cityData);
      } else {
        state = state.copyWith(isLoading: false, cityList: []);
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, errorMessage: error.toString(), cityList: []);
    }
  }
}

final locationProvider = StateNotifierProvider<CountryNotifier, CountryState>(
  (ref) => CountryNotifier(),
);
