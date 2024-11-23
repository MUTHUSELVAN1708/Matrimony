import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';

// class LocationDetailsScreen extends ConsumerStatefulWidget {
//   final Function(String? value) onPop;
//
//   const LocationDetailsScreen({
//     Key? key,
//     required this.onPop,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<LocationDetailsScreen> createState() =>
//       _LocationDetailsScreenState();
// }
//
// class _LocationDetailsScreenState extends ConsumerState<LocationDetailsScreen> {
//   bool isAutoLocation = false;
//   bool isManualEntry = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final locationState = ref.watch(locationProvider);
//     final heightQuery = MediaQuery.of(context).size.height;
//
//     return Material(
//       color: Colors.transparent,
//       child: Stack(
//         children: [
//           _buildHeader(context, heightQuery),
//           _buildBody(context, heightQuery, locationState),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context, double heightQuery) {
//     return Container(
//       height: heightQuery * 0.2,
//       color: Colors.red,
//       padding: const EdgeInsets.only(top: 40, left: 16),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               widget.onPop('true');
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back_ios,
//               size: 20,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(width: heightQuery * 0.15),
//           const Text(
//             'Location',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBody(
//       BuildContext context, double heightQuery, LocationState state) {
//     return Positioned(
//       top: heightQuery * 0.2,
//       left: 0,
//       right: 0,
//       bottom: 0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildLocationOptions(),
//                 const SizedBox(height: 24),
//                 if (isManualEntry) ...[
//                   LocationForm(
//                     state: state,
//                     onSave: () => _handleSave(context),
//                     enabled: true,
//                   ),
//                 ] else if (isAutoLocation) ...[
//                   LocationForm(
//                     state: state,
//                     onSave: () => _handleSave(context),
//                     enabled: false,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationOptions() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Choose Location Method',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildCheckboxTile(
//               title: 'Manual Entry',
//               value: isManualEntry,
//               onChanged: (value) {
//                 if (value == true) {
//                   setState(() {
//                     isManualEntry = true;
//                     isAutoLocation = false;
//                     ref.read(locationProvider.notifier).clearLocation();
//                   });
//                 }
//               },
//               icon: Icons.edit,
//             ),
//             _buildCheckboxTile(
//               title: 'Get Current Location',
//               value: isAutoLocation,
//               onChanged: (value) {
//                 if (value == true) {
//                   setState(() {
//                     isAutoLocation = true;
//                     isManualEntry = false;
//                     _getCurrentLocation();
//                   });
//                 }
//               },
//               icon: Icons.my_location,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCheckboxTile({
//     required String title,
//     required bool value,
//     required Function(bool?) onChanged,
//     required IconData icon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: value ? Colors.red.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: CheckboxListTile(
//         value: value,
//         onChanged: onChanged,
//         title: Row(
//           children: [
//             Icon(icon, color: value ? Colors.red : Colors.grey),
//             const SizedBox(width: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 color: value ? Colors.red : Colors.black,
//                 fontWeight: value ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//         activeColor: Colors.red,
//         checkColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getCurrentLocation() async {
//     print("Requesting location permission...");
//     var status = await Permission.location.status;
//     // final status = await Permission.location.request();
//     print("Permission status: $status");
//     if (status.isDenied || status.isRestricted) {
//       // Request permission if denied
//       status = await Permission.location.request();
//       if (!status.isGranted) {
//         // Permission is denied or permanently denied
//         print("Location permission denied");
//         return;
//       }
//     }
//     if (status.isGranted) {
//       try {
//         print("Fetching current position...");
//         final position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high);
//         print("Position: ${position.latitude}, ${position.longitude}");
//
//         print("Fetching placemarks...");
//         final placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
//         print(placemarks);
//
//         if (placemarks.isNotEmpty) {
//           final place = placemarks.first;
//
//           // Printing all available details of the address
//           print("Placemark Details:");
//           print("Name: ${place.name}");
//           print("Street: ${place.street}");
//           print("SubLocality: ${place.subLocality}");
//           print("Locality: ${place.locality}");
//           print("Administrative Area: ${place.administrativeArea}");
//           print("SubAdministrative Area: ${place.subAdministrativeArea}");
//           print("Postal Code: ${place.postalCode}");
//           print("Country: ${place.country}");
//           print("ISO Country Code: ${place.isoCountryCode}");
//           print("Thoroughfare: ${place.thoroughfare}");
//           print("SubThoroughfare: ${place.subThoroughfare}");
//
//           ref.read(locationProvider.notifier).updateFromPlacemark(place);
//         } else {
//           print("No placemarks found.");
//         }
//       } catch (e) {
//         print("Error fetching location: $e");
//         if (mounted) {
//           CustomSnackBar.show(
//             context: context,
//             message: 'Failed to get location. Please try again.',
//             isError: true,
//           );
//         }
//       }
//     } else {
//       print("Location permission denied.");
//       if (mounted) {
//         CustomSnackBar.show(
//           context: context,
//           message: 'Location permission denied. Please enable it in settings.',
//           isError: true,
//         );
//       }
//     }
//   }
//
//   void _handleSave(BuildContext context) {
//     if (ref.read(locationProvider.notifier).validateForm()) {
//       widget.onPop('true');
//       Navigator.pop(context);
//       CustomSnackBar.show(
//         context: context,
//         message: 'Location details saved successfully!',
//         isError: false,
//       );
//     }
//   }
//
// }

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  String? cuntryLiving;
  String? residingState;
  String? residingCity;
  String address = '';
  String? flatNo;
  String? ownHouse;
  String? pinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/initialimage.png'),
                // Use your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildCustomAppBar(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Family Details',
                        style: AppTextStyles.headingTextstyle,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildDetailItem('Country Living',
                                        cuntryLiving ?? '-Select-', onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Country Living',
                                          options: PartnerPreferenceConstData
                                              .countries,
                                          selectedValue:
                                              cuntryLiving ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              cuntryLiving = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    _buildDetailItem('Residing State',
                                        residingState ?? '-Select-', onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Residing State',
                                          options: PartnerPreferenceConstData
                                              .states.keys
                                              .toList(),
                                          selectedValue:
                                              residingState ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              residingState = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    _buildDetailItem('residing City',
                                        residingCity ?? '-Select-', onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'residing city',
                                          options: PartnerPreferenceConstData
                                              .cities.keys
                                              .toList(),
                                          selectedValue:
                                              residingCity ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              residingCity = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    _buildDetailItem(
                                      'pin Code',
                                      pinCode ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'pin Code',
                                            options: const [
                                              'employed',
                                              'business man',
                                              'professional',
                                              'retired',
                                              "Not employed",
                                              'passed away'
                                            ],
                                            selectedValue: pinCode ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                pinCode = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    _buildDetailItem(
                                      'own house',
                                      ownHouse ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'own house',
                                            options: const [
                                              'yes',
                                              "No",
                                            ],
                                            selectedValue: ownHouse ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                ownHouse = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Background color for the TextField
                                        borderRadius: BorderRadius.circular(
                                            15), // Optional: rounded corners
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            offset: const Offset(1, 2),
                                            blurRadius: 11.1,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            flatNo = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Flat No',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical:
                                                  12), // Padding inside the TextField
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Background color for the TextField
                                        borderRadius: BorderRadius.circular(
                                            15), // Optional: rounded corners
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            offset: Offset(1, 2),
                                            blurRadius: 11.1,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        maxLines: 5,
                                        onChanged: (value) {
                                          setState(() {
                                            address = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Address',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical:
                                                  12), // Padding inside the TextField
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  style: AppTextStyles.primaryButtonstyle,
                  onPressed: _saveDetails,
                  child: const Text(
                    'Save',
                    style: AppTextStyles.primarybuttonText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                  0.08), // Shadow color with opacity (equivalent to #00000008 in CSS)
              offset: const Offset(
                  1, 2), // Horizontal and vertical offset (1px, 2px)
              blurRadius: 11.1, // Blur radius (11.1px)
              spreadRadius: 0, // No spread, just the normal shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(
                  value,
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: value == '-Select-'
                          ? AppColors.spanTextColor
                          : AppColors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.headingTextColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Edit Family Details',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingTextstyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      // Implement save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving details...')),
      );
    }
  }
}
