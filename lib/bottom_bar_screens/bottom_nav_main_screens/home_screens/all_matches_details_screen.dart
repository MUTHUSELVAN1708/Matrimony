import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/models/partner_details_model.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

class AllMatchesDetailsScreen extends ConsumerStatefulWidget {
  final UserPartnerData userPartnerData;

  const AllMatchesDetailsScreen({super.key, required this.userPartnerData});

  @override
  ConsumerState<AllMatchesDetailsScreen> createState() =>
      _AllMatchesDetailsScreenState();
}

class _AllMatchesDetailsScreenState
    extends ConsumerState<AllMatchesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final userDetails = widget.userPartnerData.userDetails;
    final partnerDetails = widget.userPartnerData.partnerDetails;
    final allMatchProvider = ref.watch(allMatchesProvider);
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
        title: Text('All Matches 1/${allMatchProvider.allMatchList?.length}',
            style: AppTextStyles.headingTextstyle),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(context, userDetails ?? const UserDetails(),
                  partnerDetails ?? const PartnerDetailsModel()),
              _buildProfileDetails(userDetails ?? const UserDetails(),
                  partnerDetails ?? const PartnerDetailsModel()),
              _buildPreferenceDetails(userDetails ?? const UserDetails(),
                  partnerDetails ?? const PartnerDetailsModel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserDetails userDetails,
      PartnerDetailsModel partnerDetails) {
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
                  decoration: BoxDecoration(
                    image: userDetails.images != null &&
                            userDetails.images!.isNotEmpty
                        ? DecorationImage(
                            image: MemoryImage(
                              base64Decode(userDetails.images![0]),
                            ),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/image/emptyProfile.png'),
                            fit: BoxFit.cover,
                          ),
                  ),
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
                          onTap: () {
                            const MoreDetailsView();
                          },
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
                  userDetails.name ?? '-',
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  '${userDetails.uniqueId ?? '-'} | Last seen few hours ago',
                  style: AppTextStyles.secondrySpanTextStyle,
                ),
                const SizedBox(height: 10),
                _buildBasicDetails(
                    '${userDetails.age ?? '-'} Yrs, ${userDetails.height ?? '-'}',
                    'profileIcon'),
                const SizedBox(height: 8),
                _buildBasicDetails(
                    userDetails.employedType ?? '-', 'building_icon'),
                const SizedBox(height: 8),
                _buildBasicDetails(
                    '${userDetails.education ?? '-'}, ${userDetails.occupation ?? '-'}',
                    'professional_icon'),
                const SizedBox(height: 8),
                _buildBasicDetails(
                    '${userDetails.state ?? '-'}, ${userDetails.city ?? '-'}',
                    'location_icon'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'About ${userDetails.name ?? '-'}',
            style: AppTextStyles.spanTextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            userDetails.aboutYourSelf ?? '-',
            style: AppTextStyles.secondrySpanTextStyle
                .copyWith(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 14),
          Text(
            'About ${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Family',
            style: AppTextStyles.spanTextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 8),
          if (userDetails.fatherOccupation != null &&
              userDetails.motherOccupation != null) ...[
            Text(
              'Fathers Occupation is ${userDetails.fatherOccupation!.isEmpty ? '-' : userDetails.fatherOccupation} and Mothers Occupation is ${userDetails.motherOccupation!.isEmpty ? '-' : userDetails.motherOccupation}.',
              style: AppTextStyles.secondrySpanTextStyle
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
          ] else ...[
            Text(
              '-',
              style: AppTextStyles.secondrySpanTextStyle
                  .copyWith(color: Colors.black, fontSize: 16),
            )
          ],
          const SizedBox(height: 15),
          Center(
              child: Text(
            'Profile Verification Score - ${calculateVerificationScore(userDetails)}/5',
            style: AppTextStyles.headingTextstyle.copyWith(fontSize: 20),
          )),
          const SizedBox(height: 20),
          StatusRowWidget(
            userDetails: userDetails,
          )
        ],
      ),
    );
  }

  Widget _buildProfileDetails(
      UserDetails userDetails, PartnerDetailsModel partnerDetailsModel) {
    return Column(
      children: [
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Basic Details',
            [
              _buildDetailItem(
                  'Age', '${userDetails.age ?? '-'} Years', 'user_alt'),
              _buildDetailItem(
                  'Physique',
                  "${userDetails.weight ?? '-Kg'} | "
                      "${userDetails.height ?? '-'} | "
                      "${userDetails.physicalStatus ?? '-'}",
                  'height'),
              _buildDetailItem(
                  'Spoken Languages',
                  '${userDetails.motherTongue ?? '-'} (Mother Tongue)',
                  'language'),
              _buildDetailItem(
                  'Eating Habits', userDetails.eatingHabits ?? '-', 'chef_hat'),
              _buildDetailItem('Profile Created For',
                  userDetails.profileFor ?? '-', 'user-edit'),
              _buildDetailItem('Marital Status',
                  userDetails.maritalStatus ?? '-', 'wedding_ring'),
              _buildDetailItem(
                  'Lives In',
                  '${userDetails.city ?? '-'}, ${userDetails.state ?? '-'}',
                  'location_icon'),
              _buildDetailItem(
                  'Own House', userDetails.ownHouse ?? '-', 'location_icon'),
              _buildDetailItem(
                  'Citizenship', userDetails.citizenShip ?? '-', 'flag'),
              _buildDetailItem('Smoking Habits',
                  userDetails.smokingHabits ?? '-', 'smoking'),
              _buildDetailItem('Drinking Habits',
                  userDetails.drinkingHabits ?? '-', 'wine_glass'),
            ]),
        _buildSection('contact number', [
          _buildDetailItem('Mobile Number', userDetails.phoneNumber ?? '-',
              'Phone _Calling_icon'),
          _buildDetailItem(
              'Whom To Contact', userDetails.whomToContact ?? '-', 'user_alt'),
          _buildDetailItem('Contact Person\'s Name',
              userDetails.contactPersonName ?? '-', 'user_alt'),
          _buildDetailItem('Available Time To Call',
              userDetails.availableTimeToCall ?? '-', 'availabletime'),
          _buildDetailItem('Comments', userDetails.comments ?? '-', 'comments'),
          ...[
            Container(
              margin: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: const Row(
                      children: [
                        CustomSvg(name: 'blue_verify'),
                        SizedBox(
                          width: 4,
                        ),
                        Text('verified')
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final phoneNumber = userDetails.phoneNumber ?? '';
                      final whatsappUrl = 'https://wa.me/$phoneNumber';

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
                            const CustomSvg(name: 'whatsapp-icon'),
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
                      final phoneNumber =
                          'tel:${userDetails.phoneNumber ?? '-'}';
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
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Religious Details',
            [
              _buildDetailItem(
                  'Religion', userDetails.religion ?? '-', 'kumbudu'),
              _buildDetailItem('Caste', userDetails.caste ?? '-', 'notes'),
              _buildDetailItem(
                  'Sub caste', userDetails.subcaste ?? '-', 'notes'),
              // _buildDetailItem('Gothra(M)', 'Not Specified', 'people'),
            ]),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Horoscope Details',
            [
              _buildDetailItem(
                  'Date Of Birth',
                  userDetails.dateOfBirth != null &&
                          DateTime.tryParse(userDetails.dateOfBirth!) != null
                      ? DateFormat('dd-MM-yyyy')
                          .format(DateTime.tryParse(userDetails.dateOfBirth!)!)
                      : '-',
                  'calendar_date'),
              _buildDetailItem('Time Of Birth', userDetails.timeOfBirth ?? '-',
                  'calendar_date'),
              _buildDetailItem(
                  'Star/Rassi',
                  'Star is ${userDetails.star ?? '-'}\nRaasi is ${userDetails.raasi ?? '-'}',
                  'astronomy'),
            ]),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Professional Details',
            [
              _buildDetailItem('Employment', userDetails.employedType ?? '-',
                  'card_profile'),
              _buildDetailItem('Annual Income', userDetails.annualIncome ?? '-',
                  'money_bag'),
              _buildDetailItem('Education', userDetails.education ?? '-',
                  'professional_icon'),
              _buildDetailItem('Occupation', userDetails.occupation ?? '-',
                  'professional_icon'),
            ]),
        _buildSection(
            'About ${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Family',
            [
              _buildDetailItem(
                  'Family Type', userDetails.famliyType ?? '-', 'family_type'),
              _buildDetailItem('Family Status', userDetails.famliyStatus ?? '-',
                  'family_type'),
              _buildDetailItem(
                  'Parents',
                  '${userDetails.fatherName ?? ''}${userDetails.fatherName != null ? ', ' : ''}${userDetails.motherName ?? '-'}',
                  '2person'),
              _buildDetailItem(
                  'Sisters',
                  '${userDetails.noOfSisters ?? '-'} ${userDetails.noOfSisters != null ? 'Sister' : ''}',
                  'profileIcon'),
              _buildDetailItem(
                  'Brothers',
                  '${userDetails.noOfBrothers ?? '-'} ${userDetails.noOfBrothers != null ? 'Brother' : ''}',
                  'profileIcon'),
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
          CustomSvg(
            name: (icon.isEmpty) ? 'blue_verify' : icon,
            color: (icon.isEmpty) ? const Color(0xFF49A398) : null,
          )
// Space between text and icon
          // const Icon(
          //   Icons.verified,
          //   color: Colors.green,
          // ),
        ],
      ),
    );
  }

  Widget _buildPreferenceDetails(
      UserDetails userDetails, PartnerDetailsModel partnerDetailsModel) {
    final allMatchProvider = ref.watch(allMatchesProvider);
    final myProfile = ref.watch(getImageApiProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            "${userDetails.name ?? '-'}'s Partner Preferences",
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
              _buildCircleAvatar(myProfile.data?.images.firstOrNull),
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
                          text: "1/${allMatchProvider.allMatchList?.length}",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: AppColors.headingTextColor),
                        ),
                      ])),
                      Text(
                        "Of ${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Preferences",
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              _buildCircleAvatar(userDetails.images?.firstOrNull),
            ],
          ),
        ),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Basic Preferences',
            [
              _buildDetailItem(
                  'Age',
                  '${partnerDetailsModel.partnerFromAge ?? ''} - ${partnerDetailsModel.partnerToAge ?? ''} Years',
                  ''),
              _buildDetailItem(
                  'Height',
                  "${partnerDetailsModel.partnerFromHeight ?? ''} - ${partnerDetailsModel.partnerToHeight ?? ''}",
                  ''),
              _buildDetailItem(
                  'Weight',
                  "${partnerDetailsModel.partnerFromWeight ?? ''} - ${partnerDetailsModel.partnerToWeight ?? ''}",
                  ''),
              _buildDetailItem('Marital Status',
                  partnerDetailsModel.partnerMaritalStatus ?? '-', ''),
              _buildDetailItem('Physical Status',
                  partnerDetailsModel.partnerPhysicalStatus ?? '-', ''),
            ]),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Religious Preferences',
            [
              _buildDetailItem('Preferred Religion',
                  partnerDetailsModel.partnerReligion ?? '-', ''),
              _buildDetailItem('Preferred Caste',
                  partnerDetailsModel.partnerCaste ?? '-', ''),
              _buildDetailItem(
                  'Preferred Star', partnerDetailsModel.partnerStar ?? '-', ''),
              _buildDetailItem('Preferred Raasi',
                  partnerDetailsModel.partnerRassi ?? '-', ''),
            ]),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Professional Preferences',
            [
              _buildDetailItem('Preferred education',
                  partnerDetailsModel.partnerEducation ?? '-', ''),
              _buildDetailItem('Preferred Employment Type',
                  partnerDetailsModel.partnerEmployedIn ?? '-', ''),
              _buildDetailItem('Preferred Occupation',
                  partnerDetailsModel.partnerOccupation ?? '-', ''),
              _buildDetailItem('Preferred Annual Income',
                  partnerDetailsModel.partnerAnnualIncome ?? '-', ''),
            ]),
        _buildSection(
            '${userDetails.gender != null ? userDetails.gender == 'Male' ? 'His' : 'Her' : '-'} Location Preferences',
            [
              _buildDetailItem('Preferred Country',
                  partnerDetailsModel.partnerCountry ?? '-', ''),
              _buildDetailItem('Preferred Residing State',
                  partnerDetailsModel.partnerState ?? '-', ''),
              _buildDetailItem('Preferred Residing City',
                  partnerDetailsModel.partnerCity ?? '-', ''),
              _buildDetailItem('Preferred Own House',
                  partnerDetailsModel.partnerOwnHouse ?? '-', ''),
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

  Widget _buildCircleAvatar(String? url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2), // Red border
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[200],
        backgroundImage: url != null && url.isNotEmpty
            ? MemoryImage(
                base64Decode(url),
              )
            : const AssetImage(
                'assets/image/emptyprofile.png',
              ) as ImageProvider,
      ),
    );
  }

  Widget _buildBasicDetails(String label, String icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label == '' ? '-' : label,
            style: AppTextStyles.secondrySpanTextStyle
                .copyWith(color: Colors.black, fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        CustomSvg(
          name: icon,
        ),
      ],
    );
  }

  int calculateVerificationScore(UserDetails userDetails) {
    int score = 0;

    if (userDetails.photoStatus == true) score++;
    if (userDetails.pnoStatus == true) score++;
    if (userDetails.govtIdProofStatus == true) score++;
    if (userDetails.educationStatus == true) score++;
    if (userDetails.incomeStatus == true) score++;

    return score;
  }
}

