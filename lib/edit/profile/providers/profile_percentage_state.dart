class ProfilePercentageState {
  final String? completionPercentage;
  final bool? userRegistrationModel;
  final bool? religionModel;
  final bool isLoading;

  ProfilePercentageState({
    this.completionPercentage,
    this.userRegistrationModel,
    this.religionModel,
    this.isLoading = false,
  });

  ProfilePercentageState copyWith({
    String? completionPercentage,
    bool? userRegistrationModel,
    bool? religionModel,
    bool? isLoading,
  }) {
    return ProfilePercentageState(
      religionModel: religionModel ?? this.religionModel,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      userRegistrationModel:
          userRegistrationModel ?? this.userRegistrationModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
