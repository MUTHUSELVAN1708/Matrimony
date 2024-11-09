import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';

class Country {
  final int id;
  final String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class StateModel {
  final int id;
  final String name;

  StateModel({required this.id, required this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CountryState extends Equatable {
  final bool isLoading;
  final List<Country>? countryList;
  final List<StateModel>? stateList;
  final List<City>? cityList;
  final String? errorMessage;

  const CountryState({
    this.isLoading = false,
    this.countryList,
    this.stateList,
    this.cityList,
    this.errorMessage,
  });

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
  List<Object?> get props =>
      [isLoading, countryList, errorMessage, stateList, cityList];
}

class CountryNotifier extends StateNotifier<CountryState> {
  CountryNotifier() : super(const CountryState());

  Future<void> getallCountryData() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(Uri.parse(Api.getallCountry));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final countryData =
            jsonData.map((item) => Country.fromJson(item)).toList();
        print('_________');
        print(countryData);

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
        body: jsonEncode({'casteId': countryId}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final stateData =
            jsonData.map((item) => StateModel.fromJson(item)).toList();
        print('_________');
        print(stateData);

        state = state.copyWith(isLoading: false, stateList: stateData);
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

  Future<void> getCityData(int cityId) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.post(
        Uri.parse(Api.getcity),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'casteId': cityId}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final cityData = jsonData.map((item) => City.fromJson(item)).toList();
        print('_________');
        print(cityData);

        state = state.copyWith(isLoading: false, cityList: cityData);
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
}

final locationProvider = StateNotifierProvider<CountryNotifier, CountryState>(
  (ref) => CountryNotifier(),
);
