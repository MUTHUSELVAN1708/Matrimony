import 'package:flutter/material.dart';

class UpdatePartnerBasicPreferenceScreen extends StatefulWidget {
  const UpdatePartnerBasicPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePartnerBasicPreferenceScreen> createState() =>
      _UpdatePartnerBasicPreferenceScreenState();
}

class _UpdatePartnerBasicPreferenceScreenState
    extends State<UpdatePartnerBasicPreferenceScreen> {
  // Form values
  String dateOfBirth = '22 years / February 5, 2002';
  String height = "4 ft 9 in";
  String weight = 'Select';
  String maritalStatus = 'Never Married';
  String physicalStatus = 'Select';
  String motherTongue = 'Tamil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          // Content
          SafeArea(
            child: Column(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Basic Details',
                            style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildDetailItem(
                                    'Age / Date Of Birth', dateOfBirth,
                                    onTap: _showDatePicker),
                                _buildDetailItem('Height', height,
                                    onTap: _showHeightPicker),
                                _buildDetailItem('Weight', weight,
                                    onTap: _showWeightPicker),
                                _buildDetailItem(
                                    'Marital Status', maritalStatus,
                                    onTap: _showMaritalStatusPicker),
                                _buildDetailItem(
                                    'Physical Status', physicalStatus,
                                    onTap: _showPhysicalStatusPicker),
                                _buildDetailItem('Mother Tongue', motherTongue,
                                    onTap: _showMotherTonguePicker),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _saveDetails,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: const Text(
                  'Edit Basic Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value,
      {required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: Text(value,
            style: TextStyle(
                color: value == 'Select' ? Colors.grey : Colors.black87,
                fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2002, 2, 5),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          dateOfBirth =
              "${DateTime.now().year - date.year} years / ${date.toLocal().toString().split(' ')[0]}";
        });
      }
    });
  }

  void _showHeightPicker() {
    // Example of how you might handle height selection
    final List<String> heights = List.generate(48, (index) {
      final feet = 4 + (index ~/ 12);
      final inches = index % 12;
      return "$feet ft $inches in";
    });
    _showOptionsDialog('Select Height', heights, (value) {
      setState(() {
        height = value;
      });
    });
  }

  void _showWeightPicker() {
    // Example of how you might handle weight selection
    final List<String> weights =
        List.generate(150, (index) => '${40 + index} kg');
    _showOptionsDialog('Select Weight', weights, (value) {
      setState(() {
        weight = value;
      });
    });
  }

  void _showMaritalStatusPicker() {
    final List<String> statuses = [
      'Never Married',
      'Divorced',
      'Widowed',
      'Awaiting Divorce'
    ];
    _showOptionsDialog('Select Marital Status', statuses, (value) {
      setState(() {
        maritalStatus = value;
      });
    });
  }

  void _showPhysicalStatusPicker() {
    final List<String> statuses = ['Normal', 'Physically Challenged'];
    _showOptionsDialog('Select Physical Status', statuses, (value) {
      setState(() {
        physicalStatus = value;
      });
    });
  }

  void _showMotherTonguePicker() {
    final List<String> languages = [
      'Tamil',
      'English',
      'Hindi',
      'Malayalam',
      'Telugu',
      'Kannada'
    ];
    _showOptionsDialog('Select Mother Tongue', languages, (value) {
      setState(() {
        motherTongue = value;
      });
    });
  }

  void _showOptionsDialog(
      String title, List<String> options, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {
                    // Here you can also add some logic to highlight the selected option
                  },
                );
              },
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Collect the selected options and call the onSelect function
                  // Assuming you want to apply the last selected option
                  int selectedIndex =
                      options.indexWhere((option) => option == options.last);
                  if (selectedIndex != -1) {
                    onSelect(options[selectedIndex]);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveDetails() {
    // Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Details saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
}
