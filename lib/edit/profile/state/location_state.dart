class LocationState {
  final String country;
  final String state;
  final String city;
  final String pincode;
  final bool ownHouse;
  final String flatNo;
  final String address;

  LocationState({
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.ownHouse,
    required this.flatNo,
    required this.address,
  });

  factory LocationState.initial() {
    return LocationState(
      country: '',
      state: '',
      city: '',
      pincode: '',
      ownHouse: false,
      flatNo: '',
      address: '',
    );
  }

  LocationState copyWith({
    String? country,
    String? state,
    String? city,
    String? pincode,
    bool? ownHouse,
    String? flatNo,
    String? address,
  }) {
    return LocationState(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      ownHouse: ownHouse ?? this.ownHouse,
      flatNo: flatNo ?? this.flatNo,
      address: address ?? this.address,
    );
  }
}
