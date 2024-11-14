class ReligiousState {
  final String? motherTongue;
  final String? religion;
  final String? caste;
  final String? subCaste;
  final bool willingToMarryOtherCommunities;
  final String? star;
  final String? raasi;

  ReligiousState({
    this.motherTongue,
    this.religion,
    this.caste,
    this.subCaste,
    this.willingToMarryOtherCommunities = false,
    this.star,
    this.raasi,
  });

  ReligiousState copyWith({
    String? motherTongue,
    String? religion,
    String? caste,
    String? subCaste,
    bool? willingToMarryOtherCommunities,
    String? star,
    String? raasi,
  }) {
    return ReligiousState(
      motherTongue: motherTongue ?? this.motherTongue,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subCaste: subCaste ?? this.subCaste,
      willingToMarryOtherCommunities:
          willingToMarryOtherCommunities ?? this.willingToMarryOtherCommunities,
      star: star ?? this.star,
      raasi: raasi ?? this.raasi,
    );
  }
}
