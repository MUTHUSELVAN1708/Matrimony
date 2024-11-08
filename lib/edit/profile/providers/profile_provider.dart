class ProfileState {
  final String selectedProfile;
  final String selectedReligion;
  final String selectedCaste;
  final String selectedName;
  final String selectedHeight;
  final DateTime? selectedDateOfBirth;
  final bool isValidAge;
  // Add more fields as needed

  ProfileState({
    this.selectedProfile = '-',
    this.selectedReligion = '-',
    this.selectedCaste = '-',
    this.selectedName = '-',
    this.selectedHeight = '-',
    this.selectedDateOfBirth,
    this.isValidAge = false,
  });

  ProfileState copyWith({
    String? selectedProfile,
    String? selectedReligion,
    String? selectedCaste,
    String? selectedName,
    String? selectedHeight,
    DateTime? selectedDateOfBirth,
    bool? isValidAge,
  }) {
    return ProfileState(
      selectedProfile: selectedProfile ?? this.selectedProfile,
      selectedReligion: selectedReligion ?? this.selectedReligion,
      selectedCaste: selectedCaste ?? this.selectedCaste,
      selectedName: selectedName ?? this.selectedName,
      selectedHeight: selectedHeight ?? this.selectedHeight,
      selectedDateOfBirth: selectedDateOfBirth ?? this.selectedDateOfBirth,
      isValidAge: isValidAge ?? this.isValidAge,
    );
  }
}
