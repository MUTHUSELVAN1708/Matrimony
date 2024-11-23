import 'package:matrimony/models/religion_model.dart';

class ReligiousState {
  final String? motherTongue;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final bool? willingToMarryOtherCommunities;
  final String? star;
  final String? raasi;
  final bool isLoading;
  final List<Religion> religionList;
  final List<Caste> casteList;
  final List<SubCaste> subCasteList;

  ReligiousState(
      {this.motherTongue,
      this.religion,
      this.caste,
      this.subCaste,
      this.willingToMarryOtherCommunities,
      this.star,
      this.raasi,
      this.isLoading = false,
      this.religionList = const [],
      this.casteList = const [],
      this.subCasteList = const []});

  ReligiousState copyWith(
      {String? motherTongue,
      String? religion,
      String? caste,
      String? subCaste,
      bool? willingToMarryOtherCommunities,
      String? star,
      String? raasi,
      bool? isLoading,
      List<Religion>? religionList,
      List<Caste>? casteList,
      List<SubCaste>? subCasteList}) {
    return ReligiousState(
        motherTongue: motherTongue ?? this.motherTongue,
        religion: religion ?? this.religion,
        caste: caste ?? this.caste,
        subCaste: subCaste ?? this.subCaste,
        willingToMarryOtherCommunities: willingToMarryOtherCommunities ??
            this.willingToMarryOtherCommunities,
        star: star ?? this.star,
        raasi: raasi ?? this.raasi,
        isLoading: isLoading ?? this.isLoading,
        casteList: casteList ?? this.casteList,
        religionList: religionList ?? this.religionList,
        subCasteList: subCasteList ?? this.subCasteList);
  }
}
