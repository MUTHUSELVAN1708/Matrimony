class HoroscopeState {
  final String? dateOfBirth;
  final String? timeOfBirth;
  final String? birthCountry;
  final String? birthState;
  final String? birthCity;
  final bool isLoading;

  HoroscopeState({
    this.birthCity,
    this.birthCountry,
    this.birthState,
    this.dateOfBirth,
    this.timeOfBirth,
    this.isLoading = false,
  });

  HoroscopeState copyWith({
    String? dateOfBirth,
    String? timeOfBirth,
    String? birthCountry,
    String? birthState,
    String? birthCity,
    bool? isLoading,
  }) {
    return HoroscopeState(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      timeOfBirth: timeOfBirth ?? this.timeOfBirth,
      birthState: birthState ?? this.birthState,
      birthCountry: birthCountry ?? this.birthCountry,
      birthCity: birthCity ?? this.birthCity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
