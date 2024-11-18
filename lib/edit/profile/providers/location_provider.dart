import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';

import '../state/location_state.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState.initial());

  void updateCountry(String value) {
    state = state.copyWith(country: value);
  }

  void updateState(String value) {
    state = state.copyWith(state: value);
  }

  void updateCity(String value) {
    state = state.copyWith(city: value);
  }

  void updatePincode(String value) {
    state = state.copyWith(pincode: value);
  }

  void updateOwnHouse(bool value) {
    state = state.copyWith(ownHouse: value);
  }

  void updateFlatNo(String value) {
    state = state.copyWith(flatNo: value);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value);
  }

  void updateFromPlacemark(Placemark place) {
    state = state.copyWith(
      country: place.country ?? '',
      state: place.administrativeArea ?? '',
      city: place.locality ?? '',
      pincode: place.postalCode ?? '',
      address: '${place.street}, ${place.subLocality}, ${place.locality}',
    );
  }

  void clearLocation() {
    state = LocationState.initial();
  }

  bool validateForm() {
    return state.country.isNotEmpty &&
        state.state.isNotEmpty &&
        state.city.isNotEmpty &&
        state.pincode.isNotEmpty;
  }
}
