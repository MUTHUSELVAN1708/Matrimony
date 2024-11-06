import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';

class AllMatchesDetailsScreen extends StatefulWidget {
  const AllMatchesDetailsScreen({super.key});

  @override
  State<AllMatchesDetailsScreen> createState() =>
      _AllMatchesDetailsScreenState();
}

class _AllMatchesDetailsScreenState extends State<AllMatchesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('All Matches 1/15938',
            style: TextStyle(color: Colors.black)),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(context),
              _buildProfileDetails(),
              _buildPreferenceDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.three_g_mobiledata_outlined,
                          color: Colors.white),
                      Icon(Icons.three_g_mobiledata_outlined,
                          color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Gautham',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'MSE17920 | Last seen few hours ago',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          // Wrap(
          //   spacing: 8,
          //   children: [
          //     _buildInfoChip('26 Yrs, 5\'9"'),
          //     _buildInfoChip('Chennai'),
          //     _buildInfoChip('Software Professional'),
          //   ],
          // ),
          _buildBasicDetails('26 Yrs, 5\'9"', 'profileIcon'),
          const SizedBox(height: 8),
          _buildBasicDetails(
              'Church Of South India (Caste No Bar)', 'building_icon'),
          const SizedBox(height: 8),
          _buildBasicDetails('BE, Software Professional', 'professional_icon'),
          const SizedBox(height: 8),
          _buildBasicDetails('Chennai, Tamil Nadu', 'location_icon'),
          const SizedBox(height: 15),
          const Text(
            'About Gowtham',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'To describe about our family, we belong to the Christian Church of South India caste and looking for a match from other communities also. We are a nuclear family with traditional values. My son resides in Chennai.',
            style: TextStyle(height: 1.5, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            'About his family',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'My son is Gowtham and myself working in real estate. My wife is a homemaker and my daughter is a fashion designer.',
            style: TextStyle(height: 1.5, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Center(
              child: Text(
            'Profile verification score - 2/5',
            style: TextStyle(color: Colors.red.shade700, fontSize: 20),
          )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final stringsVerified = [
                'Mobile\nVerified',
                'Govt.ID\nVerified',
                'Photo\nVerified',
                'Education\nVerified',
                'Income\nVerified'
              ];
              final stringsNotVerified = [
                'Mobile Not\nVerified',
                'Govt.ID Not\nVerified',
                'Photo Not\nVerified',
                'Education Not\nVerified',
                'Income Not\nVerified'
              ];
              return Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                    // child: const CustomSvg(name: ''),
                  ),
                  Text(
                    stringsVerified[index],
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      children: [
        _buildSection('His Basic Details', [
          _buildDetailItem('Age', '26 Years', 'user_alt'),
          _buildDetailItem('Physique', "68Kg | " "5'5 | " "Normal", 'height'),
          _buildDetailItem(
              'Spoken Languages', 'Tamil (Mother Tongue)', 'language'),
          _buildDetailItem('Eating Habits',
              'To View His Eating Habits, Add Yours', 'chef_hat'),
          _buildDetailItem('Profile Created By', 'Parents', 'user-edit'),
          _buildDetailItem('Marital Status', 'Never Married', 'wedding_ring'),
          _buildDetailItem('Lives In', 'Chennai, Tamil Nadu', 'location_icon'),
          _buildDetailItem('Citizenship', 'Indian Citizen', 'flag'),
          _buildDetailItem('Smoking Habits', 'Doesnt Smoke', 'smoking'),
          _buildDetailItem('Drinking Habits', 'Doesnt Drink', 'wine_glass'),
        ]),
        _buildSection('contact number', [
          _buildDetailItem(
              'Mobile Number', '+91 9560840637', 'Phone _Calling_icon'),
          ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.blue,
                  height: 20,
                  // width: 5,
                  child: Row(
                    children: [Text('verified')],
                  ),
                ),
                Container(
                  // color: Colors.blue,
                  height: 20,
                  //  width: 5,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/whatsapp_icon.svg'),
                      Text('whatsapp')
                    ],
                  ),
                ),
                Container(
                    color: Colors.blue,
                    height: 20,
                    //  width: 5,
                    child: Row(
                      children: [Text('Call')],
                    ))
              ],
            )
          ]
        ]),
        _buildSection('His Religious Details', [
          _buildDetailItem('Religion', 'Christian', 'kumbudu'),
          _buildDetailItem('Caste/Subcaste', 'Church Of Sounth India', 'notes'),
          _buildDetailItem('Gothra(M)', 'Not Specified', 'people'),
        ]),
        _buildSection('His Horoscope Details', [
          _buildDetailItem('Date Of Birth', '19.09.2024', 'calendar_date'),
          _buildDetailItem('Time Of Birth', '10:10:20', 'calendar_date'),
          _buildDetailItem(
              'Star/Rassi', 'Star is Ashwini\nRaasi is TVK', 'astronomy'),
        ]),
        _buildSection('His Professional Details', [
          _buildDetailItem(
              'Employment', 'Works in Private Sector', 'card_profile'),
          _buildDetailItem('Annual Income', '16-18 Lakhs', 'money_bag'),
          _buildDetailItem('Education', 'B.E Computer Science Engineering',
              'professional_icon'),
          _buildDetailItem(
              'Occupation', 'Software Professional', 'professional_icon'),
        ]),
        _buildSection('About His Family', [
          _buildDetailItem('Family Type', 'Joint Family', 'family_type'),
          _buildDetailItem(
              'Family Status', 'Upper Middle Class', 'family_type'),
          _buildDetailItem('Parents',
              'Father is a businessman, mother is a home maker', '2person'),
          _buildDetailItem('Sisters', '1 Sister', 'profileIcon'),
        ]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon(Icons.info_outline, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, String icon) {
    print("icon");
    print(icon);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          CustomSvg(name: (icon.isEmpty) ? 'new_verify' : icon)
// Space between text and icon
          // const Icon(
          //   Icons.verified,
          //   color: Colors.green,
          // ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPreferenceDetails() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            "Gowtham's Partner Preferences",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xffdb85a2), // Set background color
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // Shadow color
                blurRadius: 8, // Softening the shadow
                offset: Offset(0, 2), // Position of the shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircleAvatar(),
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Gowtham's Partner Preferences",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              _buildCircleAvatar(),
            ],
          ),
        ),
        _buildSection('His Basic Preferences', [
          _buildDetailItem('Age', '24-28 years', ''),
          _buildDetailItem('Height', "4'7\"-5'7\"", ''),
          _buildDetailItem('Marital Status', 'Never Married', ''),
          _buildDetailItem('Physical Status', 'Normal', ''),
        ]),
        _buildSection('His Religious Preferences', [
          _buildDetailItem('Preferred Religion', 'Christian', ''),
          _buildDetailItem('Preferred Caste', "Any", ''),
          _buildDetailItem('Preferred Star', 'Any', ''),
          _buildDetailItem('Preferred Dosham', 'Any', ''),
        ]),
        _buildSection('His Professional Preferences', [
          _buildDetailItem('Preferred education',
              'Aeronautical Engineering, B.Arch, B.Plan, BS', ''),
          _buildDetailItem('Preferred Employment Type', "Any", ''),
          _buildDetailItem('Preferred Occupation', 'Any', ''),
          _buildDetailItem('Preferred Annual Income', 'Any', ''),
        ]),
        _buildSection('His Location Preferences', [
          _buildDetailItem('Preferred Country', 'India', ''),
          _buildDetailItem('Preferred Residing State',
              "Tamil Nadu, Karnataka, Kerala, Andhra Pradesh, Pondicherry", ''),
          _buildDetailItem('Preferred Residing City', 'Any', ''),
        ]),
      ],
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2), // Red border
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[200], // Background color for the avatar
        // Optionally add an image or icon here
      ),
    );
  }

  Widget _buildBasicDetails(String label, String icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomSvg(
          name: icon,
        ),
      ],
    );
  }
}
