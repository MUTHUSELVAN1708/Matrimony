import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/providers/location_provider.dart';
import 'package:matrimony/edit/profile/state/location_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/custom_text_field.dart';

class LocationDetailsScreen extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const LocationDetailsScreen({
    super.key,
    required this.onPop,
  });

  @override
  ConsumerState<LocationDetailsScreen> createState() =>
      _ProfessionalInformationDetailsScreenState();
}

class _ProfessionalInformationDetailsScreenState
    extends ConsumerState<LocationDetailsScreen> {
  final pinCodeController = TextEditingController();
  final flatNoController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(locationProviderEdit.notifier).clearLocation();
    ref
        .read(locationProviderEdit.notifier)
        .setLocationDetails(ref.read(userManagementProvider).userDetails);
    final user = ref.read(userManagementProvider).userDetails;
    pinCodeController.text = user.pincode ?? '';
    addressController.text = user.address ?? '';
    flatNoController.text = user.flatNumber ?? '';
    ref.read(locationProvider.notifier).getCountryDetails(
        ref.read(userManagementProvider).userDetails.country ?? '',
        ref.read(userManagementProvider).userDetails.state ?? '');
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    addressController.dispose();
    flatNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProviderEditState = ref.watch(locationProviderEdit);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return EnhancedLoadingWrapper(
      isLoading: locationProviderEditState.isLoading,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            widget.onPop('true');
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              _buildHeader(context, heightQuery),
              _buildForm(context, ref, locationProviderEditState, heightQuery),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double width) {
    return Positioned(
      top: 40,
      left: 16,
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
          SizedBox(width: width * 0.10),
          const Text(
            'Edit Location Details',
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

  Widget _buildForm(
    BuildContext context,
    WidgetRef ref,
    LocationState locationProviderEditState,
    double heightQuery,
  ) {
    final countryState = ref.watch(locationProvider);
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
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 5),
                  _buildCountrySelection(
                      context, ref, locationProviderEditState, countryState),
                  const SizedBox(height: 5),
                  _buildStateSelection(
                      context, ref, locationProviderEditState, countryState),
                  const SizedBox(height: 5),
                  _buildCitySelection(
                      context, ref, locationProviderEditState, countryState),
                  const SizedBox(height: 5),
                  _buildTextField(
                      'Pincode',
                      locationProviderEditState.pincode,
                      locationProviderEditState.isOtherCity != null &&
                              locationProviderEditState.isOtherCity!
                          ? false
                          : true, (value) {
                    ref
                        .read(locationProviderEdit.notifier)
                        .updatePincode(value);
                  }, pinCodeController),
                  const SizedBox(height: 5),
                  _buildOwnHouseSelection(
                      context, ref, locationProviderEditState),
                  const SizedBox(height: 5),
                  _buildTextField(
                      'Flat Number', locationProviderEditState.flatNo, false,
                      (value) {
                    ref.read(locationProviderEdit.notifier).updateFlatNo(value);
                  }, flatNoController),
                  const SizedBox(height: 5),
                  _buildTextField(
                      'Address', locationProviderEditState.address, false,
                      (value) {
                    ref
                        .read(locationProviderEdit.notifier)
                        .updateAddress(value);
                  }, addressController),
                  const SizedBox(height: 24),
                  _buildSaveButton(context, ref, locationProviderEditState),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, String initialValue, bool isEnabled,
      Function(String)? onChanged, TextEditingController controller) {
    return CustomTextFieldWidget(
      controller: controller,
      fillColor: Colors.transparent,
      hintText: hintText,
      initialValue: initialValue,
      readOnly: isEnabled,
      onChanged: onChanged,
      borderRadius: 10,
      borderColor: Colors.grey.withOpacity(0.5),
      maxLines: hintText == 'Address' ? 4 : 1,
      inputFormatters: hintText == 'Pincode'
          ? [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly
            ]
          : null,
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Location Details',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCountrySelection(BuildContext context, WidgetRef ref,
      LocationState locationState, CountryState countryState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Country',
            options: [
              ...countryState.countryList.map((country) => country.countrys),
              'Other'
            ],
            selectedValue: locationState.country,
            onSelect: (value) {
              ref.read(locationProviderEdit.notifier).updateCountry(value);
              if (value != locationState.country) {
                ref.read(locationProvider.notifier).getStateDetailsList(value);
                pinCodeController.text = '';
              }
            },
          ),
        );
      },
      child: _buildListTile(
        'Country',
        locationState.country.isEmpty ? 'Select' : locationState.country,
      ),
    );
  }

  Widget _buildStateSelection(BuildContext context, WidgetRef ref,
      LocationState locationState, CountryState countryState) {
    return GestureDetector(
      onTap: () {
        if (locationState.country.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => CommonSelectionDialog(
              title: 'Select Your State',
              options: [
                ...countryState.stateList.map((state) => state.states),
                'Other'
              ],
              selectedValue: locationState.state,
              onSelect: (value) {
                ref.read(locationProviderEdit.notifier).updateState(value);
                if (value != locationState.state) {
                  ref.read(locationProvider.notifier).getCityDetailsList(value);
                  pinCodeController.text = '';
                }
              },
            ),
          );
        } else {
          CustomSnackBar.show(
              context: context,
              message: 'Please Select Country!',
              isError: true);
        }
      },
      child: _buildListTile(
        'State',
        locationState.state.isEmpty ? 'Select' : locationState.state,
      ),
    );
  }

  Widget _buildCitySelection(BuildContext context, WidgetRef ref,
      LocationState locationState, CountryState countryState) {
    return GestureDetector(
      onTap: () {
        if (locationState.state.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => CommonSelectionDialog(
              title: 'Select Your City',
              options: [
                ...countryState.cityList.map((city) => city.citys),
                'Other'
              ],
              selectedValue: locationState.city,
              onSelect: (value) {
                ref
                    .read(locationProviderEdit.notifier)
                    .updateCity(value, countryState.cityList);
                final city = countryState.cityList.firstWhere(
                  (city) => city.citys == value,
                  orElse: () => City(id: 0, citys: '', stateId: 0, pincode: 0),
                );
                pinCodeController.text = city.pincode.toString() == '0'
                    ? ''
                    : city.pincode.toString();
              },
            ),
          );
        } else {
          CustomSnackBar.show(
              context: context, message: 'Please Select State!', isError: true);
        }
      },
      child: _buildListTile(
        'City',
        locationState.city.isEmpty ? 'Select' : locationState.city,
      ),
    );
  }

  Widget _buildOwnHouseSelection(
    BuildContext context,
    WidgetRef ref,
    LocationState locationState,
  ) {
    return GestureDetector(
      onTap: () {
        _selectHouse(context);
      },
      child: _buildListTile(
        'Own House',
        locationState.ownHouse != null && locationState.ownHouse!
            ? 'Yes'
            : locationState.ownHouse != null && !locationState.ownHouse!
                ? 'No'
                : 'Select',
      ),
    );
  }

  void _selectHouse(BuildContext context) {
    final locationProvider = ref.watch(locationProviderEdit);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Own House')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(locationProviderEdit.notifier).updateOwnHouse(true);
                  Navigator.pop(context, true);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: locationProvider.ownHouse == true
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color: locationProvider.ownHouse == true
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 16,
                          color: locationProvider.ownHouse == true
                              ? Colors.black
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  ref.read(locationProviderEdit.notifier).updateOwnHouse(false);
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: locationProvider.ownHouse == false
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color: locationProvider.ownHouse == false
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontSize: 16,
                          color: locationProvider.ownHouse == false
                              ? Colors.black
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    WidgetRef ref,
    LocationState locationState,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final result = await ref
              .read(locationProviderEdit.notifier)
              .updateLocationDetails();
          ref
              .read(userManagementProvider.notifier)
              .updateLocationDetails(locationState);
          if (result) {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              widget.onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Location Details updated successfully!',
              );
            });
          } else {
            CustomSnackBar.show(
              isError: true,
              context: context,
              message: 'Something Went wrong. Please Try Again!',
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:matrimony/common/app_text_style.dart';
// import 'package:matrimony/common/colors.dart';
// import 'package:matrimony/common/patner_preference_const_data.dart';
// import 'package:matrimony/common/widget/circularprogressIndicator.dart';
// import 'package:matrimony/common/widget/common_selection_dialog.dart';
// import 'package:matrimony/common/widget/custom_snackbar.dart';
// import 'package:matrimony/common/widget/full_screen_loader.dart';
// import 'package:matrimony/models/riverpod/usermanagement_state.dart';
//
// import '../../user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
//
// class LocationDetailsScreen extends ConsumerStatefulWidget {
//   const LocationDetailsScreen({
//     super.key,
//     required this.onPop,
//   });
//
//   final Function(String? value) onPop;
//
//   @override
//   ConsumerState<LocationDetailsScreen> createState() =>
//       _LocationDetailsScreenState();
// }
//
// class _LocationDetailsScreenState extends ConsumerState<LocationDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   String cuntryLiving = '';
//   String residingState = '';
//   String residingCity = '';
//   bool? isOtherCity;
//   TextEditingController address = TextEditingController();
//   TextEditingController flatNo = TextEditingController();
//   TextEditingController pinCode = TextEditingController();
//   bool? isOwnHouse;
//
//   @override
//   void initState() {
//     super.initState();
//     getCountry();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     getUserLocationMethod();
//   }
//
//   void getUserLocationMethod() async {
//     final userManagementState = ref.watch(userManagementProvider);
//     cuntryLiving = userManagementState.userDetails.country ?? '';
//     residingState = userManagementState.userDetails.state ?? '';
//     residingCity = userManagementState.userDetails.city ?? '';
//     address.text = userManagementState.userDetails.address ?? '';
//     pinCode.text = userManagementState.userDetails.pincode ?? '';
//     flatNo.text = userManagementState.userDetails.flatNumber ?? '';
//     isOwnHouse =
//         userManagementState.userDetails.ownHouse == 'Yes' ? true : false;
//   }
//
//   Future<void> getCountry() async {
//     await Future.delayed(Duration.zero);
//     ref.read(locationProvider.notifier).getReligiousDetails(
//         ref.read(userManagementProvider).userDetails.country ?? '',
//         ref.read(userManagementProvider).userDetails.state ?? '');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userManagementState = ref.watch(userManagementProvider);
//     final usernotifier = ref.read(userManagementProvider.notifier);
//     final countryState = ref.watch(locationProvider);
//     final heightQuery = MediaQuery.of(context).size.height;
//     return EnhancedLoadingWrapper(
//       isLoading: countryState.isLoading,
//       child: PopScope(
//         onPopInvokedWithResult: (didPop, result) {
//           if (didPop) {
//             widget.onPop('true');
//           }
//         },
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           resizeToAvoidBottomInset: false,
//           body: Stack(
//             children: [
//               Container(
//                 // height: MediaQuery.of(context).size.height * 0.50,
//                 width: double.infinity,
//                 margin: EdgeInsets.only(bottom: heightQuery * 0.2),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/initialimage.png'),
//                     // Use your image path here
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.4),
//                 ),
//               ),
//               Column(
//                 children: [
//                   _buildCustomAppBar(),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height * 0.10),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(30)),
//                       ),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text(
//                             'Location Details',
//                             style: AppTextStyles.headingTextstyle,
//                           ),
//                           const SizedBox(height: 16),
//                           Expanded(
//                             child: ScrollConfiguration(
//                               behavior: ScrollConfiguration.of(context)
//                                   .copyWith(scrollbars: false),
//                               child: SingleChildScrollView(
//                                 child: Form(
//                                   key: _formKey,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(4),
//                                     child: Column(
//                                       children: [
//                                         _buildDetailItem(
//                                             'Country Living', cuntryLiving,
//                                             onTap: () {
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) =>
//                                                 CommonSelectionDialog(
//                                               removeSearching: false,
//                                               title: 'Country Living',
//                                               options: [
//                                                 ...countryState.countryList
//                                                     .map((e) => e.countrys),
//                                                 'other'
//                                               ],
//                                               selectedValue: cuntryLiving,
//                                               onSelect: (value) async {
//                                                 setState(() {
//                                                   pinCode.text = '';
//                                                   residingCity = '';
//                                                   residingState = '';
//                                                   countryState.stateList
//                                                       .clear();
//                                                   cuntryLiving = value;
//                                                 });
//
//                                                 int? stateId;
//                                                 for (var e in countryState
//                                                     .countryList) {
//                                                   if (cuntryLiving.isNotEmpty) {
//                                                     if (e.countrys ==
//                                                         cuntryLiving) {
//                                                       stateId = e.id;
//                                                       break;
//                                                     }
//                                                   }
//                                                 }
//
//                                                 print(
//                                                     "Selected State ID: $stateId");
//
//                                                 // Ensure stateId is not null before calling getStateData
//                                                 if (stateId != null) {
//                                                   await ref
//                                                       .read(locationProvider
//                                                           .notifier)
//                                                       .getStateData(stateId);
//                                                 } else {
//                                                   print(
//                                                       "No state ID found for the selected country.");
//                                                 }
//                                               },
//                                             ),
//                                           );
//                                         }),
//                                         cuntryLiving.isEmpty
//                                             ? const SizedBox()
//                                             : _buildDetailItem(
//                                                 'Residing State', residingState,
//                                                 onTap: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) =>
//                                                       CommonSelectionDialog(
//                                                     removeSearching: false,
//                                                     title: 'Residing State',
//                                                     options: [
//                                                       ...countryState.stateList
//                                                           .map((e) => e.states),
//                                                       'other'
//                                                     ],
//                                                     selectedValue:
//                                                         residingState,
//                                                     onSelect: (value) async {
//                                                       setState(() {
//                                                         residingCity = '';
//                                                         pinCode.text = '';
//                                                         countryState.cityList
//                                                             .clear();
//                                                         residingState = value;
//                                                       });
//                                                       int? stateId;
//                                                       for (var e in countryState
//                                                           .stateList) {
//                                                         if (residingState
//                                                             .isNotEmpty) {
//                                                           if (e.states ==
//                                                               residingState) {
//                                                             stateId = e.id;
//                                                             break;
//                                                           }
//                                                         }
//                                                       }
//
//                                                       print(
//                                                           "Selected State ID: $stateId");
//                                                       if (stateId != null) {
//                                                         await ref
//                                                             .read(
//                                                                 locationProvider
//                                                                     .notifier)
//                                                             .getCityData(
//                                                                 stateId);
//                                                       } else {
//                                                         print(
//                                                             "No state ID found for the selected country.");
//                                                       }
//                                                     },
//                                                   ),
//                                                 );
//                                               }),
//                                         residingState.isEmpty
//                                             ? const SizedBox()
//                                             : _buildDetailItem(
//                                                 'Residing City', residingCity,
//                                                 onTap: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) =>
//                                                       CommonSelectionDialog(
//                                                     removeSearching: false,
//                                                     title: 'Residing city',
//                                                     options: [
//                                                       ...countryState.cityList
//                                                           .map((e) => e.citys),
//                                                       'other'
//                                                     ],
//                                                     selectedValue: residingCity,
//                                                     onSelect: (value) {
//                                                       setState(() {
//                                                         pinCode.text = '';
//                                                         residingCity = value;
//                                                         for (var pin
//                                                             in countryState
//                                                                 .cityList) {
//                                                           if (pin.citys ==
//                                                               residingCity) {
//                                                             pinCode.text = pin
//                                                                 .pincode
//                                                                 .toString();
//                                                           }
//                                                         }
//                                                       });
//                                                     },
//                                                   ),
//                                                 );
//                                               }),
//                                         residingCity.isEmpty
//                                             ? const SizedBox()
//                                             : Container(
//                                                 margin:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 8,
//                                                         horizontal: 8),
//                                                 child: TextField(
//                                                   readOnly:
//                                                       residingCity.isNotEmpty
//                                                           ? false
//                                                           : true,
//                                                   controller: pinCode,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter
//                                                         .digitsOnly,
//                                                     LengthLimitingTextInputFormatter(
//                                                         6),
//                                                   ],
//                                                   onChanged: (value) {
//                                                     // setState(() {
//                                                     //   pinCode.text = value;
//                                                     // });
//                                                   },
//                                                   decoration: InputDecoration(
//                                                     hintText: 'Pin Code',
//                                                     border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                       borderSide: BorderSide(
//                                                           color: Colors
//                                                               .grey.shade300,
//                                                           width: 2.0),
//                                                     ),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                       borderSide: BorderSide(
//                                                           color: Colors
//                                                               .grey.shade300,
//                                                           width: 2.0),
//                                                     ),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                       borderSide: BorderSide(
//                                                           color: Colors
//                                                               .grey.shade300,
//                                                           width: 2.0),
//                                                     ),
//                                                     contentPadding:
//                                                         const EdgeInsets
//                                                             .symmetric(
//                                                       horizontal: 16,
//                                                       vertical:
//                                                           12, // Padding inside the TextField
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                         _buildDetailItem(
//                                           'own house',
//                                           isOwnHouse == null ||
//                                                   isOwnHouse == false
//                                               ? 'No'
//                                               : "Yes",
//                                           onTap: () {
//                                             _selectHouse(context);
//                                           },
//                                         ),
//                                         Container(
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 8, horizontal: 8),
//                                           child: TextField(
//                                             controller: flatNo,
//                                             keyboardType: TextInputType.number,
//                                             decoration: InputDecoration(
//                                               hintText: 'Flat No',
//                                               border: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey.shade300,
//                                                     width: 2.0),
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey.shade300,
//                                                     width: 2.0),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey.shade300,
//                                                     width: 2.0),
//                                               ),
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 16,
//                                                 vertical:
//                                                     12, // Padding inside the TextField
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 8, horizontal: 8),
//                                           child: TextField(
//                                             controller: address,
//                                             maxLines: 5,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 address.text = value;
//                                               });
//                                             },
//                                             decoration: InputDecoration(
//                                               hintText: 'Address',
//                                               border: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey
//                                                         .shade300), // Default border color
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey
//                                                         .shade300), // Same for enabled state
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey
//                                                         .shade300), // Same for focused state
//                                               ),
//                                               disabledBorder:
//                                                   OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey
//                                                         .shade300), // Same for disabled state
//                                               ),
//                                               contentPadding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 16,
//                                                 vertical:
//                                                     12, // Padding inside the TextField
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 20),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: AppTextStyles.primaryButtonstyle,
//                       onPressed: _saveDetails,
//                       child: countryState.isLoading
//                           ? const LoadingIndicator()
//                           : const Text(
//                               'Save',
//                               style: AppTextStyles.primarybuttonText,
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailItem(String label, String value,
//       {required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: AppTextStyles.spanTextStyle.copyWith(
//                       color: AppColors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16),
//                 ),
//                 Text(value.isEmpty ? 'Select' : value,
//                     style: const TextStyle(color: Colors.grey, fontSize: 14)),
//               ],
//             ),
//             const Icon(Icons.chevron_right),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCustomAppBar() {
//     return SafeArea(
//       child: Container(
//         margin: const EdgeInsets.only(top: 40),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//               onPressed: () {
//                 widget.onPop('true');
//                 Navigator.pop(context);
//               },
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Edit Location Details',
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.headingTextstyle
//                       .copyWith(color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _saveDetails() async {
//     final result = await ref.read(locationProvider.notifier).editLocationApi(
//         cuntryLiving,
//         residingState,
//         pinCode.text,
//         residingCity,
//         flatNo.text,
//         address.text,
//         isOwnHouse);
//     ref.read(userManagementProvider.notifier).updateLocationDetails(
//         cuntryLiving,
//         residingState,
//         pinCode.text,
//         residingCity,
//         flatNo.text,
//         address.text,
//         isOwnHouse);
//     if (result) {
//       widget.onPop('true');
//       Navigator.of(context).pop();
//       CustomSnackBar.show(
//         context: context,
//         message: 'Profile Updated Successfully.',
//         isError: false,
//       );
//     } else {
//       CustomSnackBar.show(
//         context: context,
//         message: 'Something Went Wrong. Please Try Again!',
//         isError: true,
//       );
//     }
//   }
//
//   void _selectHouse(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Center(child: Text('Own House')),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isOwnHouse = true;
//                   });
//                   Navigator.pop(context, true);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: isOwnHouse == true
//                         ? const Color(0xFFFFCBCC)
//                         : Colors.transparent,
//                     border: Border.all(
//                       color:
//                           isOwnHouse == true ? Colors.transparent : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Yes',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color:
//                               isOwnHouse == true ? Colors.black : Colors.grey),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isOwnHouse = false;
//                   });
//                   Navigator.pop(context, false);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: isOwnHouse == false
//                         ? const Color(0xFFFFCBCC)
//                         : Colors.transparent,
//                     border: Border.all(
//                       color: isOwnHouse == false
//                           ? Colors.transparent
//                           : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'No',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color:
//                               isOwnHouse == false ? Colors.black : Colors.grey),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// // class LocationDetailsScreen extends ConsumerStatefulWidget {
// //   final Function(String? value) onPop;
// //
// //   const LocationDetailsScreen({
// //     Key? key,
// //     required this.onPop,
// //   }) : super(key: key);
// //
// //   @override
// //   ConsumerState<LocationDetailsScreen> createState() =>
// //       _LocationDetailsScreenState();
// // }
// //
// // class _LocationDetailsScreenState extends ConsumerState<LocationDetailsScreen> {
// //   bool isAutoLocation = false;
// //   bool isManualEntry = true;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final locationState = ref.watch(locationProvider);
// //     final heightQuery = MediaQuery.of(context).size.height;
// //
// //     return Material(
// //       color: Colors.transparent,
// //       child: Stack(
// //         children: [
// //           _buildHeader(context, heightQuery),
// //           _buildBody(context, heightQuery, locationState),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeader(BuildContext context, double heightQuery) {
// //     return Container(
// //       height: heightQuery * 0.2,
// //       color: Colors.red,
// //       padding: const EdgeInsets.only(top: 40, left: 16),
// //       child: Row(
// //         children: [
// //           GestureDetector(
// //             onTap: () {
// //               widget.onPop('true');
// //               Navigator.pop(context);
// //             },
// //             child: const Icon(
// //               Icons.arrow_back_ios,
// //               size: 20,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(width: heightQuery * 0.15),
// //           const Text(
// //             'Location',
// //             style: TextStyle(
// //               fontSize: 18,
// //               color: Colors.white,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBody(
// //       BuildContext context, double heightQuery, LocationState state) {
// //     return Positioned(
// //       top: heightQuery * 0.2,
// //       left: 0,
// //       right: 0,
// //       bottom: 0,
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: const BorderRadius.vertical(
// //             top: Radius.circular(20),
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.1),
// //               blurRadius: 10,
// //               offset: const Offset(0, -5),
// //             ),
// //           ],
// //         ),
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 _buildLocationOptions(),
// //                 const SizedBox(height: 24),
// //                 if (isManualEntry) ...[
// //                   LocationForm(
// //                     state: state,
// //                     onSave: () => _handleSave(context),
// //                     enabled: true,
// //                   ),
// //                 ] else if (isAutoLocation) ...[
// //                   LocationForm(
// //                     state: state,
// //                     onSave: () => _handleSave(context),
// //                     enabled: false,
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLocationOptions() {
// //     return Card(
// //       elevation: 2,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'Choose Location Method',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             _buildCheckboxTile(
// //               title: 'Manual Entry',
// //               value: isManualEntry,
// //               onChanged: (value) {
// //                 if (value == true) {
// //                   setState(() {
// //                     isManualEntry = true;
// //                     isAutoLocation = false;
// //                     ref.read(locationProvider.notifier).clearLocation();
// //                   });
// //                 }
// //               },
// //               icon: Icons.edit,
// //             ),
// //             _buildCheckboxTile(
// //               title: 'Get Current Location',
// //               value: isAutoLocation,
// //               onChanged: (value) {
// //                 if (value == true) {
// //                   setState(() {
// //                     isAutoLocation = true;
// //                     isManualEntry = false;
// //                     _getCurrentLocation();
// //                   });
// //                 }
// //               },
// //               icon: Icons.my_location,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCheckboxTile({
// //     required String title,
// //     required bool value,
// //     required Function(bool?) onChanged,
// //     required IconData icon,
// //   }) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: value ? Colors.red.withOpacity(0.1) : Colors.transparent,
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: CheckboxListTile(
// //         value: value,
// //         onChanged: onChanged,
// //         title: Row(
// //           children: [
// //             Icon(icon, color: value ? Colors.red : Colors.grey),
// //             const SizedBox(width: 12),
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 color: value ? Colors.red : Colors.black,
// //                 fontWeight: value ? FontWeight.bold : FontWeight.normal,
// //               ),
// //             ),
// //           ],
// //         ),
// //         activeColor: Colors.red,
// //         checkColor: Colors.white,
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 8),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> _getCurrentLocation() async {
// //     print("Requesting location permission...");
// //     var status = await Permission.location.status;
// //     // final status = await Permission.location.request();
// //     print("Permission status: $status");
// //     if (status.isDenied || status.isRestricted) {
// //       // Request permission if denied
// //       status = await Permission.location.request();
// //       if (!status.isGranted) {
// //         // Permission is denied or permanently denied
// //         print("Location permission denied");
// //         return;
// //       }
// //     }
// //     if (status.isGranted) {
// //       try {
// //         print("Fetching current position...");
// //         final position = await Geolocator.getCurrentPosition(
// //             desiredAccuracy: LocationAccuracy.high);
// //         print("Position: ${position.latitude}, ${position.longitude}");
// //
// //         print("Fetching placemarks...");
// //         final placemarks = await placemarkFromCoordinates(
// //           position.latitude,
// //           position.longitude,
// //         );
// //         print(placemarks);
// //
// //         if (placemarks.isNotEmpty) {
// //           final place = placemarks.first;
// //
// //           // Printing all available details of the address
// //           print("Placemark Details:");
// //           print("Name: ${place.name}");
// //           print("Street: ${place.street}");
// //           print("SubLocality: ${place.subLocality}");
// //           print("Locality: ${place.locality}");
// //           print("Administrative Area: ${place.administrativeArea}");
// //           print("SubAdministrative Area: ${place.subAdministrativeArea}");
// //           print("Postal Code: ${place.postalCode}");
// //           print("Country: ${place.country}");
// //           print("ISO Country Code: ${place.isoCountryCode}");
// //           print("Thoroughfare: ${place.thoroughfare}");
// //           print("SubThoroughfare: ${place.subThoroughfare}");
// //
// //           ref.read(locationProvider.notifier).updateFromPlacemark(place);
// //         } else {
// //           print("No placemarks found.");
// //         }
// //       } catch (e) {
// //         print("Error fetching location: $e");
// //         if (mounted) {
// //           CustomSnackBar.show(
// //             context: context,
// //             message: 'Failed to get location. Please try again.',
// //             isError: true,
// //           );
// //         }
// //       }
// //     } else {
// //       print("Location permission denied.");
// //       if (mounted) {
// //         CustomSnackBar.show(
// //           context: context,
// //           message: 'Location permission denied. Please enable it in settings.',
// //           isError: true,
// //         );
// //       }
// //     }
// //   }
// //
// //   void _handleSave(BuildContext context) {
// //     if (ref.read(locationProvider.notifier).validateForm()) {
// //       widget.onPop('true');
// //       Navigator.pop(context);
// //       CustomSnackBar.show(
// //         context: context,
// //         message: 'Location details saved successfully!',
// //         isError: false,
// //       );
// //     }
// //   }
// //
// // }
