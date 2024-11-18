import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:matrimony/edit/profile/state/location_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/widget/custom_snackbar.dart';
import '../location/presentation/widgets/location_form.dart';
import '../profile/providers/location_provider.dart';

class LocationDetailsScreen extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const LocationDetailsScreen({
    Key? key,
    required this.onPop,
  }) : super(key: key);

  @override
  ConsumerState<LocationDetailsScreen> createState() =>
      _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends ConsumerState<LocationDetailsScreen> {
  bool isAutoLocation = false;
  bool isManualEntry = true;

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final heightQuery = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          _buildHeader(context, heightQuery),
          _buildBody(context, heightQuery, locationState),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double heightQuery) {
    return Container(
      height: heightQuery * 0.2,
      color: Colors.red,
      padding: const EdgeInsets.only(top: 40, left: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.onPop('true');
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(width: heightQuery * 0.15),
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, double heightQuery, LocationState state) {
    return Positioned(
      top: heightQuery * 0.2,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLocationOptions(),
                const SizedBox(height: 24),
                if (isManualEntry) ...[
                  LocationForm(
                    state: state,
                    onSave: () => _handleSave(context),
                    enabled: true,
                  ),
                ] else if (isAutoLocation) ...[
                  LocationForm(
                    state: state,
                    onSave: () => _handleSave(context),
                    enabled: false,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationOptions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Location Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCheckboxTile(
              title: 'Manual Entry',
              value: isManualEntry,
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    isManualEntry = true;
                    isAutoLocation = false;
                    ref.read(locationProvider.notifier).clearLocation();
                  });
                }
              },
              icon: Icons.edit,
            ),
            _buildCheckboxTile(
              title: 'Get Current Location',
              value: isAutoLocation,
              onChanged: (value) {
                if (value == true) {
                  setState(() {
                    isAutoLocation = true;
                    isManualEntry = false;
                    _getCurrentLocation();
                  });
                }
              },
              icon: Icons.my_location,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: value ? Colors.red.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Row(
          children: [
            Icon(icon, color: value ? Colors.red : Colors.grey),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: value ? Colors.red : Colors.black,
                fontWeight: value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
        activeColor: Colors.red,
        checkColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    print("Requesting location permission...");
    final status = await Permission.location.request();
    print("Permission status: $status");

    if (status.isGranted) {
      try {
        print("Fetching current position...");
        final position = await Geolocator.getCurrentPosition();
        print("Position: ${position.latitude}, ${position.longitude}");

        print("Fetching placemarks...");
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        print(placemarks);

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;

          // Printing all available details of the address
          print("Placemark Details:");
          print("Name: ${place.name}");
          print("Street: ${place.street}");
          print("SubLocality: ${place.subLocality}");
          print("Locality: ${place.locality}");
          print("Administrative Area: ${place.administrativeArea}");
          print("SubAdministrative Area: ${place.subAdministrativeArea}");
          print("Postal Code: ${place.postalCode}");
          print("Country: ${place.country}");
          print("ISO Country Code: ${place.isoCountryCode}");
          print("Thoroughfare: ${place.thoroughfare}");
          print("SubThoroughfare: ${place.subThoroughfare}");

          ref.read(locationProvider.notifier).updateFromPlacemark(place);
        } else {
          print("No placemarks found.");
        }
      } catch (e) {
        print("Error fetching location: $e");
        if (mounted) {
          CustomSnackBar.show(
            context: context,
            message: 'Failed to get location. Please try again.',
            isError: true,
          );
        }
      }
    } else {
      print("Location permission denied.");
      if (mounted) {
        CustomSnackBar.show(
          context: context,
          message: 'Location permission denied. Please enable it in settings.',
          isError: true,
        );
      }
    }
  }

  void _handleSave(BuildContext context) {
    if (ref.read(locationProvider.notifier).validateForm()) {
      widget.onPop('true');
      Navigator.pop(context);
      CustomSnackBar.show(
        context: context,
        message: 'Location details saved successfully!',
        isError: false,
      );
    }
  }
}
