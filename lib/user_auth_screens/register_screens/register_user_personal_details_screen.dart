import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_religious_screen.dart';

class RegisterUserPersonalDetailsScreen extends ConsumerStatefulWidget {
  const RegisterUserPersonalDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterUserPersonalDetailsScreen> createState() => _RegisterUserPersonalDetailsScreenState();
}

class _RegisterUserPersonalDetailsScreenState extends ConsumerState<RegisterUserPersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedGender;
  String? physicalStatus;
  String? maritalStatus;
  DateTime? dateOfBirth;
  String? height;
  String? weight;
  String? childrens;
  String? age;

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> physicalStatusOptions = ['Normal', 'Physically Challenged'];
  final List<String> maritalStatusOptions = ['Never Married', 'Divorced', 'Widowed', 'Separated'];
  final List<String> childrenStatus = ['1','2','3','3+'];

  int calculateAge(DateTime? dateOfBirth) {
    if(dateOfBirth != null){
    final DateTime now = DateTime.now();
    int calculatedAge = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      calculatedAge--;
    }

    age = calculatedAge.toString();
    return calculatedAge;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: ProgressIndicatorWidget(value: 0.4),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryButtonColor),
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
                  const SizedBox(height: 50),
                  const Text('Personal Details', style: AppTextStyles.headingTextstyle),
                  const SizedBox(height: 8),
                  const Text('Your story of love starts here.', style: AppTextStyles.spanTextStyle),
                  const SizedBox(height: 30),

                  // Gender Selection
                  _buildCustomField(
                    label: 'Gender',
                    selectedValue: selectedGender,
                    onTap: () => _showSelectionDialog(
                      title: 'Select Gender',
                      options: genderOptions,
                      selectedValue: selectedGender,
                      onSelect: (value) => setState(() => selectedGender = value),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Date of Birth
                  GestureDetector(
                    onTap: () => _showDatePicker(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: _buildInputDecoration(
                          'Date of Birth',
                          suffixIcon: const Icon(Icons.calendar_today, size: 20),
                        ),
                        controller: TextEditingController(
                          text: dateOfBirth != null
                              ? DateFormat('dd/MM/yyyy').format(dateOfBirth!)
                              : '',
                        ),
                        validator: (value) {
                          if (dateOfBirth == null) {
                            return 'Please select your date of birth';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Height and Weight
          // Height and Weight
Row(
  children: [
    // Height field
    Expanded(
      child: TextFormField(
        decoration: _buildInputDecoration('Height'),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Only allows digits
          LengthLimitingTextInputFormatter(3),    // Restrict to 3 digits
        ],
        onChanged: (value) => height = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Required';
          }
          return null;
        },
      ),
    ),
    const SizedBox(width: 16),

    // Weight field
    Expanded(
      child: TextFormField(
        decoration: _buildInputDecoration('Weight'),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Only allows digits
          LengthLimitingTextInputFormatter(3),    // Restrict to 3 digits
        ],
        onChanged: (value) => weight = value,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Required';
          }
          return null;
        },
      ),
    ),
  ],
),

                  const SizedBox(height: 16),

                  // Physical Status
                  _buildCustomField(
                    label: 'Physical Status',
                    selectedValue: physicalStatus,
                    onTap: () => _showSelectionDialog(
                      title: 'Select Physical Status',
                      options: physicalStatusOptions,
                      selectedValue: physicalStatus,
                      onSelect: (value) => setState(() => physicalStatus = value),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Marital Status
                  _buildCustomField(
                    label: 'Marital Status',
                    selectedValue: maritalStatus,
                    onTap: () => _showSelectionDialog(
                      title: 'Select Marital Status',
                      options: maritalStatusOptions,
                      selectedValue: maritalStatus,
                      onSelect: (value) => setState(() => maritalStatus = value),
                    ),
                  ),
                      const SizedBox(height: 16),
                                  maritalStatus == 'Divorced'?
                _buildCustomField(
                    label: 'Childrens',
                    selectedValue: childrens,
                    onTap: () => _showSelectionDialog(
                      title: 'Select Childrens',
                      options: childrenStatus,
                      selectedValue: childrens,
                      onSelect: (value) => setState(() => childrens = value),
                    ),
                  ):const SizedBox(),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print(calculateAge(dateOfBirth));
                        if (_formKey.currentState?.validate() ?? false ) {
                        
                        final registerState =   ref.read(registerProvider.notifier);

                         
                registerState.personalDetails(                         
                            gender: selectedGender, 
                            dateOfBirth:calculateAge(dateOfBirth),
                             height: height, 
                             weight: weight, 
                             anyDisability: physicalStatus,
                              maritalStatus: maritalStatus,
                               noOfChildren: childrens
                               );

                         if( ref.watch(registerProvider).error == null){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterReligiousDetailsScreen(),
                            ),
                          );
                         }
  
                        }
                      },
                      style: AppTextStyles.primaryButtonstyle,
                      child: const Text('Next', style: AppTextStyles.primarybuttonText),
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

  Widget _buildCustomField({
    required String label,
    required String? selectedValue,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: _buildInputDecoration(
            label,
            suffixIcon: const Icon(Icons.arrow_drop_down, size: 24),
          ),
          controller: TextEditingController(text: selectedValue ?? ''),
          validator:(value) {
            if (selectedValue == null) {
              return 'Please select your $label';
            }
            return null;
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String labelText, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey.shade600),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
    );
  }

 Future<void> _showDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
    firstDate: DateTime.now().subtract(const Duration(days: 36500)), // 100 years ago
    lastDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Set the color scheme to have a white background
          colorScheme: const ColorScheme.light(
            primary: Colors.red,  // The primary color remains red
            onPrimary: Colors.white,
            surface: Colors.white,  // Surface background set to white
            onSurface: Colors.black,
          ),
          // Set the date picker dialog background to white
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
  );
  
  if (picked != null) {
    setState(() {
      dateOfBirth = picked;
    });
  }
}

  Future<void> _showSelectionDialog({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return showDialog(
      context: context,
      builder: (context) => SelectionDialog(
        title: title,
        options: options,
        selectedValue: selectedValue,
        onSelect: onSelect,
      ),
    );
  }
}
class SelectionDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedValue;
  final Function(String) onSelect;

  const SelectionDialog({
    Key? key,
    required this.title,
    required this.options,
    this.selectedValue,
    required this.onSelect,
  }) : super(key: key);

  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  String? _currentSelectedValue;

  @override
  void initState() {
    super.initState();
    _currentSelectedValue = widget.selectedValue; // Initialize with the current selected value
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: widget.options.map((option) {
                return GestureDetector(
                  onTap: () {
                    // Update the internal selected value on tap
                    setState(() {
                      _currentSelectedValue = option;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: _currentSelectedValue == option ? Colors.green : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _currentSelectedValue == option ? Colors.green : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            color: _currentSelectedValue == option ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_currentSelectedValue == option)
                          const Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Call the onSelect function with the new selected value
                  if (_currentSelectedValue != null) {
                    widget.onSelect(_currentSelectedValue!);
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Change the color to fit your theme
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

