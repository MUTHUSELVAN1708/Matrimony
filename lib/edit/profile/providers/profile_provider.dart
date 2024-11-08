class ProfileState {
  final String selectedProfile;
  final String selectedReligion;
  final String selectedCaste;
  final String selectedName;
  final String selectedHeight;
  final String selectedWeight;
  final String skinTone;
  final String maritalStatus;
  final String physicalStatus;
  final String eatingHabits;
  final String drinkingHabits;
  final String smokingHabits;
  final DateTime? selectedDateOfBirth;
  final bool isValidAge;
  // Add more fields as needed

  ProfileState({
    this.selectedProfile = 'Select',
    this.selectedReligion = 'Select',
    this.selectedCaste = 'Select',
    this.selectedName = '',
    this.selectedHeight = 'Select',
    this.selectedWeight = 'Select',
    this.skinTone = 'Select',
    this.maritalStatus = 'Select',
    this.physicalStatus = 'Select',
    this.eatingHabits = 'Select',
    this.drinkingHabits = 'Select',
    this.smokingHabits = 'Select',
    this.selectedDateOfBirth,
    this.isValidAge = false,
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
    );
  }
}
