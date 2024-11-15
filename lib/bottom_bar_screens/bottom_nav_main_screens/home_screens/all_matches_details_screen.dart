import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('All Matches 1/15938',
            style: AppTextStyles.headingTextstyle),
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image/user1.png'))),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star_border_outlined,
                                  color: Colors.black),
                              Text(
                                'Shortlist',
                                style: AppTextStyles.spanTextStyle,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child:
                              const Icon(Icons.more_vert, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: CustomSvg(name: 'blue_verify'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'ID Verified',
              style: AppTextStyles.spanTextStyle
                  .copyWith(color: const Color(0XFF1576F0)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 2),
                  blurRadius: 11.1,
                  spreadRadius: 0,
                  color: Color(
                      0x0D000000), // Converting #0000000D to Flutter format
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gowtham',
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  'MSE17920 | Last seen few hours ago',
                  style: AppTextStyles.secondrySpanTextStyle,
                ),
                const SizedBox(height: 10),
                _buildBasicDetails('26 Yrs, 5\'9"', 'profileIcon'),
                const SizedBox(height: 8),
                _buildBasicDetails(
                    'Church Of South India (Caste No Bar)', 'building_icon'),
                const SizedBox(height: 8),
                _buildBasicDetails(
                    'BE, Software Professional', 'professional_icon'),
                const SizedBox(height: 8),
                _buildBasicDetails('Chennai, Tamil Nadu', 'location_icon'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'About Gowtham',
            style: AppTextStyles.spanTextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'To describe about our family, we belong to the Christian Church of South India caste and looking for a match from other communities also. We are nuclear family with traditional values. My son resides in Chennai.',
            style: AppTextStyles.secondrySpanTextStyle
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            'About his family',
            style: AppTextStyles.spanTextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'My son is Gowtham and myself working in real estate. My wife is a homemaker and my daughter is a fashion designer.',
            style: AppTextStyles.secondrySpanTextStyle
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Center(
              child: Text(
            'Profile verification score - 3/5',
            style: AppTextStyles.headingTextstyle.copyWith(fontSize: 20),
          )),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              // Define the lists for the status labels, icon names, and SVG names.
              final verificationStatus = [
                'Mobile Verified',
                'Govt. ID Verified',
                'Photo Verified',
                'Education Verified',
                'Income Verified'
              ];

              final verificationStatusNot = [
                'Mobile Not Verified',
                'Govt. ID Not Verified',
                'Photo Not Verified',
                'Education Not Verified',
                'Income Not Verified'
              ];

              final svgNames = [
                'mynaui_mobile',
                'govrn_id',
                'user_alt',
                'mdi_account-graduation',
                'income_verify',
              ];

              final iconForStatus = [
                'Done_intrest',
                'Close_round',
              ];

              final isVerified = [true, true, false, true, false];

              return Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main icon container
                      Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red, // Adjust color as needed
                        ),
                        child: CustomSvg(
                          name: svgNames[index], // Dynamically pass the name
                          color: Colors.white,
                        ),
                      ),
                      // Positioned status indicator
                      Positioned(
                        bottom: -5,
                        right: -5,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isVerified[index]
                                ? Colors.green
                                : AppColors.primaryButtonColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomSvg(
                            name: isVerified[index]
                                ? iconForStatus[0]
                                : iconForStatus[1], // Conditionally select icon
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Status Text
                  Text(
                    isVerified[index]
                        ? verificationStatus[index]
                        : verificationStatusNot[index],
                    style: AppTextStyles.spanTextStyle.copyWith(
                      color: const Color(0XFF5F5B5B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          )
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
            Container(
              margin: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    // decoration:  BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(color: AppColors.spanTextColor),
                    //     borderRadius: BorderRadius.circular(8)
                    // ),
                    child: const Row(
                      children: [
                        CustomSvg(name: 'blue_verify'),
                        Text('verified')
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      const phoneNumber = '6383266214';
                      const whatsappUrl = 'https://wa.me/$phoneNumber';

                      if (await canLaunch(whatsappUrl)) {
                        await launch(whatsappUrl);
                      } else {
                        print('Could not launch WhatsApp');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.spanTextColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Row(
                          children: [
                            const CustomSvg(name: 'whatsapp_icon'),
                            Text(
                              'whatsapp',
                              style: AppTextStyles.spanTextStyle
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      const phoneNumber = 'tel:+6383266214';
                      if (await canLaunch(phoneNumber)) {
                        await launch(phoneNumber);
                      } else {
                        print('Could not launch phone call');
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.spanTextColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const CustomSvg(name: 'call_now'),
                            Text('Call Now',
                                style: AppTextStyles.spanTextStyle
                                    .copyWith(color: Colors.black))
                          ],
                        )),
                  )
                ],
              ),
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
                style: AppTextStyles.headingTextstyle.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 2),
                blurRadius: 11.1,
                spreadRadius: 0,
                color:
                    Color(0x0D000000), // Converting #0000000D to Flutter format
              ),
            ],
          ),
          child: Column(
            children: [...children],
          ),
        )

        // const Divider(height: 1),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, String icon) {
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
                  style: AppTextStyles.primarybuttonText
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.spanTextStyle,
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            "Gowtham's Partner Preferences",
            style: AppTextStyles.headingTextstyle.copyWith(fontSize: 20),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xffFBE8E8), // Set background color
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
              _buildCircleAvatar('assets/image/user1.png'),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "You Match",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: "19/19",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: AppColors.headingTextColor),
                        ),
                      ])),
                      Text(
                        "Of His Preferences",
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              _buildCircleAvatar('assets/image/user2.png'),
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
        Row(
          children: [
            Expanded(
              child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      left: 24, right: 8, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.spanTextColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomSvg(name: 'Close_round'),
                      Text(
                        'don’t show',
                        style: AppTextStyles.primarybuttonText
                            .copyWith(color: AppColors.spanTextColor),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      left: 8, right: 24, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      border: Border.all(color: AppColors.spanTextColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSvg(name: 'Done_intrest'),
                        Text('send interest',
                            style: AppTextStyles.primarybuttonText),
                      ],
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCircleAvatar(String url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2), // Red border
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[200],
        backgroundImage: AssetImage(url),
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
            style: AppTextStyles.secondrySpanTextStyle
                .copyWith(color: Colors.black),
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
