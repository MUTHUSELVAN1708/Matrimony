import 'package:flutter/material.dart';

class UpdatePartnerReligiousPreferenceScreen extends StatefulWidget {
  const UpdatePartnerReligiousPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePartnerReligiousPreferenceScreen> createState() =>
      _UpdatePartnerReligiousPreferenceScreenState();
}

class _UpdatePartnerReligiousPreferenceScreenState
    extends State<UpdatePartnerReligiousPreferenceScreen> {
  // Form values
  String religion = 'Hindu';
  String caste = "Nadar";
  String division = 'Any';
  String star = 'Any';
  String raasi = 'Any';

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
                            'Religious Information',
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
                                _buildDetailItem('Religion', religion,
                                    onTap: () => _showOptionsDialog(
                                        'Select Religion', [
                                      'Hindu',
                                      'Muslim',
                                      'Christian',
                                      'Sikh'
                                    ], (value) {
                                      setState(() {
                                        religion = value;
                                      });
                                    })),
                                _buildDetailItem('Caste', caste,
                                    onTap: () => _showOptionsDialog(
                                        'Select Caste', [
                                      'Nadar',
                                      'Brahmin',
                                      'Vellalar',
                                      'Other'
                                    ], (value) {
                                      setState(() {
                                        caste = value;
                                      });
                                    })),
                                _buildDetailItem('Division', division,
                                    onTap: () => _showOptionsDialog(
                                        'Select Division', [
                                      'Any',
                                      'Sub-Division 1',
                                      'Sub-Division 2'
                                    ], (value) {
                                      setState(() {
                                        division = value;
                                      });
                                    })),
                                _buildDetailItem('Star', star,
                                    onTap: () => _showOptionsDialog(
                                        'Select Star', [
                                      'Any',
                                      'Ashwini',
                                      'Bharani',
                                      'Krithika'
                                    ], (value) {
                                      setState(() {
                                        star = value;
                                      });
                                    })),
                                _buildDetailItem('Raasi', raasi,
                                    onTap: () => _showOptionsDialog(
                                        'Select Raasi', [
                                      'Any',
                                      'Mesha',
                                      'Vrishabha',
                                      'Mithuna'
                                    ], (value) {
                                      setState(() {
                                        raasi = value;
                                      });
                                    })),
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
                  'Edit Religious Information',
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