class ProfileState {
  final String? selectedProfile;
  final String? selectedReligion;
  final String? selectedCaste;
  final String? selectedName;
  final String? selectedHeight;
  final String? selectedWeight;
  final String? skinTone;
  final String? maritalStatus;
  final String? physicalStatus;
  final String? eatingHabits;
  final String? drinkingHabits;
  final String? smokingHabits;
  final DateTime? selectedDateOfBirth;
  final bool? isValidAge;
  final bool isLoading;
  // Add more fields as needed

  ProfileState({
    this.selectedProfile,
    this.selectedReligion,
    this.selectedCaste,
    this.selectedName,
    this.selectedHeight,
    this.selectedWeight,
    this.skinTone,
    this.maritalStatus,
    this.physicalStatus,
    this.eatingHabits,
    this.drinkingHabits,
    this.smokingHabits,
    this.selectedDateOfBirth,
    this.isValidAge = false,
    this.isLoading = false,
  });

  ProfileState copyWith({
    String? selectedProfile,
    String? selectedReligion,
    String? selectedCaste,
    String? selectedName,
    String? selectedHeight,
    String? selectedWeight,
    String? skinTone,
    String? maritalStatus,
    String? physicalStatus,
    String? eatingHabits,
    String? drinkingHabits,
    String? smokingHabits,
    DateTime? selectedDateOfBirth,
    bool? isValidAge,
    bool? isLoading,
  }) {
    return ProfileState(
        selectedProfile: selectedProfile ?? this.selectedProfile,
        selectedReligion: selectedReligion ?? this.selectedReligion,
        selectedCaste: selectedCaste ?? this.selectedCaste,
        selectedName: selectedName ?? this.selectedName,
        selectedHeight: selectedHeight ?? this.selectedHeight,
        selectedWeight: selectedWeight ?? this.selectedWeight,
        skinTone: skinTone ?? this.skinTone,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        physicalStatus: physicalStatus ?? this.physicalStatus,
        eatingHabits: eatingHabits ?? this.eatingHabits,
        drinkingHabits: drinkingHabits ?? this.drinkingHabits,
        smokingHabits: smokingHabits ?? this.smokingHabits,
        selectedDateOfBirth: selectedDateOfBirth ?? this.selectedDateOfBirth,
        isValidAge: isValidAge ?? this.isValidAge,
        isLoading: isLoading ?? this.isLoading);
  }
}
