import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';

class UpdateFamilyDetail extends StatefulWidget {
  const UpdateFamilyDetail({Key? key}) : super(key: key);

  @override
  State<UpdateFamilyDetail> createState() => _UpdateFamilyDetailState();
}

class _UpdateFamilyDetailState extends State<UpdateFamilyDetail> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  String? familyValue;
  String? familyType;
  String familyStatus = 'Upper - Middle Class';
  String fatherName = '';
  String motherName = '';
  String? fathersOccupation;
  String? motherOccupation;
  String? numberOfBrothers;
  String? brothersMarried;
  String? numberOfSisters;
  String? sistersMarried;

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
                                    _buildDetailItem('Family Value',
                                        familyValue ?? '-Select-', onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Family Value',
                                          options: const [
                                            'join family',
                                            "nuclear family",
                                            'others'
                                          ],
                                          selectedValue:
                                              familyValue ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              familyValue = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    _buildDetailItem(
                                        'Family Type', familyType ?? '-Select-',
                                        onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Family Type',
                                          options: const [
                                            'orthodox',
                                            "traditional",
                                            'moderate',
                                            'liberal'
                                          ],
                                          selectedValue: familyType ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              familyType = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                    _buildDetailItem(
                                        'Family Status', familyStatus,
                                        onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Family Status',
                                          options: const [
                                            'middle class',
                                            "upper - middle classs",
                                            'high class',
                                            'rich / affluent'
                                          ],
                                          selectedValue:
                                              familyStatus ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              familyStatus = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
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
                                        onChanged: (value) {
                                          fatherName = value;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Father Name',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical:
                                                  12), // Padding inside the TextField
                                        ),
                                      ),
                                    ),
                                    _buildDetailItem(
                                      'Fathers\' Occupation',
                                      fathersOccupation ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'Fathers\' Occupation',
                                            options: const [
                                              'employed',
                                              'business man',
                                              'professional',
                                              'retired',
                                              "Not employed",
                                              'passed away'
                                            ],
                                            selectedValue:
                                                fathersOccupation ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                fathersOccupation = value;
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
                                            offset: Offset(1, 2),
                                            blurRadius: 11.1,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        onChanged: (value) {
                                          motherName = value;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Mother Name',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical:
                                                  12), // Padding inside the TextField
                                        ),
                                      ),
                                    ),
                                    _buildDetailItem(
                                      'Mother Occupation',
                                      motherOccupation ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'Mother Occupation',
                                            options: const [
                                              'homemaker',
                                              "employed",
                                              'business woman',
                                              'professional',
                                              'retired',
                                              'passed away'
                                            ],
                                            selectedValue:
                                                motherOccupation ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                motherOccupation = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    _buildDetailItem(
                                      'No. Of Brother\'s',
                                      numberOfBrothers ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'No. Of Brother\'s',
                                            options: const [
                                              'None',
                                              "1",
                                              "2",
                                              "3",
                                              "4",
                                              "4+",
                                            ],
                                            selectedValue:
                                                numberOfBrothers ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                numberOfBrothers = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    _buildDetailItem(
                                      'Brothers\' Married',
                                      brothersMarried ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'Brothers\' Married',
                                            options: const ['None', "Married"],
                                            selectedValue:
                                                brothersMarried ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                brothersMarried = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    _buildDetailItem(
                                      'No. Of Sisters',
                                      numberOfSisters ?? '-Select-',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CommonSelectionDialog(
                                            removeSearching: true,
                                            title: 'No. Of Sisters',
                                            options: const [
                                              'None',
                                              "1",
                                              '2',
                                              '3',
                                              '4',
                                              '4+',
                                            ],
                                            selectedValue:
                                                numberOfSisters ?? 'Select',
                                            onSelect: (value) {
                                              setState(() {
                                                numberOfSisters = value;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    _buildDetailItem('Sisters\' Married',
                                        sistersMarried ?? '-Select-',
                                        onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CommonSelectionDialog(
                                          removeSearching: true,
                                          title: 'Sisters\' Married',
                                          options: const ['None', "Married"],
                                          selectedValue:
                                              sistersMarried ?? 'Select',
                                          onSelect: (value) {
                                            setState(() {
                                              sistersMarried = value;
                                            });
                                          },
                                        ),
                                      );
                                    }),
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
