import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_location_screen.dart';

class RegisterUserProfessionalInfoScreen extends ConsumerStatefulWidget {
  const RegisterUserProfessionalInfoScreen({super.key});

  @override
  ConsumerState<RegisterUserProfessionalInfoScreen> createState() =>
      _RegisterUserProfessionalInfoScreenState();
}

class _RegisterUserProfessionalInfoScreenState
    extends ConsumerState<RegisterUserProfessionalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  String educationDetails = '';
  String employmentType = '';
  String occupation = '';
  String incomeCurrency = '';
  String annualIncome = '';

  final Map<String, List<String>> educationData = {
    'School Education': [
      '10th',
      '12th',
      'Secondary School',
    ],
    'Undergraduate Education': [
      'Bachelor\'s Degree',
      'BCA',
      'B.Sc. IT/Computer Science',
      'B.Tech',
      'B.E',
      'B.Arch',
      'Aeronautical Engineering',
      'B.Plan',
      'B.Sc.',
      'B.S.W',
      'B.Phil.',
      'B.M.M.',
      'BFA',
      'BFT',
      'BLIS',
      'B.H.M.',
      'BHA / BHM (Hospital Administration)',
      'Other Bachelor Degree in Engineering / Computers',
      'Other Bachelor Degree in Arts / Science / Commerce',
      'Other Bachelor Degree in Management',
      'Other Bachelor Degree in Legal',
      'Other Bachelor Degree in Medicine',
    ],
    'Postgraduate Education': [
      'Master\'s Degree',
      'MCA',
      'M.Tech',
      'M.Sc. IT/Computer Science',
      'M.S.(Engg.)',
      'M.Arch.',
      'MFA',
      'M.Ed.',
      'MSc',
      'M.Phil.',
      'M.Com',
      'MSW',
      'MHA / MHM (Hospital Administration)',
      'MFM (Financial Management)',
      'MHM  (Hotel Management)',
      'MHRM (Human Resource Management)',
      'PGDM',
      'Other Master Degree in Engineering / Computers',
      'Other Master Degree in Arts / Science / Commerce',
      'Other Master Degree in Management',
      'Other Master Degree in Medicine',
      'Other Master Degree in Legal',
    ],
    'Doctoral Education': [
      'Ph.D.',
      'DM',
      'Postdoctoral fellow',
      'Fellow of National Board (FNB)',
    ],
    'Vocational Education': [
      'Vocational Training',
      'Technical Certification',
      'Online Courses',
    ],
    'Diploma Education': [
      'Diploma',
      'Polytechnic',
      'Trade School',
      'Others in Diploma',
      'Other Degree in Finance',
    ],
    'Legal & Financial Education': [
      'CA',
      'CFA (Chartered Financial Analyst)',
      'CS',
      'ICWA',
      'IAS',
      'IES',
      'IFS',
      'IRS',
      'IPS',
      'Other Degree in Service',
    ],
    'Medical Education': [
      'B.A.M.S.',
      'BDS',
      'BHMS',
      'BSMS',
      'BUMS',
      'BVSc',
      'MBBS',
      'MDS',
      'MD / MS (Medical)',
      'MVSc',
      'MCh',
      'DNB',
      'BPharm',
      'BPT',
      'B.Sc. Nursing',
      'M.Pharm',
      'MPT',
      'Other'
    ],
  };

  final List<String> employmentOptions = [
    'Private',
    'Government',
    'Business',
    'Self Employed',
    'Freelancer',
    'Retired',
    'Student',
    'Housewife',
    'Not Working',
    'Other',
  ];

  final List<String> occupationOptions = [
    'Software Professional',
    'Engineer',
    'Doctor',
    'Teacher',
    'Business Owner',
    'Accountant',
    'Lawyer',
    'Architect',
    'Consultant',
    'Artist',
    'Writer',
    'Sales Professional',
    'Marketing Professional',
    'Healthcare Worker',
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
      '₹ 1 lakh & below',
      '₹ 1 lakh - ₹ 2 lakh',
      '₹ 2 lakh - ₹ 3 lakh',
      '₹ 3 lakh - ₹ 5 lakh',
      '₹ 5 lakh - ₹ 7 lakh',
      '₹ 7 lakh - ₹ 10 lakh',
      '₹ 10 lakh - ₹ 15 lakh',
      '₹ 15 lakh - ₹ 20 lakh',
      '₹ 20 lakh - ₹ 30 lakh',
      '₹ 30 lakh - ₹ 40 lakh',
      '₹ 40 lakh - ₹ 50 lakh',
      '₹ 50 lakh & above',
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
        title: const ProgressIndicatorWidget(value: 0.7),
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
                  value: educationDetails,
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
                  value: employmentType,
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
                        value: occupation,
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
                        value: incomeCurrency,
                        hint: 'Select your income currency',
                        onTap: () {
                          _showSelectionDialog(
                            'Select Income Currency',
                            currencyOptions,
                            incomeCurrency,
                            (value) {
                              setState(() {
                                incomeCurrency = value;
                                annualIncome = '';
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
                        value: annualIncome,
                        hint: 'Select your annual income',
                        onTap: () {
                          if (incomeCurrency.isNotEmpty) {
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
                      if (registerStateNotifier.isLoading) {
                      } else {
                        if (educationDetails.isNotEmpty) {
                          bool success = await ref
                              .read(registerProvider.notifier)
                              .createProfessionalApi(
                                education: educationDetails,
                                annualIncome: annualIncome,
                                employedType: employmentType,
                                occupation: occupation,
                                annualIncomeCurrency: incomeCurrency,
                              );
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterUserLocationScreen(),
                              ),
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
