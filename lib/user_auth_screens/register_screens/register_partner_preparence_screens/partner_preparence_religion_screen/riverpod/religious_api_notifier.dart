import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/models/religion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReligiousModel extends Equatable {
  final int id;
  final String religion;

  const ReligiousModel({required this.id, required this.religion});

  ReligiousModel copyWith({int? id, String? religion}) {
    return ReligiousModel(
      id: id ?? this.id,
      religion: religion ?? this.religion,
    );
  }

  factory ReligiousModel.fromJson(Map<String, dynamic> json) {
    return ReligiousModel(
      id: json['id'] as int,
      religion: json['religion'] as String,
    );
  }

  @override
  List<Object?> get props => [id, religion];
}

class CasteModel extends Equatable {
  final int id;
  final String caste;
  final int? religionId;

  const CasteModel({required this.id, required this.caste, this.religionId});

  CasteModel copyWith({int? id, String? religion, int? religionId}) {
    return CasteModel(
        id: id ?? this.id,
        caste: religion ?? this.caste,
        religionId: religionId ?? this.religionId);
  }

  factory CasteModel.fromJson(Map<String, dynamic> json) {
    return CasteModel(
        id: json['id'] as int,
        caste: json['castes'] as String,
        religionId: json['religionId'] as int);
  }

  @override
  List<Object?> get props => [id, caste];
}

class SubCasteModel extends Equatable {
  final int id;
  final String subCaste;
  final int? casteId;

  const SubCasteModel({required this.id, required this.subCaste, this.casteId});

  SubCasteModel copyWith({int? id, String? subCaste, int? casteId}) {
    return SubCasteModel(
        id: id ?? this.id,
        subCaste: subCaste ?? this.subCaste,
        casteId: casteId ?? this.casteId);
  }

  factory SubCasteModel.fromJson(Map<String, dynamic> json) {
    return SubCasteModel(
        id: json['id'] as int,
        subCaste: json['subCaste'] as String,
        casteId: json['casteId'] as int);
  }

  @override
  List<Object?> get props => [id, subCaste, casteId];
}

class ReligiousState extends Equatable {
  final bool isLoading;
  final List<ReligiousModel> data;
  final List<CasteModel> casteList;
  final List<SubCasteModel> subCasteList;
  final String? errorMessage;

  ReligiousState({
    this.isLoading = false,
    this.data = const [],
    this.casteList = const [],
    this.subCasteList = const [],
    this.errorMessage,
  });

  ReligiousState copyWith({
    bool? isLoading,
    List<ReligiousModel>? data,
    List<CasteModel>? casteList,
    List<SubCasteModel>? subCasteList,
    String? errorMessage,
  }) {
    return ReligiousState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      casteList: casteList ?? this.casteList,
      subCasteList: subCasteList ?? this.subCasteList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, data, errorMessage, subCasteList, casteList];
}

class ReligiousNotifier extends StateNotifier<ReligiousState> {
  ReligiousNotifier() : super(ReligiousState());

  Future<void> getReligiousData() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(Uri.parse(Api.getAllReligion));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final religiousData =
            jsonData.map((item) => ReligiousModel.fromJson(item)).toList();
        print('_________');
        print(religiousData);

        state = state.copyWith(isLoading: false, data: religiousData);
      } else {
        throw Exception('Failed to load religious data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> getCasteData(int religioId) async {
    state = state.copyWith(isLoading: true);
    print('+++++++++');

    try {
      final response = await http.post(
        Uri.parse(Api.getcaste),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(
            {'religionId': religioId}), // Send the request body as JSON
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final casteData =
            jsonData.map((item) => CasteModel.fromJson(item)).toList();
        print('_________');
        print(casteData);

        state = state.copyWith(isLoading: false, casteList: casteData);
      } else {
        throw Exception('Failed to load caste data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
      print('Error: $error');
    }
  }

  Future<void> getReligiousDetails(String? religion, String? caste) async {
    final prefs = await SharedPreferences.getInstance();
    final religionString = prefs.getString('religion');
    int? religionId;
    if (religionString != null && religionString.isNotEmpty) {
      final List<dynamic> religious = jsonDecode(religionString);
      List<ReligiousModel> religionList = religious
          .map((e) => ReligiousModel.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.religion == religion) {
          religionId = a.id;
          break;
        }
      }
      state = state.copyWith(data: religionList);
    } else {
      state = state.copyWith(data: []);
    }
    getCasteDetails(religionId, caste);
  }

  Future<void> getCasteDetails(int? religionId, String? caste1) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('caste');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<CasteModel> casteList = castes
          .map((e) => CasteModel.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.religionId == religionId)
          .toList();
      for (final a in casteList) {
        if (a.caste == caste1) {
          casteId = a.id;
          break;
        }
      }
      state = state.copyWith(casteList: casteList);
    } else {
      state = state.copyWith(casteList: []);
    }
    getSubCasteDetails(casteId);
  }

  Future<void> getSubCasteDetails(int? casteId) async {
    final prefs = await SharedPreferences.getInstance();
    final subCaste = prefs.getString('subcaste');
    if (subCaste != null && subCaste.isNotEmpty) {
      final List<dynamic> subCastes = jsonDecode(subCaste);
      List<SubCasteModel> subCasteList = subCastes
          .map((e) => SubCasteModel.fromJson(e as Map<String, dynamic>))
          .where((subcaste) => subcaste.casteId == casteId)
          .toList();
      state = state.copyWith(subCasteList: subCasteList);
    } else {
      state = state.copyWith(subCasteList: []);
    }
  }

  void removeCasteData() async {
    state = state.copyWith(casteList: [], subCasteList: []);
  }

  void removeSubCasteData() async {
    state = state.copyWith(subCasteList: []);
  }

  Future<void> getSubCasteData(int casteId) async {
    state = state.copyWith(isLoading: true);
    print('+++++++++');

    try {
      final response = await http.post(
        Uri.parse(Api.getSubcaste),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'casteId': casteId}),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final subCasteData =
            jsonData.map((item) => SubCasteModel.fromJson(item)).toList();
        print('_________');
        print(subCasteData);

        state = state.copyWith(isLoading: false, subCasteList: subCasteData);
      } else {
        throw Exception('Failed to load caste data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
      print('Error: $error');
    }
  }
}

final religiousProvider =
    StateNotifierProvider<ReligiousNotifier, ReligiousState>(
  (ref) => ReligiousNotifier(),
);
