class FamilyDetailsState {
  final String? famliyValue;
  final String? famliyType;
  final String? famliyStatus;
  final String? fatherName;
  final String? fatherOccupation;
  final String? motherName;
  final String? motherOccupation;
  final int? noOfBrothers;
  final int? noOfSisters;
  final String? brotherMarried;
  final String? sisterMarried;
  final bool isLoading;

  FamilyDetailsState({
    this.famliyValue,
    this.famliyType,
    this.famliyStatus,
    this.fatherName,
    this.fatherOccupation,
    this.motherName,
    this.motherOccupation,
    this.noOfBrothers,
    this.noOfSisters,
    this.brotherMarried,
    this.sisterMarried,
    this.isLoading = false,
  });

  FamilyDetailsState copyWith({
    String? famliyValue,
    String? famliyType,
    String? famliyStatus,
    String? fatherName,
    String? fatherOccupation,
    String? motherName,
    String? motherOccupation,
    int? noOfBrothers,
    int? noOfSisters,
    String? brotherMarried,
    String? sisterMarried,
    bool? isLoading,
  }) {
    return FamilyDetailsState(
      famliyValue: famliyValue ?? this.famliyValue,
      famliyType: famliyType ?? this.famliyType,
      famliyStatus: famliyStatus ?? this.famliyStatus,
      fatherName: fatherName ?? this.fatherName,
      fatherOccupation: fatherOccupation ?? this.fatherOccupation,
      motherName: motherName ?? this.motherName,
      motherOccupation: motherOccupation ?? this.motherOccupation,
      noOfBrothers: noOfBrothers ?? this.noOfBrothers,
      noOfSisters: noOfSisters ?? this.noOfSisters,
      brotherMarried: brotherMarried ?? this.brotherMarried,
      sisterMarried: sisterMarried ?? this.sisterMarried,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
