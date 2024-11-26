import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> getAllCountryDataForEdit(String country) async {
    state = state.copyWith(isLoading: true);
    int? countryId;
    String? country1;
    try {
      final response = await http.get(Uri.parse(Api.getallCountry));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;

        final countryData =
            jsonData.map((item) => Country.fromJson(item)).toList();

        state = state.copyWith(isLoading: false, countryList: countryData);
        for(final a in countryData){
          if(a.countrys == country){
            countryId = a.id;
            country1 = a.countrys;
            break;
          }
        }
      } else {
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
    getAllStateData(countryId ?? 0,country1 ?? '');
  }

  Future<void> getAllStateData(int countryId,String country) async {
    state = state.copyWith(isLoading: true);
    int? stateId;
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


        state = state.copyWith(isLoading: false, stateList: stateData);
        for(final a in stateData){
          if(a.states == country){
            print(a.states);
            stateId = a.id;
            break;
          }
        }
      } else {
        state = state.copyWith(isLoading: false, stateList: []);
        throw Exception('Failed to load countrys data');
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, errorMessage: error.toString(), stateList: []);
    }
    getCityData(stateId ?? 0);
  }


  Future<void> getReligiousDetails(String country,String states) async {
    final prefs = await SharedPreferences.getInstance();
    final religionString = prefs.getString('country');
    int? religionId;
    if (religionString != null && religionString.isNotEmpty) {
      final List<dynamic> religious = jsonDecode(religionString);
      List<Country> religionList = religious
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.countrys == country) {
          religionId = a.id;
          break;
        }
      }
      state = state.copyWith(countryList: religionList);
    } else {
      state = state.copyWith(countryList: []);
    }
    getCasteDetails(religionId,states);
  }

  Future<void> getCasteDetails(int? religionId,String states) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('state');
    print('Otha ');
    print(states);
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<StateModel> casteList = castes
          .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.countryId == religionId)
          .toList();
      for (final a in casteList) {
        if (a.states == states) {
          casteId = a.id;
          break;
        }
      }
      state = state.copyWith(stateList: casteList);
    } else {
      state = state.copyWith(stateList: []);
    }
    getSubCasteDetails(casteId);
  }

  Future<void> getSubCasteDetails(int? casteId) async {
    final prefs = await SharedPreferences.getInstance();
    final subCaste = prefs.getString('city');
    if (subCaste != null && subCaste.isNotEmpty) {
      final List<dynamic> subCastes = jsonDecode(subCaste);
      List<City> subCasteList = subCastes
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .where((subcaste) => subcaste.stateId == casteId)
          .toList();
      state = state.copyWith(cityList: subCasteList);
    } else {
      state = state.copyWith(cityList: []);
    }
  }

  Future<bool> editLocationApi(String country, String states, String pinCode,
      String city, String flatNumber, String address, bool? ownHouse) async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
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
        return true;
      } else {
        state = state.copyWith(isLoading: false, cityList: []);
        return false;
      }
    } catch (error) {
      state = state.copyWith(
          isLoading: false, errorMessage: error.toString(), cityList: []);
      return false;
    }
  }
}

final locationProvider = StateNotifierProvider<CountryNotifier, CountryState>(
  (ref) => CountryNotifier(),
);
