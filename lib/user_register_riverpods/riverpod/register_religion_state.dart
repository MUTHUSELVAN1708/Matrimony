class RegisterReligionState {
  final String? motherTongue;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final String? otherMotherTongue;
  final String? otherReligion;
  final String? otherCaste;
  final String? otherSubCaste;
  final bool willingToMarryOtherCastes;
  final bool isLoading;

  RegisterReligionState({
    this.motherTongue,
    this.religion,
    this.caste,
    this.subCaste,
    this.otherMotherTongue,
    this.otherReligion,
    this.otherCaste,
    this.otherSubCaste,
    this.willingToMarryOtherCastes = false,
    this.isLoading = false,
  });

  RegisterReligionState copyWith({
    String? motherTongue,
    String? religion,
    String? caste,
    String? subCaste,
    String? otherMotherTongue,
    String? otherReligion,
    String? otherCaste,
    String? otherSubCaste,
    bool? willingToMarryOtherCastes,
    bool? isLoading,
  }) {
    return RegisterReligionState(
      motherTongue: motherTongue ?? this.motherTongue,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subCaste: subCaste ?? this.subCaste,
      otherMotherTongue: otherMotherTongue ?? this.otherMotherTongue,
      otherReligion: otherReligion ?? this.otherReligion,
      otherCaste: otherCaste ?? this.otherCaste,
      otherSubCaste: otherSubCaste ?? this.otherSubCaste,
      willingToMarryOtherCastes:
          willingToMarryOtherCastes ?? this.willingToMarryOtherCastes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
