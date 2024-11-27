class LocationState {
  final String country;
  final String state;
  final String city;
  final String pincode;
  final bool? ownHouse;
  final String flatNo;
  final String address;
  final bool isLoading;
  final bool? isOtherCity;

  LocationState({
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    this.ownHouse,
    required this.flatNo,
    required this.address,
    this.isLoading = false,
    this.isOtherCity,
  });

  factory LocationState.initial() {
    return LocationState(
        country: '',
        state: '',
        city: '',
        pincode: '',
        ownHouse: null,
        flatNo: '',
        address: '',
        isLoading: false,
        isOtherCity: null);
  }

  LocationState copyWith({
    String? country,
    String? state,
    String? city,
    String? pincode,
    bool? ownHouse,
    String? flatNo,
    String? address,
    bool? isLoading,
    bool? isOtherCity,
  }) {
    return LocationState(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      ownHouse: ownHouse ?? this.ownHouse,
      flatNo: flatNo ?? this.flatNo,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      isOtherCity: isOtherCity ?? this.isOtherCity,
    );
  }
}
