import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/horoscopeandstar/riverpod/horoscope_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:intl/intl.dart';

class HoroscopeAddDetailScreen extends ConsumerStatefulWidget {
  const HoroscopeAddDetailScreen({super.key});

  @override
  ConsumerState<HoroscopeAddDetailScreen> createState() =>
      _HoroscopeAddDetailScreenState();
}

class _HoroscopeAddDetailScreenState
    extends ConsumerState<HoroscopeAddDetailScreen> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(horoscopeProvider.notifier).resetHoroscope();
    ref.read(horoscopeProvider.notifier).setHoroscope(ref.read(userManagementProvider).userDetails);
  }

  Future<void> _selectDate(BuildContext context) async {
    final horoscopeState = ref.read(horoscopeProvider.notifier);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      horoscopeState.updateDateOfBirth(DateFormat('dd-MM-yyyy').format(picked));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final horoscopeState = ref.read(horoscopeProvider);
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: horoscopeState.timeOfBirth != null
          ? convertStringToTimeOfDay(horoscopeState.timeOfBirth!)
          : TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      ref.read(horoscopeProvider.notifier).updateTimeOfBirth(formattedTime);
    }
  }

  TimeOfDay convertStringToTimeOfDay(String timeString) {
    final DateFormat format = DateFormat('hh:mm a');
    final DateTime dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    final horoscopeState = ref.watch(horoscopeProvider);
    return EnhancedLoadingWrapper(
      isLoading: horoscopeState.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.red, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Add Horoscope Details',
            style: AppTextStyles.headingTextstyle.copyWith(fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/starimage.png'),
                    ),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              horoscopeState.dateOfBirth ??
                                  'Select Date Of Birth',
                              style: TextStyle(
                                  color: horoscopeState.dateOfBirth != null
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 16),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryButtonColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              horoscopeState.timeOfBirth ??
                                  'Select Time Of Birth',
                              style: TextStyle(
                                  color: horoscopeState.timeOfBirth != null
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 16),
                            ),
                          ),
                          const Icon(
                            Icons.access_time_sharp,
                            color: AppColors.primaryButtonColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Country dropdown
                // CustomDropdownField(
                //   value: selectedCountry ?? '',
                //   hint: 'Select your country',
                //   items: _countries,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedCountry = newValue!;
                //     });
                //   },
                // ),
                buildTextFieldWithIcon(
                    controller: countryController,
                    icon: Icons.location_on,
                    onChanged: (value) {
                      ref
                          .read(horoscopeProvider.notifier)
                          .updateBirthCountry(value);
                    },
                    hintText: 'Enter Your Birth Country',
                    enabled: true),
                const SizedBox(height: 24),

                // State dropdown
                // CustomDropdownField(
                //   value: selectedState ?? '',
                //   hint: 'Select your state',
                //   items: _states,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedState = newValue!;
                //     });
                //   },
                // ),
                buildTextFieldWithIcon(
                    controller: stateController,
                    icon: Icons.location_on,
                    onChanged: (value) {
                      ref.read(horoscopeProvider.notifier).updateBirthCity(value);
                    },
                    hintText: 'Enter Your Birth State',
                    enabled: true),
                const SizedBox(height: 24),

                // City dropdown
                // CustomDropdownField(
                //   value: selectedCity ?? '',
                //   hint: 'Select your city of birth',
                //   items: _cities,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedCity = newValue!;
                //     });
                //   },
                // ),
                buildTextFieldWithIcon(
                    controller: cityController,
                    icon: Icons.location_on,
                    onChanged: (value) {
                      ref.read(horoscopeProvider.notifier).updateBirthCity(value);
                    },
                    hintText: 'Enter Your Birth City',
                    enabled: true),
                const SizedBox(height: 24),

                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await ref
                          .read(horoscopeProvider.notifier)
                          .editHoroscope();
                      if (result) {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Horoscope Updated Successfully.',
                            isError: false);
                        Navigator.of(context).pop();
                      } else {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Something Went Wrong. Please Try Again!.',
                            isError: true);
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: const Text(
                      'Save',
                      style: AppTextStyles.primarybuttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldWithIcon({
    required String hintText,
    required IconData icon,
    required bool enabled,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        suffixIcon: Icon(icon,
            color: enabled
                ? AppColors.primaryButtonColor
                : AppColors.primaryButtonColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
