import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_additional_info_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';

class RegisterUserLocationScreen extends ConsumerStatefulWidget {
  const RegisterUserLocationScreen({super.key});

  @override
  _RegisterUserLocationScreenState createState() =>
      _RegisterUserLocationScreenState();
}

class _RegisterUserLocationScreenState
    extends ConsumerState<RegisterUserLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? country, state, city, flatNumber, address;
  final flatController = TextEditingController();
  final pincodeController = TextEditingController();
  bool? isOwnHouse;
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCountryData();
  }

  Future<void> getCountryData() async {
    await Future.delayed(Duration.zero);
    await ref.read(locationProvider.notifier).getallCountryData();
  }

  @override
  Widget build(BuildContext context) {
    final registerStateNotifier = ref.watch(registerProvider);
    final locationState = ref.watch(locationProvider);
    return EnhancedLoadingWrapper(
      isLoading: locationState.isLoading,
      child: Scaffold(
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
                  const SizedBox(height: 15),
                  _buildSelectionField(
                      hint: 'Select Country',
                      onTap: () {
                        _selectCountry(locationState.countryList);
                      },
                      value: country ?? ''),
                  const SizedBox(height: 10),
                  if (country != null) ...[
                    _buildSelectionField(
                        hint: 'Select State',
                        onTap: () {
                          _selectState(
                            locationState.stateList,
                          );
                        },
                        value: state ?? ''),
                    const SizedBox(height: 10),
                  ],
                  if (state != null) ...[
                    _buildSelectionField(
                        hint: 'Select City',
                        onTap: () {
                          _selectCity(locationState.cityList);
                        },
                        value: city ?? ''),
                    const SizedBox(height: 10),
                  ],
                  if (city != null) ...[
                    CustomTextField(
                        hintText: 'Pincode',
                        onSaved: (value) =>
                            pincodeController.text = value ?? '',
                        controller: pincodeController,
                        readOnly: pincodeController.text == '' ? false : true),
                    const SizedBox(height: 10),
                    _buildSelectionField(
                        hint: 'Own House',
                        onTap: () {
                          _selectHouse(context);
                        },
                        value: isOwnHouse == null
                            ? ''
                            : isOwnHouse!
                                ? 'Yes'
                                : 'No'),
                    const SizedBox(height: 10),
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
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (registerStateNotifier.isLoading) {
                        } else {
                          if (country == null) {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Please Select Your Country.',
                              isError: true,
                            );
                          } else if (state == null) {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Please Select Your State.',
                              isError: true,
                            );
                          } else if (city == null) {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Please Select Your City.',
                              isError: true,
                            );
                          } else {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              final registerState =
                                  ref.read(registerProvider.notifier);
                              bool success =
                                  await registerState.createLocationApi(
                                      country: country ?? '',
                                      states: state ?? '',
                                      pincode: pincodeController.text ?? '',
                                      city: city ?? '',
                                      flatNumber: flatNumber ?? '',
                                      address: address ?? '',
                                      ownHouse: isOwnHouse);
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSelectionDialog<T>(
    String title,
    List<T> options,
    String? currentValue,
    String Function(T) getDisplayName,
    int Function(T) getId,
    Function(String, T?) onSelect,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchQuery = '';
        String? selectedValue = currentValue;
        T? selectedId;
        String otherValue = '';

        return StatefulBuilder(
          builder: (context, setState) {
            List<T> filteredOptions = options
                .where((option) => getDisplayName(option)
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
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
                          // Title
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView(
                              children: [
                                if (filteredOptions.isNotEmpty)
                                  ...filteredOptions.map((option) {
                                    String displayName = getDisplayName(option);
                                    return RadioListTile<String>(
                                      title: Text(displayName),
                                      value: displayName,
                                      activeColor: Colors.red,
                                      groupValue: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = displayName;
                                          selectedId = option;
                                        });
                                      },
                                    );
                                  }),
                                RadioListTile<String>(
                                  title: const Text("Other"),
                                  value: "Other",
                                  activeColor: Colors.red,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = "Other";
                                      selectedId = null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (selectedValue == "Other")
                            Column(
                              children: [
                                const SizedBox(height: 16),
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    hintText: 'Enter Other Value',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      otherValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),

                    // Apply button
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: ElevatedButton(
                        onPressed:
                            selectedValue != "Other" || otherValue.isNotEmpty
                                ? () {
                                    if (selectedValue == "Other") {
                                      onSelect(otherValue, null);
                                    } else {
                                      onSelect(selectedValue!, selectedId as T);
                                    }
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

  void _selectCountry(List<Country> countryList) {
    _showSelectionDialog<Country>(
      'Select Country',
      countryList,
      country,
      (Country country) => country.countrys,
      (Country country) => country.id,
      (selectedName, selectedId) {
        if (selectedName != country) {
          setState(() {
            country = selectedName;
            state = null;
            city = null;
            pincodeController.text = '';
            isOwnHouse = null;
          });
          ref
              .read(locationProvider.notifier)
              .getStateData(selectedId?.id ?? selectedId.hashCode);
        }
      },
    );
  }

  void _selectState(List<StateModel> stateList) {
    _showSelectionDialog<StateModel>(
      'Select State',
      stateList,
      state,
      (StateModel state) => state.states,
      (StateModel state) => state.id,
      (selectedName, selectedId) {
        if (selectedName != state) {
          setState(() {
            state = selectedName;
            city = null;
            pincodeController.text = '';
            isOwnHouse = null;
          });
          ref
              .read(locationProvider.notifier)
              .getCityData(selectedId?.id ?? selectedId.hashCode);
        }
      },
    );
  }

  void _selectCity(List<City> cityList) {
    _showSelectionDialog<City>(
      'Select City',
      cityList,
      city,
      (City city) => city.citys,
      (City city) => city.id,
      (selectedName, selectedId) {
        if (selectedName != city) {
          setState(() {
            city = selectedName;
            pincodeController.text =
                cityList.any((city) => city.citys == selectedName)
                    ? selectedId?.pincode.toString() ?? ''
                    : '';
          });
        }
      },
    );
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
                    isOwnHouse = true;
                  });
                  Navigator.pop(context, true);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isOwnHouse == true
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color:
                          isOwnHouse == true ? Colors.transparent : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              isOwnHouse == true ? Colors.black : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOwnHouse = false;
                  });
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isOwnHouse == false
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color: isOwnHouse == false
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
                          color:
                              isOwnHouse == false ? Colors.black : Colors.grey),
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
    print('picocde');
    print(controller?.text);
    print(hintText);
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
