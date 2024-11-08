import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_location_screen.dart';

class RegisterUserProfessionalInfoScreen extends ConsumerStatefulWidget {
  const RegisterUserProfessionalInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterUserProfessionalInfoScreen> createState() =>
      _RegisterUserProfessionalInfoScreenState();
}

class _RegisterUserProfessionalInfoScreenState
    extends ConsumerState<RegisterUserProfessionalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? educationDetails;
  String? employmentType;
  String? occupation;
  String? incomeCurrency;
  String? annualIncome;

  final Map<String, List<String>> educationData = {
    'School': ['10th', '11th', '12th'],
    'Engineering': ['Aeronautical Engineering', 'B.E', 'B.Tech'],
    'Computer Science': ['BCA', 'B.Sc. IT/Computer Science', 'MCA'],
    'Architecture': ['B.Arch'],
  };

  final List<String> employmentOptions = [
    'Private Sector',
    'Public Sector',
    'Business Owner',
    'Self Employed',
    'Freelancer',
    'Not Working',
  ];

  final List<String> occupationOptions = [
    'Software Engineer',
    'Doctor',
    'Teacher',
    'Lawyer',
    'Business Person',
    'Other',
  ];

  final List<String> currencyOptions = [
    'INR (₹)',
    'USD (\$)',
    'EUR (€)',
    'GBP (£)',
    'AED (د.إ)',
  ];

  final Map<String, List<String>> incomeRangeOptions = {
    'INR (₹)': [
      'Less than 3 LPA',
      '3-5 LPA',
      '5-7 LPA',
      '7-10 LPA',
      '10-15 LPA',
      'More than 15 LPA',
    ],
    'USD (\$)': [
      'Less than 4,000',
      '4,000-7,000',
      '7,000-10,000',
      '10,000-15,000',
      '15,000-20,000',
      'More than 20,000',
    ],
    'EUR (€)': [
      'Less than 3,500',
      '3,500-6,000',
      '6,000-8,000',
      '8,000-12,000',
      '12,000-15,000',
      'More than 15,000',
    ],
    'GBP (£)': [
      'Less than 3,000',
      '3,000-5,500',
      '5,500-8,000',
      '8,000-12,000',
      '12,000-15,000',
      'More than 15,000',
    ],
    'AED (د.إ)': [
      'Less than 10,000',
      '10,000-15,000',
      '15,000-20,000',
      '20,000-30,000',
      '30,000-40,000',
      'More than 40,000',
    ],
  };

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

  Widget _buildSelectionField({
    required String value,
    required String hint,
    required VoidCallback onTap,
  }) {
    return InkWell(
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

  @override
  Widget build(BuildContext context) {
    final registerStateNotifier = ref.watch(registerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: ProgressIndicatorWidget(value: 0.7),
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Professional Information',
                  style: AppTextStyles.headingTextstyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'The Perfect Match for Your Personal Preferences',
                  style: AppTextStyles.spanTextStyle,
                ),
                const SizedBox(height: 30),

                // Education Selection
                _buildSelectionField(
                  value: educationDetails ?? '',
                  hint: 'Select your education details',
                  onTap: () {
                    List<String> allEducationOptions = [];
                    educationData.values.forEach(allEducationOptions.addAll);
                    _showSelectionDialog(
                      'Select Education',
                      allEducationOptions,
                      educationDetails,
                      (value) => setState(() => educationDetails = value),
                    );
                  },
                ),
                const SizedBox(height: 16),

                _buildSelectionField(
                  value: employmentType ?? '',
                  hint: 'Select your employment type',
                  onTap: () {
                    _showSelectionDialog(
                      'Select Employment Type',
                      employmentOptions,
                      employmentType,
                      (value) => setState(() => employmentType = value),
                    );
                  },
                ),
                const SizedBox(height: 16),

                employmentType == 'Not Working'
                    ? const SizedBox()
                    : _buildSelectionField(
                        value: occupation ?? '',
                        hint: 'Select your occupation',
                        onTap: () {
                          _showSelectionDialog(
                            'Select Occupation',
                            occupationOptions,
                            occupation,
                            (value) => setState(() => occupation = value),
                          );
                        },
                      ),
                const SizedBox(height: 16),

                employmentType == 'Not Working'
                    ? const SizedBox()
                    : _buildSelectionField(
                        value: incomeCurrency ?? '',
                        hint: 'Select your income currency',
                        onTap: () {
                          _showSelectionDialog(
                            'Select Income Currency',
                            currencyOptions,
                            incomeCurrency,
                            (value) {
                              setState(() {
                                incomeCurrency = value;
                                annualIncome = null;
                              });
                            },
                          );
                        },
                      ),
                const SizedBox(height: 16),

                // Annual Income Selection
                employmentType == 'Not Working'
                    ? const SizedBox()
                    : _buildSelectionField(
                        value: annualIncome ?? '',
                        hint: 'Select your annual income',
                        onTap: () {
                          if (incomeCurrency != null) {
                            _showSelectionDialog(
                              'Select Annual Income',
                              incomeRangeOptions[incomeCurrency]!,
                              annualIncome,
                              (value) => setState(() => annualIncome = value),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please select an income currency first.')),
                            );
                          }
                        },
                      ),
                const SizedBox(height: 16),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await ref
                            .read(registerProvider.notifier)
                            .createProfessionalApi(
                              education: educationDetails,
                              annualIncome: annualIncome,
                              employedType: employmentType,
                              occupation: occupation,
                              annualIncomeCurrency: incomeCurrency,
                            );
                        if (registerStateNotifier.error == null &&
                            registerStateNotifier.success != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RegisterUserLocationScreen(),
                            ),
                          );
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: registerStateNotifier.isLoading
                        ? const Center(
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                )),
                          )
                        : const Text('Next',
                            style: AppTextStyles.primarybuttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
