// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:matrimony/common/app_text_style.dart';
// import 'package:matrimony/common/colors.dart';
// import 'package:matrimony/common/widget/circularprogressIndicator.dart';
// import 'package:matrimony/common/widget/custom_snackbar.dart';
// import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
// import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
// import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
// import 'package:matrimony/user_auth_screens/register_screens/register_user_additional_info_screen.dart';
//
// class RegisterUserLocationScreen extends ConsumerStatefulWidget {
//   @override
//   _RegisterUserLocationScreenState createState() =>
//       _RegisterUserLocationScreenState();
// }
//
// class _RegisterUserLocationScreenState
//     extends ConsumerState<RegisterUserLocationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? country, state, city, pincode, flatNumber, address;
//
//   @override
//   Widget build(BuildContext context) {
//     final registerStateNotifier = ref.watch(registerProvider);
//     final locationState = ref.watch(locationProvider);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: ProgressIndicatorWidget(value: 0.8),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios,
//               color: AppColors.primaryButtonColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Location Information',
//                 style: AppTextStyles.headingTextstyle,
//               ),
//               const SizedBox(height: 10),
//               const Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'The Perfect Match for your Personal Preference...',
//                   style: AppTextStyles.spanTextStyle,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Your Residing Country',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   ),
//                 ),
//                 onSaved: (value) => country = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Your Residing State',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(12)), // BorderRadius 12
//                   ),
//                 ),
//                 onSaved: (value) => state = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Your Residing City',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(12)), // BorderRadius 12
//                   ),
//                 ),
//                 onSaved: (value) => city = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Pincode',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(12)), // BorderRadius 12
//                   ),
//                 ),
//                 onSaved: (value) => pincode = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Flat Number',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(12)), // BorderRadius 12
//                   ),
//                 ),
//                 onSaved: (value) => flatNumber = value,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Address',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(12)), // BorderRadius 12
//                   ),
//                 ),
//                 onSaved: (value) => address = value,
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if(registerStateNotifier.isLoading){}else {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//
//                         final registerState = ref.read(
//                             registerProvider.notifier);
//                         bool success = await registerState.createLocationApi(
//                             country: country ?? '',
//                             states: state ?? '',
//                             pincode: pincode ?? '',
//                             city: city ?? '',
//                             flatNumber: flatNumber ?? '',
//                             address: address ?? '');
//                         if (success) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     RegisterUserAdditionalInfoScreen()),
//                           );
//                         }else {
//                           CustomSnackBar.show(
//                             context: context,
//                             message: 'Something Went Wrong. Please Try Again!',
//                             isError: true,
//                           );
//                         }
//                       }
//                     }
//                   },
//                   style: AppTextStyles.primaryButtonstyle,
//                   child: registerStateNotifier.isLoading
//                       ? const LoadingIndicator()
//                       : const Text(
//                           'Next',
//                           style: AppTextStyles.primarybuttonText,
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_additional_info_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';

class RegisterUserLocationScreen extends ConsumerStatefulWidget {
  @override
  _RegisterUserLocationScreenState createState() =>
      _RegisterUserLocationScreenState();
}

class _RegisterUserLocationScreenState
    extends ConsumerState<RegisterUserLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? country, state, city, pincode, flatNumber, address;
  final flatController = TextEditingController();
  bool? isOwnHouse;
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerStateNotifier = ref.watch(registerProvider);
    final locationState = ref.watch(locationProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ProgressIndicatorWidget(value: 0.8),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Location Information',
                  style: AppTextStyles.headingTextstyle,
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'The Perfect Match for your Personal Preference...',
                    style: AppTextStyles.spanTextStyle,
                  ),
                ),
                const SizedBox(height: 10),
                _buildSelectionField(
                    hint: 'Select Country',
                    onTap: () {
                      _selectCountry();
                    },
                    value: country ?? ''),
                const SizedBox(height: 10),
                // if (country != null)...[
                _buildSelectionField(
                    hint: 'Select State',
                    onTap: () {
                      _selectState();
                    },
                    value: state ?? ''),
                const SizedBox(height: 10),
                // ],
                // if (state != null)...[
                _buildSelectionField(
                    hint: 'Select City',
                    onTap: () {
                      _selectCity();
                    },
                    value: city ?? ''),
                const SizedBox(height: 10),
                // ],
                // if (city != null)...[
                CustomTextField(
                    hintText: 'Pincode',
                    onSaved: (value) => pincode = value,
                    controller: flatController,
                    readOnly: true),
                const SizedBox(height: 10),
                // ],\
                _buildSelectionField(
                    hint: 'Own House',
                    onTap: () {
                      _selectHouse(context, isOwnHouse);
                    },
                    value: state ?? ''),
                const SizedBox(height: 10),
                // if (pincode != null) ...[
                CustomTextField(
                    hintText: 'Flat Number',
                    onSaved: (value) => flatNumber = value,
                    controller: flatController,
                    readOnly: false),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Address',
                  onSaved: (value) => address = value,
                  controller: addressController,
                  readOnly: false,
                  maxLine: 3,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (registerStateNotifier.isLoading) {
                      } else {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          final registerState =
                              ref.read(registerProvider.notifier);
                          bool success = await registerState.createLocationApi(
                              country: country ?? '',
                              states: state ?? '',
                              pincode: pincode ?? '',
                              city: city ?? '',
                              flatNumber: flatNumber ?? '',
                              address: address ?? '');
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterUserAdditionalInfoScreen()),
                            );
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message:
                                  'Something Went Wrong. Please Try Again!',
                              isError: true,
                            );
                          }
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: registerStateNotifier.isLoading
                        ? const LoadingIndicator()
                        : const Text(
                            'Next',
                            style: AppTextStyles.primarybuttonText,
                          ),
                  ),
                ),
              ],
              // ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSelectionDialog(String title, List<String> options,
      String? currentValue, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchQuery = '';
        String? selectedValue = currentValue;

        return StatefulBuilder(
          builder: (context, setState) {
            List<String> filteredOptions = options
                .where((option) =>
                    option.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              fillColor: AppColors.dialogboxSearchBackground,
                              filled: true,
                              hintText: 'Search...',
                              hintStyle: const TextStyle(
                                  color: AppColors.dialogboxSearchTextColor),
                              suffixIcon: const Icon(Icons.search,
                                  color: AppColors.dialogboxSearchTextColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (filteredOptions.isEmpty)
                            const Expanded(
                                child: Center(
                              child: Text(
                                'No Result Found',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ))
                          else
                            Expanded(
                              child: ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  trackColor:
                                      WidgetStateProperty.all(Colors.pink[100]),
                                  thumbColor:
                                      WidgetStateProperty.all(Colors.pink),
                                  radius: const Radius.circular(12),
                                ),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: filteredOptions.map((option) {
                                        return RadioListTile<String>(
                                          title: Text(option),
                                          value: option,
                                          groupValue: selectedValue,
                                          activeColor:
                                              AppColors.primaryButtonColor,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: ElevatedButton(
                        onPressed: selectedValue != null
                            ? () {
                                onSelect(selectedValue!);
                                Navigator.pop(context);
                              }
                            : null,
                        style: AppTextStyles.primaryButtonstyle,
                        child: const Text('Apply',
                            style: AppTextStyles.primarybuttonText),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _selectCountry() {
    _showSelectionDialog(
      'Select Country',
      ['Country1', 'Country2', 'Country3'],
      country,
      (value) {
        setState(() {
          country = value;
          state = null;
          city = null;
          pincode = null;
        });
      },
    );
  }

  void _selectState() {
    _showSelectionDialog(
      'Select State',
      ['State1', 'State2', 'State3'],
      state,
      (value) {
        setState(() {
          state = value;
          city = null;
          pincode = null;
        });
      },
    );
  }

  void _selectHouse(BuildContext context, bool? isOwnHouse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Own House')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                ),
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCity() {
    _showSelectionDialog(
      'Select City',
      ['City1', 'City2', 'City3'],
      city,
      (value) {
        setState(() {
          city = value;
          pincode = null;
        });
      },
    );
  }

  Widget _buildSelectionField({
    required String value,
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.isEmpty ? hint : value,
                style: TextStyle(
                  color: value.isEmpty ? Colors.grey.shade600 : Colors.black,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
            ],
          ),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String?> onSaved;
  final TextEditingController? controller;
  final bool readOnly;
  final int? maxLine;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.onSaved,
      this.controller,
      required this.readOnly,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLine ?? 1,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      onSaved: onSaved,
    );
  }
}
