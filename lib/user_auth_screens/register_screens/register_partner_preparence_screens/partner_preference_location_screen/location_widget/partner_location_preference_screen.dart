import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/user_auth_screens/instrest_screens/select_instrest_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/location_widget/common_location_dropdown.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:matrimony/user_auth_screens/register_star_details/user_star_details.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class PartnerLocationScreen extends ConsumerStatefulWidget {
  const PartnerLocationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerLocationScreen> createState() =>
      _PartnerLocationScreenState();
}

class _PartnerLocationScreenState extends ConsumerState<PartnerLocationScreen> {
  List<String> selectedCountry = [];
  List<String> selectedState = [];
  List<String> selectedCity = [];
  bool? ownHouse;

  @override
  initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    await Future.delayed(Duration.zero);
    ref.read(locationProvider.notifier).getallCountryData();
  }

  bool countryOther = false;
  bool stateOther = false;
  bool cityOther = false;
  final countryCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final cityCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userRegisterState = ref.watch(partnerPreferenceProvider);
    final countryState = ref.watch(locationProvider);
    return EnhancedLoadingWrapper(
      isLoading: countryState.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Partner Preferences',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Matches recommended by us are based on\n',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      TextSpan(
                        text: 'Acceptable matches ',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      TextSpan(
                        text:
                            'criteria and at times might go slightly beyond your preferences',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Location Preferences :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              // countryOther
              //     ? TextFormField(
              //         onChanged: (value) {
              //           setState(() {
              //             selectedCountry.clear();
              //             selectedCountry.add(countryCtrl.text);
              //           });
              //         },
              //         controller: countryCtrl,
              //         decoration: InputDecoration(
              //             suffixIcon: IconButton(
              //                 onPressed: () {
              //                   setState(() {
              //                     countryOther = false;
              //                   });
              //                 },
              //                 icon: const Icon(Icons.close)),
              //             hintText: 'Country',
              //             border: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(15))),
              //       )
              //     :
              PreferenceLocationDropdown(
                  other: true,
                  showSearch: true,
                  value: selectedCountry.isNotEmpty ? selectedCountry : [],
                  hint: "Country",
                  // items: countries,
                  items: [
                    ...countryState.countryList.map((e) => e.countrys).toList()
                  ],
                  onChanged: (value) async {
                    // Update the selected country first
                    setState(() {
                      selectedCountry = value;
                      selectedState.clear();
                      selectedCity.clear();
                      if (value[0] == 'Other') {
                        countryOther = true;
                      }
                    });

                    int? stateId;
                    for (var e in countryState.countryList) {
                      if (selectedCountry.isNotEmpty) {
                        if (e.countrys == selectedCountry[0]) {
                          stateId = e.id;
                          break;
                        }
                      }
                    }

                    print("Selected State ID: $stateId");

                    // Ensure stateId is not null before calling getStateData
                    if (stateId != null) {
                      await ref
                          .read(locationProvider.notifier)
                          .getStateData(stateId);
                    } else {
                      print("No state ID found for the selected country.");
                    }
                  }),
              selectedCountry.isEmpty ||
                      countryState.stateList.isEmpty ||
                      selectedCountry[0] == 'Any'
                  ? SizedBox()
                  : const SizedBox(height: 10),

              // State Dropdown
              selectedCountry.isEmpty ||
                      countryState.stateList.isEmpty ||
                      selectedCountry[0] == 'Any'
                  ? SizedBox()
                  :
                  // stateOther
                  //     ? TextFormField(
                  //         onChanged: (value) {
                  //           setState(() {
                  //             selectedState.clear();
                  //             selectedState.add(stateCtrl.text);
                  //           });
                  //         },
                  //         controller: stateCtrl,
                  //         decoration: InputDecoration(
                  //             suffixIcon: IconButton(
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     stateOther = false;
                  //                   });
                  //                 },
                  //                 icon: const Icon(Icons.close)),
                  //             hintText: 'State',
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(15))),
                  //       )
                  //     :
                  PreferenceLocationDropdown(
                      other: true,
                      showSearch: true,
                      value: selectedState.isEmpty ? selectedState : [],
                      hint: "State",
                      items: [
                        ...countryState.stateList.map((e) => e.states).toList()
                      ],
                      onChanged: (value) async {
                        setState(() {
                          selectedState = value;
                          print(selectedState);
                          selectedCity.clear();
                          if (value[0] == 'Other') {
                            stateOther = true;
                          }
                        });
                        int? stateId;
                        for (var e in countryState.stateList) {
                          if (selectedState.isNotEmpty) {
                            if (e.states == selectedState[0]) {
                              stateId = e.id;
                              break;
                            }
                          }
                        }

                        print("Selected State ID: $stateId");
                        if (stateId != null) {
                          await ref
                              .read(locationProvider.notifier)
                              .getCityData(stateId);
                        } else {
                          print("No state ID found for the selected country.");
                        }
                      },
                    ),
              selectedState.isEmpty ||
                      countryState.cityList.isEmpty ||
                      selectedState[0] == 'Any'
                  ? const SizedBox()
                  : SizedBox(height: 10),

              selectedState.isEmpty ||
                      countryState.cityList.isEmpty ||
                      selectedState[0] == 'Any'
                  ? const SizedBox()
                  :
                  // cityOther
                  //         ? TextFormField(
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 selectedCity.clear();
                  //                 selectedCity.add(cityCtrl.text);
                  //               });
                  //             },
                  //             controller: cityCtrl,
                  //             decoration: InputDecoration(
                  //                 suffixIcon: IconButton(
                  //                     onPressed: () {
                  //                       setState(() {
                  //                         cityOther = false;
                  //                       });
                  //                     },
                  //                     icon: const Icon(Icons.close)),
                  //                 hintText: 'Country',
                  //                 border: OutlineInputBorder(
                  //                     borderRadius: BorderRadius.circular(15))),
                  //           )
                  //         :
                  PreferenceLocationDropdown(
                      other: true,
                      showSearch: true,
                      value: selectedCity.isNotEmpty ? selectedCity : [],
                      hint: "City",
                      items: [
                        ...countryState.cityList.map((e) => e.citys).toList()
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                          if (value[0] == 'Other') {
                            cityOther = true;
                          }
                        });
                      },
                    ),
              const SizedBox(height: 10),
              _buildSelectionField(
                  hint: 'Own House',
                  onTap: () {
                    _selectHouse(context);
                  },
                  value: ownHouse == null
                      ? ''
                      : ownHouse!
                          ? 'Yes'
                          : 'No'),
              const SizedBox(height: 25),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedCountry.firstOrNull != null &&
                        (selectedCountry.firstOrNull != 'Any'
                            ? selectedCountry.firstOrNull != null
                            : true) &&
                        (selectedState.firstOrNull != 'Any' &&
                                selectedCountry.firstOrNull != 'Any'
                            ? selectedState.firstOrNull != null
                            : true)) {
                      ref
                          .read(preferenceInputProvider.notifier)
                          .updatePreferenceInput(
                              country: selectedCountry.firstOrNull,
                              states: selectedState.firstOrNull ?? 'Any',
                              city: selectedCity.firstOrNull ?? 'Any',
                              ownHouse: ownHouse);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InterestPageView(),
                        ),
                      );
                    } else {
                      CustomSnackBar.show(
                          context: context,
                          message: 'Please Select All Fields Mandatory!',
                          isError: true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: userRegisterState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    fontSize: 16),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
            ],
          ),
        ));
  }

  void _selectHouse(BuildContext context) {
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
                  setState(() {
                    ownHouse = true;
                  });
                  Navigator.pop(context, true);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: ownHouse == true
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color:
                          ownHouse == true ? Colors.transparent : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 16,
                          color: ownHouse == true ? Colors.black : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ownHouse = false;
                  });
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: ownHouse == false
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color:
                          ownHouse == false ? Colors.transparent : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              ownHouse == false ? Colors.black : Colors.grey),
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
}
