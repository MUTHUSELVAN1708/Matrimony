class ProfessionalInfoState {
  final String? education;
  final String? college;
  final String? employedIn;
  final String? occupation;
  final String? citizenship;
  final String? organization;
  final String? currencyType;
  final String? annualIncome;
  final bool isLoading;

  ProfessionalInfoState({
    this.education,
    this.college,
    this.employedIn,
    this.occupation,
    this.citizenship,
    this.organization,
    this.currencyType,
    this.annualIncome,
    this.isLoading = false,
  });

  ProfessionalInfoState copyWith({
    String? education,
    String? college,
    String? employedIn,
    String? occupation,
    String? citizenship,
    String? organization,
    String? currencyType,
    String? annualIncome,
    bool? isLoading,
  }) {
    return ProfessionalInfoState(
      education: education ?? this.education,
      college: college ?? this.college,
      employedIn: employedIn ?? this.employedIn,
      occupation: occupation ?? this.occupation,
      citizenship: citizenship ?? this.citizenship,
      organization: organization ?? this.organization,
      currencyType: currencyType ?? this.currencyType,
      annualIncome: annualIncome ?? this.annualIncome,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
