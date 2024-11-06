import 'package:flutter/material.dart';

class UpdatePartnerLocationPreferenceScreen extends StatefulWidget {
  const UpdatePartnerLocationPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePartnerLocationPreferenceScreen> createState() =>
      _UpdatePartnerLocationPreferenceScreenState();
}

class _UpdatePartnerLocationPreferenceScreenState
    extends State<UpdatePartnerLocationPreferenceScreen> {
  // Form values
  String country = 'Select Country';
  String state = 'Select State';
  String city = 'Select City';

  // States and cities data
  final Map<String, List<String>> statesMap = {
    'India': [
      'Tamil Nadu',
      'Maharashtra',
      'Karnataka',
      'Delhi',
      'Gujarat',
    ],
  };

  final Map<String, List<String>> citiesMap = {
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Tiruchirappalli',
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
    ],
    'Karnataka': [
      'Bengaluru',
      'Mysuru',
      'Mangalore',
    ],
    'Delhi': [
      'New Delhi',
      'Old Delhi',
    ],
    'Gujarat': [
      'Ahmedabad',
      'Surat',
      'Vadodara',
    ],
  };

  List<String> selectedStates = [];
  List<String> selectedCities = [];

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
                            'Location',
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
                                _buildDetailItem('Country', country,
                                    onTap: () => _showOptionsDialog(
                                        'Select Country', [
                                      'India',
                                      'USA',
                                      'Canada',
                                      'Australia',
                                      'UK',
                                      'Other'
                                    ], (value) {
                                      setState(() {
                                        country = value;
                                        state =
                                        'Select State'; // Reset state
                                        city = 'Select City'; // Reset city
                                      });
                                      if (value == 'India') {
                                        selectedStates =
                                        statesMap['India']!;
                                      } else {
                                        selectedStates = [];
                                        selectedCities = [];
                                      }
                                    })),
                                // Only show states and cities if the selected country is India
                                if (country == 'India') ...[
                                  _buildDetailItem('State', state, onTap: () {
                                    if (selectedStates.isNotEmpty) {
                                      _showOptionsDialog(
                                          'Select State', selectedStates,
                                              (value) {
                                            setState(() {
                                              state = value;
                                              city = 'Select City'; // Reset city
                                            });
                                            selectedCities = citiesMap[value] ?? [];
                                          });
                                    }
                                  }),
                                  _buildDetailItem('City', city, onTap: () {
                                    if (selectedCities.isNotEmpty) {
                                      _showOptionsDialog(
                                          'Select City', selectedCities,
                                              (value) {
                                            setState(() {
                                              city = value;
                                            });
                                          });
                                    }
                                  }),
                                ],
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
                  'Edit Location',
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
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

  void _showOptionsDialog(
      String title, List<String> options, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {
                    onSelect(options[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
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