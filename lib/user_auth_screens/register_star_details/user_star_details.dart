import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/user_auth_screens/register_star_details/heroscope_add_details_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

import '../../common/widget/common_dialog_box.dart';

class AddStarDetailScreen extends ConsumerStatefulWidget {
  const AddStarDetailScreen({super.key});

  @override
  _AddStarDetailScreenState createState() => _AddStarDetailScreenState();
}

class _AddStarDetailScreenState extends ConsumerState<AddStarDetailScreen> {
  final List<String> starList = [
    'Ashwini',
    'Bharani',
    'Krittika',
    'Rohini',
    'Mrigashirsha',
    'Ardra',
    'Punarvasu',
    'Pushya',
    'Ashlesha',
    'Magha',
    'Purva Phalguni',
    'Uttara Phalguni',
    'Hasta',
    'Chitra',
    'Swati',
    'Vishakha',
    'Anuradha',
    'Jyeshtha',
    'Mula',
    'Purva Ashadha',
    'Uttara Ashadha',
    'Shravana',
    'Dhanishta',
    'Shatabhisha',
    'Purva Bhadrapada',
    'Uttara Bhadrapada',
    'Revati'
  ];

  final List<String> raasiList = [
    'Mesha',
    'Vrishabha',
    'Mithuna',
    'Karka',
    'Simha',
    'Kanya',
    'Tula',
    'Vrishchika',
    'Dhanu',
    'Makara',
    'Kumbha',
    'Meena'
  ];

  // Variables to hold the selected star and raasi
  String selectedStar = '';
  String selectedRaasi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Star Details',
            style: AppTextStyles.headingTextstyle),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: AppTextStyles.headingTextstyle,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
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

              // Star dropdown
              CustomDropdownField(
                value: selectedStar,
                hint: 'Enter Star',
                items: starList,
                onChanged: (newValue) {
                  setState(() {
                    selectedStar = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Raasi dropdown
              CustomDropdownField(
                value: selectedRaasi.toString(),
                hint: 'Enter Raasi',
                items: raasiList,
                onChanged: (Value) {
                  setState(() {
                    selectedRaasi = Value!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(preferenceInputProvider.notifier)
                        .updatePreferenceInput(
                            star: selectedStar, rassi: selectedRaasi);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HoroscopeAddDetailScreen(
                          onPop: (bool value) {},
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
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
}
