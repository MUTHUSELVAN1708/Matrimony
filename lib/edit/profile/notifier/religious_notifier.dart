import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/models/religion_model.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../state/religious_state.dart';
import 'package:http/http.dart' as http;

class ReligiousNotifier extends StateNotifier<ReligiousState> {
  ReligiousNotifier() : super(ReligiousState());

  void updateMotherTongue(String value) {
    state = state.copyWith(motherTongue: value);
  }

  void updateReligion(String value) {
    state = state.copyWith(
        religion: value,
        caste: value != state.religion ? '' : state.caste,
        subCaste: value != state.religion ? '' : state.subCaste);
  }

  void updateCaste(String value) {
    state = state.copyWith(
        caste: value, subCaste: value != state.caste ? '' : state.subCaste);
  }

  void updateSubCaste(String value) {
    state = state.copyWith(subCaste: value);
  }

  void updateWillingToMarry(bool value) {
    state = state.copyWith(willingToMarryOtherCommunities: value);
  }

  void updateStar(String value) {
    state = state.copyWith(star: value);
  }

  void updateRaasi(String value) {
    state = state.copyWith(raasi: value);
  }

  Future<void> getReligiousDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final religionString = prefs.getString('religion');
    int? religionId;
    if (religionString != null && religionString.isNotEmpty) {
      final List<dynamic> religious = jsonDecode(religionString);
      List<Religion> religionList = religious
          .map((e) => Religion.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.religion == state.religion) {
          religionId = a.id;
        }
      }
      state = state.copyWith(religionList: religionList);
    } else {
      state = state.copyWith(religionList: []);
    }
    getCasteDetails(religionId);
  }

  Future<void> getCasteDetails(int? religionId) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('caste');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList = castes
          .map((e) => Caste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.religionId == religionId)
          .toList();
      for (final a in casteList) {
        if (a.castes == state.caste) {
          casteId = a.id;
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
      List<SubCaste> subCasteList = subCastes
          .map((e) => SubCaste.fromJson(e as Map<String, dynamic>))
          .where((subcaste) => subcaste.casteId == casteId)
          .toList();
      state = state.copyWith(subCasteList: subCasteList);
    } else {
      state = state.copyWith(subCasteList: []);
    }
  }

  Future<void> getCasteDetailsList() async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('caste');
    final religion = prefs.getString('religion');
    int? religionId;
    if (religion != null && religion.isNotEmpty) {
      final List<dynamic> religions = jsonDecode(religion);
      List<Religion> religionList = religions
          .map((e) => Religion.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.religion == state.religion) {
          religionId = a.id;
        }
      }
    }
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList = castes
          .map((e) => Caste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.religionId == religionId)
          .toList();
      // casteList.removeWhere((caste) => caste.religionId != religionId);
      state = state.copyWith(casteList: casteList, subCasteList: []);
    } else {
      state = state.copyWith(casteList: [], subCasteList: []);
    }
  }

  Future<void> getSubCasteDetailsList() async {
    final prefs = await SharedPreferences.getInstance();
    final subcaste = prefs.getString('subcaste');
    final caste = prefs.getString('caste');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList =
          castes.map((e) => Caste.fromJson(e as Map<String, dynamic>)).toList();
      for (final a in casteList) {
        if (a.castes == state.caste) {
          casteId = a.id;
        }
      }
    }
    print('casetIf');
    print(casteId);
    if (subcaste != null && subcaste.isNotEmpty) {
      final List<dynamic> subcastes = jsonDecode(subcaste);
      List<SubCaste> subcasteList = subcastes
          .map((e) => SubCaste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.casteId == casteId)
          .toList();
      print(subcasteList);
      // subcasteList.removeWhere((caste) => caste.casteId != casteId);
      state = state.copyWith(subCasteList: subcasteList);
    } else {
      state = state.copyWith(subCasteList: []);
    }
  }

  void setReligiousDetails(UserDetails userDetails) {
    print(userDetails.subcaste);
    state = state.copyWith(
        motherTongue: userDetails.motherTongue,
        caste: userDetails.caste,
        raasi: userDetails.raasi,
        religion: userDetails.religion,
        star: userDetails.star,
        subCaste: userDetails.subcaste,
        willingToMarryOtherCommunities:
            userDetails.willingToMarryFromOtherCommunities);
    print(state.subCaste);
  }

  Future<bool> updateReligiousDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editReligion),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'motherTongue': state.motherTongue,
          'caste': state.caste,
          'raasi': state.raasi,
          'religion': state.religion,
          'star': state.star,
          'subcaste': state.subCaste,
          'willingToMarryFromOtherCommunities':
              state.willingToMarryOtherCommunities
        }),
      );

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body) as List<dynamic>;
        state = state.copyWith(
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
      );
      return false;
    }
  }

  void disposeState() => state = ReligiousState();
}
