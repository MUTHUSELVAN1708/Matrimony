import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/edit/profile/state/location_state.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';

final locationProviderEdit =
    StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState.initial());

  void updateCountry(String country) {
    state = state.copyWith(
        country: country,
        state: country != state.country ? '' : state.state,
        city: country != state.country ? '' : state.city,
        pincode: country != state.country ? '' : state.pincode);
  }

  void updateState(String value) {
    state = state.copyWith(
        state: value,
        city: value != state.state ? '' : state.city,
        pincode: value != state.state ? '' : state.pincode);
  }

  void updateCity(String value, List<City> cityList) {
    final matchingCity = cityList.firstWhere(
      (city) => city.citys == value,
      orElse: () => City(id: 0, citys: '', stateId: 0, pincode: 0),
    );
    state = state.copyWith(
        city: value,
        pincode: matchingCity.pincode.toString(),
        isOtherCity: matchingCity.pincode.toString() == '0' ? true : false);
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

  void setLocationDetails(UserDetails userDetails) {
    state = state.copyWith(
        ownHouse: userDetails.ownHouse != null
            ? userDetails.ownHouse == 'Yes'
                ? true
                : false
            : null,
        city: userDetails.city,
        pincode: userDetails.pincode,
        state: userDetails.state,
        country: userDetails.country,
        address: userDetails.address,
        flatNo: userDetails.flatNumber);
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

  Future<bool> updateLocationDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
        Uri.parse(Api.editLocation),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'country': state.country,
          'state': state.state,
          'pincode': state.pincode,
          'city': state.city,
          'flatNumber': state.flatNo,
          'address': state.address,
          'ownHouse': state.ownHouse != null
              ? state.ownHouse!
                  ? 'Yes'
                  : 'No'
              : null
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
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