class StatusRowWidget extends StatelessWidget {
  final UserDetails userDetails;

  const StatusRowWidget({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
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

    final isVerified = [
      userDetails.pnoStatus ?? false,
      userDetails.govtIdProofStatus ?? false,
      userDetails.photoStatus ?? false,
      userDetails.educationStatus ?? false,
      userDetails.incomeStatus ?? false
    ];

    double iconSize = MediaQuery.of(context).size.width * 0.12;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Flexible(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: iconSize,
                    width: iconSize,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: svgNames[index] == 'govrn_id'
                          ? Colors.blueAccent
                          : Colors.red, // Adjust color as needed
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
                            ? const Color(0xFF28EB9D)
                            : AppColors.primaryButtonColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomSvg(
                        name: isVerified[index]
                            ? iconForStatus[0]
                            : iconForStatus[1], // Conditionally select icon
                        color: Colors.white,
                        height: 15,
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
          ),
        );
      }),
    );
  }
}

class MoreDetailsView extends StatelessWidget {
  const MoreDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) {
        // Handle menu item selection
        switch (value) {
          case 'share':
            break;
          case 'shortlist':
            break;
          case 'dontShow':
            break;
          case 'block':
            break;
          case 'report':
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'share',
          child: Text('Share Profile'),
        ),
        const PopupMenuItem<String>(
          value: 'shortlist',
          child: Text('Shortlist'),
        ),
        const PopupMenuItem<String>(
          value: 'dontShow',
          child: Text("Don't Show"),
        ),
        const PopupMenuItem<String>(
          value: 'block',
          child: Text('Block'),
        ),
        const PopupMenuItem<String>(
          value: 'report',
          child: Text('Report Profile'),
        ),
      ],
    );
  }
}

// Example usage in another widget:
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [
          MoreDetailsView(),
        ],
      ),
      body: const Center(
        child: Text('Profile Content'),
      ),
    );
  }
}
