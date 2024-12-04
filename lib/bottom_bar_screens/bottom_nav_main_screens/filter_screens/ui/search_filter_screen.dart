import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_state.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/ui/search_profile_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';

import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/prefarence_height_comment_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/preference_age_dialogBox.dart';

import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/riverpod/religious_api_notifier.dart';

import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';

class PartnerSearchScreen extends ConsumerStatefulWidget {
  const PartnerSearchScreen({super.key});

  @override
  ConsumerState<PartnerSearchScreen> createState() =>
      _PartnerSearchScreenState();
}

class _PartnerSearchScreenState extends ConsumerState<PartnerSearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(searchFilterInputProvider.notifier).setSearchFilterInput(
        ref.read(userManagementProvider).userPartnerDetails);
    await ref.read(locationProvider.notifier).getCountryDetails(
        ref.read(userManagementProvider).userPartnerDetails.partnerCountry ??
            '',
        ref.read(userManagementProvider).userPartnerDetails.partnerState ?? '');
    await ref.read(religiousProvider.notifier).getReligiousDetails(
        ref.read(userManagementProvider).userPartnerDetails.partnerReligion,
        ref.read(userManagementProvider).userPartnerDetails.partnerCaste);
    // ref.read(religiousProvider.notifier).getReligiousData();
  }

  @override
  Widget build(BuildContext context) {
    final searchInput = ref.watch(searchFilterInputProvider);
    final religionState = ref.watch(religiousProvider);
    final countryState = ref.watch(locationProvider);
    final searchFilterState = ref.watch(searchFilterProvider);
    return EnhancedLoadingWrapper(
      isLoading: religionState.isLoading || searchFilterState.isLoading,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Search",
                        style: AppTextStyles.headingTextstyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Search Profile Using The Below Criteria',
                        style: AppTextStyles.spanTextStyle,
                      ),
                      const SizedBox(height: 16),

                      // Basic Details Section
                      _buildExpandableSection(
                        title: 'Basic Details',
                        icon: SvgPicture.asset('assets/image/basic_filter.svg'),
                        children: [
                          _buildListTile(
                            'Age',
                            '${searchInput?.fromAge == 0 ? '-' : searchInput?.fromAge} yrs - ${searchInput?.toAge == 0 ? '-' : searchInput?.toAge} yrs',
                            onTap: () => showAgeSelectionDialog(
                                context,
                                'Age',
                                'From Age',
                                'To Age',
                                PartnerPreferenceConstData.toAgeList,
                                true),
                          ),
                          _buildListTile(
                            'Height',
                            "${searchInput?.fromHeight} - ${searchInput?.toHeight}",
                            onTap: () => showHeightSelectionDialog(
                                context,
                                true,
                                'Height',
                                'From Height',
                                'To Height',
                                PartnerPreferenceConstData
                                    .myHeightOptions.values
                                    .toList(),
                                searchInput?.fromHeight ?? '',
                                searchInput?.toHeight ?? ''),
                          ),
                          // InkWell(
                          //     onTap: () {
                          //       showSelectionHabitsDialog(
                          //           context,
                          //           'Profile created by',
                          //           [
                          //             'MySelf',
                          //             'Son',
                          //             'Daughter',
                          //             'Sister',
                          //             'Relative',
                          //             'Friend',
                          //             'Other'
                          //           ],
                          //           searchInput?.profileCreatedBy ?? '');
                          //     },
                          //     child: _buildListTile('Profile created by',
                          //         "${searchInput?.profileCreatedBy}")),
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'Marital Status',
                                    PartnerPreferenceConstData
                                        .maritalStatusOptionsForSearch,
                                    searchInput?.maritalStatus ?? '');
                              },
                              child: _buildListTile('Marital Status',
                                  '${searchInput?.maritalStatus}')),
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'Mother Tongue',
                                    PartnerPreferenceConstData
                                        .motherTongueOptionsUser,
                                    searchInput?.motherTongue ?? '');
                              },
                              child: _buildListTile('Mother Tongue',
                                  '${searchInput?.motherTongue}')),
                          InkWell(
                              onTap: () {
                                showSelectionHabitsDialog(
                                    context,
                                    'Physical Status',
                                    PartnerPreferenceConstData
                                        .physicalStatusOptions,
                                    searchInput?.physicalStatus ?? '');
                              },
                              child: _buildListTile('Physical Status',
                                  '${searchInput?.physicalStatus}')),
                        ],
                      ),

                      _buildExpandableSection(
                        title: 'Religious Information',
                        icon: SvgPicture.asset('assets/image/basic_filter.svg'),
                        children: [
                          _buildListTile('Religion', '${searchInput?.religion}',
                              onTap: () async {
                            showLocationSelectionDialog(
                                context,
                                'Religion',
                                religionState.data
                                    .map((subCasteModel) =>
                                        subCasteModel.religion)
                                    .toList(),
                                searchInput!.religion.toString());
                          }),
                          _buildListTile('Caste', '${searchInput?.caste}',
                              onTap: () async {
                            showLocationSelectionDialog(
                                context,
                                'Caste',
                                religionState.casteList
                                    .map((subCasteModel) => subCasteModel.caste)
                                    .toList(),
                                searchInput!.caste.toString());
                          }),
                          _buildListTile(
                              'Sub Caste', '${searchInput?.subcaste}',
                              onTap: () {
                            showLocationSelectionDialog(
                                context,
                                'Sub Caste',
                                religionState.subCasteList
                                    .map((subCasteModel) =>
                                        subCasteModel.subCaste)
                                    .toList(),
                                searchInput!.subcaste.toString());
                          }),
                        ],
                      ),

                      // Professional Information Section
                      _buildExpandableSection(
                        title: 'Professional Information',
                        icon: SvgPicture.asset(
                            'assets/image/filter_religion.svg'),
                        children: [
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'Occupation',
                                    PartnerPreferenceConstData.occupationList,
                                    searchInput?.profession ?? '');
                              },
                              child: _buildListTile(
                                  'Occupation', '${searchInput?.profession}')),
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'annual income',
                                    PartnerPreferenceConstData.incomeList,
                                    searchInput?.annualIncome ?? '');
                              },
                              child: _buildListTile('annual income',
                                  '${searchInput?.annualIncome}')),
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'employment type',
                                    PartnerPreferenceConstData.employedInList,
                                    searchInput?.employedIn ?? '');
                              },
                              child: _buildListTile('employment type',
                                  '${searchInput?.employedIn}')),
                          InkWell(
                              onTap: () {
                                showAnySelectionDialog(
                                    context,
                                    'Education',
                                    PartnerPreferenceConstData.educationList,
                                    searchInput?.education ?? '');
                              },
                              child: _buildListTile(
                                  'Education', '${searchInput?.education}')),
                        ],
                      ),

                      _buildExpandableSection(
                        title: 'Location',
                        icon: SvgPicture.asset(
                            'assets/image/filter_location.svg'),
                        children: [
                          _buildListTile('Country', '${searchInput?.country}',
                              onTap: () async {
                            showLocationSelectionDialog(
                                context,
                                'Country',
                                countryState.countryList
                                    .map((e) => e.countrys)
                                    .toList(),
                                searchInput!.country.toString());
                          }),
                          _buildListTile('State', '${searchInput?.states}',
                              onTap: () async {
                            showLocationSelectionDialog(
                                context,
                                'State',
                                countryState.stateList
                                    .map((e) => e.states)
                                    .toList(),
                                searchInput!.states.toString());
                          }),
                          _buildListTile('City', '${searchInput?.city}',
                              onTap: () {
                            showLocationSelectionDialog(
                                context,
                                'City',
                                countryState.cityList
                                    .map((e) => e.citys)
                                    .toList(),
                                searchInput!.city.toString());
                          }),
                          // _buildListTile('citizenship', 'Any'),
                        ],
                      ),

                      _buildExpandableSection(
                        title: 'Hobbies & Lifestyle',
                        icon:
                            SvgPicture.asset('assets/image/filter_hobbie.svg'),
                        children: [
                          InkWell(
                            onTap: () {
                              showSelectionHabitsDialog(
                                  context,
                                  'eating habits',
                                  PartnerPreferenceConstData
                                      .eatingHabitsOptions,
                                  searchInput?.eatingHabits ?? '');
                            },
                            child: _buildListTile(
                              'eating habits',
                              '${searchInput?.eatingHabits}',
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showSelectionHabitsDialog(
                                    context,
                                    'smoking habits',
                                    PartnerPreferenceConstData
                                        .smokingHabitsOptions,
                                    searchInput?.smokingHabits ?? '');
                              },
                              child: _buildListTile('smoking habits',
                                  '${searchInput?.smokingHabits}')),
                          InkWell(
                            onTap: () async {
                              showSelectionHabitsDialog(
                                  context,
                                  'drinking habits',
                                  PartnerPreferenceConstData
                                      .drinkingHabitsOptions,
                                  searchInput?.drinkingHabits ?? '');
                            },
                            child: _buildListTile(
                              'drinking habits',
                              '${searchInput?.drinkingHabits}',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Container(
                      //   width: double.infinity,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     gradient: const LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [
                      //         Color(0xFFFFF4F4), // #FFF4F4 color
                      //         Color(0xFFFDFDFD), // #FDFDFD color
                      //       ],
                      //     ),
                      //   ),
                      //   child: const Center(
                      //     child: Text(
                      //       'Recently Created Profiles',
                      //       style: AppTextStyles.headingTextstyle,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Profile Created',
                      //     style: AppTextStyles.spanTextStyle
                      //         .copyWith(color: Colors.black),
                      //   ),
                      // ),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('Profiles Based On Created Date',
                      //         style: AppTextStyles.spanTextStyle
                      //             .copyWith(color: Colors.black))),
                      // const SizedBox(height: 15),
                      //
                      // Wrap(
                      //   alignment: WrapAlignment.center,
                      //   spacing: 15, // Horizontal space between the chips
                      //   runSpacing: 8, // Vertical space between rows of chips
                      //   children: timeFilters.map((filter) {
                      //     bool isSelected = _selectedTimeFilter == filter;
                      //
                      //     return GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedTimeFilter =
                      //               filter; // Toggle selected filter
                      //         });
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 16.0,
                      //             vertical: 8.0), // Padding inside the container
                      //         decoration: BoxDecoration(
                      //           color: isSelected
                      //               ? Colors.red
                      //               : Colors
                      //                   .white, // Red background when selected, white when unselected
                      //           border: Border.all(
                      //             color:
                      //                 Colors.grey, // Grey border when unselected
                      //             width: 1.0, // Border width
                      //           ),
                      //           borderRadius: BorderRadius.circular(
                      //               20), // Border radius of 20
                      //         ),
                      //         child: Text(
                      //           filter,
                      //           style: TextStyle(
                      //             fontFamily:
                      //                 'Helvetica', // Set font-family to Helvetica
                      //             fontSize: 12, // Font size
                      //             fontWeight: FontWeight.w400, // Font weight
                      //             height: 13.8 /
                      //                 12, // Line height (line-height / font-size)
                      //             color: isSelected
                      //                 ? Colors.white
                      //                 : Colors.black, // Center align the text
                      //             decoration:
                      //                 TextDecoration.none, // No text decoration
                      //             decorationStyle: TextDecorationStyle
                      //                 .solid, // No text decoration (for clarity)
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      //
                      // const SizedBox(height: 24),

                      // Profile Type Section
                      // Container(
                      //   width: double.infinity,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     gradient: const LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [
                      //         Color(0xFFFFF4F4), // #FFF4F4 color
                      //         Color(0xFFFDFDFD), // #FDFDFD color
                      //       ],
                      //     ),
                      //   ),
                      //   child: const Center(
                      //     child: Text(
                      //       'Profile Type',
                      //       style: AppTextStyles.headingTextstyle,
                      //     ),
                      //   ),
                      // ),
                      //
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      //
                      // Container(
                      //   width: double.infinity, // Set the height of the container
                      //   padding: const EdgeInsets.fromLTRB(
                      //       20, 7, 22, 7), // Set the padding for the container
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.white, // Set the background color
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black
                      //             .withOpacity(0.08), // Shadow color with opacity
                      //         offset: const Offset(
                      //             1, 2), // Shadow offset (horizontal, vertical)
                      //         blurRadius: 11.1, // Blur radius of the shadow
                      //       ),
                      //     ],
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment
                      //         .spaceBetween, // Distribute the children evenly
                      //     children: [
                      //       // The text part
                      //       const Expanded(
                      //         child: Text.rich(
                      //           TextSpan(
                      //             children: [
                      //               TextSpan(
                      //                 text: 'Profiles with photo ',
                      //                 style: TextStyle(
                      //                   fontFamily: 'Source Sans Pro',
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.w400,
                      //                 ),
                      //               ),
                      //               TextSpan(
                      //                 text: 'Matches who have added photos',
                      //                 style: TextStyle(
                      //                   fontFamily: 'Source Sans Pro',
                      //                   color: Color(
                      //                       0xFF514D4D), // Correct color code
                      //                   fontWeight: FontWeight.w400,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           maxLines: 3,
                      //           overflow: TextOverflow
                      //               .ellipsis, // To prevent text from overflowing
                      //         ),
                      //       ),
                      //
                      //       // The checkbox part
                      //       Checkbox(
                      //         value: _showProfilesWithPhoto,
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             _showProfilesWithPhoto = value ?? false;
                      //           });
                      //         },
                      //         activeColor: Colors
                      //             .green, // Checkbox will be green when checked
                      //         checkColor: Colors.white, // White check mark
                      //         side: const BorderSide(
                      //           color: Colors.red,
                      //           width: 2.0, // Border width
                      //         ),
                      //         materialTapTargetSize: MaterialTapTargetSize
                      //             .shrinkWrap, // Shrink the tap area for a compact look
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.0),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      //
                      // SizedBox(
                      //   height: 10,
                      // ),
                      //
                      // Container(
                      //   height: 50,
                      //   width: double.infinity, // Set the height of the container
                      //   alignment: Alignment.center,
                      //   padding: EdgeInsets.only(
                      //       left: 10,
                      //       right: 10), // Set the padding for the container
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.white, // Set the background color
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black
                      //             .withOpacity(0.08), // Shadow color with opacity
                      //         offset: const Offset(
                      //             1, 2), // Shadow offset (horizontal, vertical)
                      //         blurRadius: 11.1, // Blur radius of the shadow
                      //       ),
                      //     ],
                      //   ),
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Don't Show Profiles",
                      //         style: TextStyle(
                      //             fontFamily: 'Source Sans Pro',
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             "Ignored, Shortlisted",
                      //             style: TextStyle(
                      //                 fontFamily: 'Source Sans Pro',
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w700),
                      //           ),
                      //           Icon(Icons.chevron_right)
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // const SizedBox(height: 16),

                      // Matches Count
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: searchFilterState.searchModels.length
                      //             .toString(),
                      //         style: const TextStyle(
                      //             fontFamily: 'Source Sans Pro',
                      //             fontSize: 16,
                      //             color: AppColors.headingTextColor,
                      //             fontWeight:
                      //                 FontWeight.w700), // red color for 634
                      //       ),
                      //       const TextSpan(
                      //         text: ' Search Results Based On Your Inputs',
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             fontFamily: 'Source Sans Pro',
                      //             color: Colors.black,
                      //             fontWeight: FontWeight
                      //                 .w700), // black color for the rest
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 60),

                      // Search Button
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await ref
                            .read(searchFilterProvider.notifier)
                            .searchResults(searchInput!);
                        if (result) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchProfileScreen()));
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message:
                                  'Something Went Wrong. Please Search Again!',
                              isError: true);
                        }
                      },
                      style: AppTextStyles.primaryButtonstyle,
                      child: const Text(
                        'Search',
                        style: AppTextStyles.primarybuttonText,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, {VoidCallback? onTap}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      // Margin of 10
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Inner background color white
          borderRadius: BorderRadius.circular(20), // Border radius of 20
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.08), // Shadow color (rgba equivalent)
              offset: const Offset(0,
                  3), // Shadow offset only on the bottom (no horizontal offset)
              blurRadius: 5, // Blur radius for the shadow effect
              spreadRadius: 0, // No spread for the shadow
            ),
          ],
          border: const Border(
            bottom:
                BorderSide(color: Color(0xFFF1F1F1), width: 1), // Bottom border
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: AppTextStyles.spanTextStyle
                .copyWith(color: const Color(0xFF272727)),
          ),
          subtitle: subtitle.isEmpty
              ? const SizedBox()
              : Text(
                  subtitle,
                  style: AppTextStyles.spanTextStyle
                      .copyWith(color: const Color(0xFF898989)),
                ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required SvgPicture icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 5), // Apply margin to give the gap of 10px
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        width: double.infinity, // Set width to take up full width
        decoration: BoxDecoration(
          color: Colors.white, // Background color white
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.08), // Shadow color (rgba equivalent)
              offset: const Offset(1, 2), // Shadow offset (1px 2px)
              blurRadius: 11.1, // Blur radius (11.1px)
              spreadRadius: 0, // No spread
            ),
          ],
        ),
        child: ExpansionTile(
          leading: icon,
          title: Text(
            title,
            style: AppTextStyles.spanTextStyle
                .copyWith(color: const Color(0xFF717171)),
          ),
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          tilePadding: EdgeInsets.zero,
          shape: Border.all(color: Colors.transparent),
          children: children,
        ),
      ),
    );
  }

  void showSelectionHabitsDialog(
      BuildContext context, String hint, List<String> items, String value) {
    String? tempSelectedValue = value;
    final otherController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select $hint',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              tempSelectedValue == 'Other' ? 1 : items.length,
                          itemBuilder: (context, index) {
                            String currentItem = items[index];
                            bool isSelected = tempSelectedValue == currentItem;

                            return tempSelectedValue == 'Other'
                                ? TextFormField(
                                    controller: otherController,
                                    onChanged: (value) {
                                      tempSelectedValue = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter Other',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 15.0),
                                    ),
                                  )
                                : ListTile(
                                    leading: Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.circle_outlined,
                                      color: isSelected
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    title: Text(
                                      currentItem,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.red
                                            : Colors.black,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        tempSelectedValue = currentItem;
                                      });
                                    },
                                  );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (tempSelectedValue != null) {
                                if (hint == 'smoking habits') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputHabitsValues('smokingHabits',
                                          [tempSelectedValue!]);
                                } else if (hint == 'drinking habits') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputHabitsValues('drinkingHabits',
                                          [tempSelectedValue!]);
                                } else if (hint == 'eating habits') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputHabitsValues(
                                          'eatingHabits', [tempSelectedValue!]);
                                } else if (hint == 'Physical Status') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputHabitsValues('physicalStatus',
                                          [tempSelectedValue!]);
                                } else if (hint == 'Profile created by') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputHabitsValues('Profilecreated',
                                          [tempSelectedValue!]);
                                }
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showAnySelectionDialog(
      BuildContext context, String hint, List<String> items, String value) {
    String selectedValues = value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select $hint',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            String currentItem;

                            if (index == 0) {
                              currentItem = 'Any';
                            } else {
                              currentItem = items[index - 1];
                            }

                            bool isSelected = selectedValues == currentItem;

                            return ListTile(
                              leading: isSelected
                                  ? const Icon(Icons.radio_button_checked,
                                      color: Colors.red)
                                  : const Icon(Icons.circle_outlined,
                                      color: Colors.black),
                              title: Text(
                                currentItem,
                                style: TextStyle(
                                  color: isSelected ? Colors.red : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (currentItem == 'Any') {
                                    selectedValues = 'Any';
                                  } else {
                                    selectedValues = currentItem;
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (hint == 'Mother Tongue') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'Mother Tongue', [selectedValues]);
                              } else if (hint == 'Marital Status') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'Marital Status', [selectedValues]);
                              } else if (hint == 'Physical Status') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'Physical Status', [selectedValues]);
                              } else if (hint == 'employment type') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'employment type', [selectedValues]);
                              } else if (hint == 'annual income') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'annual income', [selectedValues]);
                              } else if (hint == 'Education') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'Education', [selectedValues]);
                              } else if (hint == 'Occupation') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputAnyValues(
                                        'Occupation', [selectedValues]);
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showAgeSelectionDialog(BuildContext context, String hint, String hint1,
      String hint2, List<String> items, bool ageheight) {
    final value = ref.read(searchFilterInputProvider);
    List<String> fromItem =
        value?.fromAge != 0 ? [value?.fromAge.toString() ?? ''] : [];
    List<String> toItem =
        value?.toAge != 0 ? [value?.toAge.toString() ?? ''] : [];
    late List<String> selectedValues;
    bool isSelectAll = false;
    bool isSingleSelection = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height:
                      // widget.ageheight
                      //     ?
                      MediaQuery.of(context).size.height * 0.30,
                  // : MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Select $hint',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ageheight
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AgeCustomDialogBox(
                                      value: fromItem,
                                      hint: hint1 ?? '',
                                      items: items,
                                      onChanged: (data) {
                                        setState(() {
                                          fromItem = data;
                                          toItem.clear();
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    if (fromItem.isNotEmpty)
                                      AgeCustomDialogBox(
                                        value: toItem,
                                        hint: hint2 ?? '',
                                        items: items
                                            .where((item) =>
                                                int.parse(item) >
                                                int.parse(fromItem[0]))
                                            .toList(),
                                        onChanged: (data) {
                                          setState(() {
                                            toItem = data;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: (isSingleSelection
                                      ? items.length
                                      : items.length + 1),
                                  itemBuilder: (context, index) {
                                    if (!isSingleSelection && index == 0) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            isSelectAll = !isSelectAll;
                                            if (isSelectAll) {
                                              selectedValues = List.from(items);
                                            } else {
                                              selectedValues.clear();
                                            }
                                          });
                                        },
                                        leading: isSelectAll
                                            ? const Icon(
                                                Icons
                                                    .radio_button_checked_outlined,
                                                color: Colors.red,
                                              )
                                            : const Icon(Icons.circle_outlined),
                                        title: const Text("Select All"),
                                      );
                                    }
                                    final itemIndex =
                                        // isSingleSelection ? index :
                                        index - 1;
                                    final currentItem = items[itemIndex];
                                    //
                                    // if (isSingleSelection) {
                                    //   return RadioListTile<String>(
                                    //     title: Text(currentItem),
                                    //     value: currentItem,
                                    //     groupValue: selectedValues.isNotEmpty
                                    //         ? selectedValues.first
                                    //         : null,
                                    //     onChanged: (String? value) {
                                    //       setState(() {
                                    //         selectedValues =
                                    //         value != null ? [value] : [];
                                    //       });
                                    //     },
                                    //     activeColor: Colors.red,
                                    //   );
                                    // } else {
                                    return ListTile(
                                      leading: selectedValues
                                              .contains(currentItem)
                                          ? const Icon(
                                              Icons.radio_button_checked,
                                              color: Colors.red,
                                            )
                                          : const Icon(Icons.circle_outlined),
                                      title: Text(currentItem),
                                      onTap: () {
                                        setState(() {
                                          if (selectedValues
                                              .contains(currentItem)) {
                                            selectedValues.remove(currentItem);
                                            isSelectAll = false;
                                          } else {
                                            selectedValues.add(currentItem);
                                            if (selectedValues.length ==
                                                items.length) {
                                              isSelectAll = true;
                                            }
                                          }
                                        });
                                      },
                                    );
                                    // }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: fromItem.isNotEmpty && toItem.isEmpty
                            ? null
                            : () {
                                if (hint == 'Age') {
                                  ref
                                      .read(searchFilterInputProvider.notifier)
                                      .updateInputAgeValues(
                                          'fromAge', fromItem, toItem);
                                }
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          disabledIconColor:
                              fromItem.isNotEmpty && toItem.isEmpty
                                  ? Colors.grey
                                  : Colors.red,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            },
          ),
        );
      },
    );
  }

  void showHeightSelectionDialog(
      BuildContext context,
      bool ageHeight,
      String hint,
      String hint2,
      String hint3,
      List<String> items,
      String fromValue,
      String toValue) {
    late List<String> selectedValues;
    List<String> filteredItems = [];
    bool isSingleSelection = false;
    List<String> toItem = [toValue];
    List<String> fromItem = [fromValue];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool select = false;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height: ageHeight
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Select $hint',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ageHeight
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HeightDropdownField(
                                    value: fromItem,
                                    hint: hint2 ?? '',
                                    items: items,
                                    onChanged: (data) {
                                      setState(() {
                                        fromItem = data;
                                        toItem.clear();
                                        if (fromItem.isNotEmpty) {
                                          int fromIndex =
                                              items.indexOf(fromItem.first);
                                          filteredItems =
                                              items.sublist(fromIndex + 1);
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  fromItem.isEmpty
                                      ? const SizedBox()
                                      : HeightDropdownField(
                                          value: toItem.isEmpty ? [] : toItem,
                                          hint: hint3 ?? '',
                                          items: filteredItems,
                                          onChanged: (data) {
                                            setState(() {
                                              toItem = data;
                                            });
                                          },
                                        ),
                                ],
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length +
                                      (isSingleSelection ? 0 : 1),
                                  itemBuilder: (context, index) {
                                    // if (!isSingleSelection && index == 0) {
                                    //   return ListTile(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         isSelectAll = !isSelectAll;
                                    //         selectedValues = isSelectAll
                                    //             ? List.from(items)
                                    //             : [];
                                    //       });
                                    //     },
                                    //     leading: isSelectAll
                                    //         ? const Icon(
                                    //             Icons
                                    //                 .radio_button_checked_outlined,
                                    //             color: Colors.red,
                                    //           )
                                    //         : const Icon(Icons.circle_outlined),
                                    //     title: const Text("Select All"),
                                    //   );
                                    // }
                                    final itemIndex =
                                        isSingleSelection ? index : index - 1;
                                    final currentItem = items[itemIndex];

                                    if (isSingleSelection) {
                                    } else {
                                      // return ListTile(
                                      //   leading: selectedValues
                                      //           .contains(currentItem)
                                      //       ? const Icon(
                                      //           Icons.radio_button_checked,
                                      //           color: Colors.red,
                                      //         )
                                      //       : const Icon(Icons.circle_outlined),
                                      //   title: Text(currentItem),
                                      //   onTap: () {
                                      //     setState(() {
                                      //       select = !select;
                                      //       if (select) {
                                      //         selectedValues.add(currentItem);
                                      //         if (selectedValues.length ==
                                      //             items.length) {
                                      //           // isSelectAll = true;
                                      //         }
                                      //       } else {
                                      //         selectedValues
                                      //             .remove(currentItem);
                                      //         // isSelectAll = false;
                                      //       }
                                      //     });
                                      //   },
                                      // );
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (hint == 'Height') {
                            ref
                                .read(searchFilterInputProvider.notifier)
                                .updateInputHeightValues(
                                    'fromHeight', fromItem, toItem);
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            },
          ),
        );
      },
    );
  }

  void showLocationSelectionDialog(
      BuildContext context, String hint, List<String> items, String value) {
    List<String> selectedValues = [value];
    List<String> filteredItems = [];
    String searchQuery = '';
    final religionState = ref.watch(religiousProvider);
    final countryState = ref.watch(locationProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                            if (searchQuery.isEmpty) {
                              filteredItems = items;
                            } else {
                              filteredItems = items
                                  .where((item) => item
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Select $hint',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchQuery.isEmpty
                              ? items.length + 1
                              : filteredItems.length + 1,
                          itemBuilder: (context, index) {
                            String currentItem;
                            if (index == 0) {
                              currentItem = 'Any';
                            } else {
                              currentItem = searchQuery.isEmpty
                                  ? items[index - 1]
                                  : filteredItems[index - 1];
                            }

                            return ListTile(
                              leading: selectedValues.contains(currentItem)
                                  ? const Icon(
                                      Icons.radio_button_checked,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.circle_outlined),
                              title: Text(currentItem),
                              onTap: () {
                                setState(() {
                                  selectedValues.clear();
                                  selectedValues.add(currentItem);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              // widget.onChanged(selectedValues);
                              if (hint == 'Religion') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'religion', selectedValues);

                                int? stateId;
                                for (var e in religionState.data) {
                                  if (e.religion == selectedValues.first) {
                                    stateId = e.id;
                                    break;
                                  }
                                }

                                print("Selected State ID: $stateId");
                                if (stateId != null) {
                                  await ref
                                      .read(religiousProvider.notifier)
                                      .getCasteData(stateId);
                                } else {
                                  ref
                                      .read(religiousProvider.notifier)
                                      .removeCasteData();
                                }
                              } else if (hint == 'Caste') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'caste', selectedValues);
                                int? stateId;
                                for (var e in religionState.casteList) {
                                  if (e.caste == selectedValues.first) {
                                    stateId = e.id;
                                    break;
                                  }
                                }

                                print("Selected State ID: $stateId");
                                if (stateId != null) {
                                  await ref
                                      .read(religiousProvider.notifier)
                                      .getSubCasteData(stateId);
                                } else {
                                  ref
                                      .read(religiousProvider.notifier)
                                      .removeSubCasteData();
                                }
                              } else if (hint == 'Sub Caste') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'subCaste', selectedValues);
                              } else if (hint == 'Country') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'country', selectedValues);
                                int? stateId;
                                for (var e in countryState.countryList) {
                                  if (selectedValues.isNotEmpty) {
                                    if (e.countrys == selectedValues.first) {
                                      stateId = e.id;
                                      break;
                                    }
                                  }
                                }

                                print("Selected State ID: $stateId");

                                if (stateId != null) {
                                  await ref
                                      .read(locationProvider.notifier)
                                      .getStateData(stateId);
                                } else {
                                  ref
                                      .read(locationProvider.notifier)
                                      .removeStateData();
                                }
                              } else if (hint == 'State') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'state', selectedValues);
                                int? stateId;
                                for (var e in countryState.stateList) {
                                  if (selectedValues.isNotEmpty) {
                                    if (e.states == selectedValues.first) {
                                      stateId = e.id;
                                      break;
                                    }
                                  }
                                }

                                print("Selected State ID: $stateId");
                                if (stateId != null) {
                                  await ref
                                      .read(locationProvider.notifier)
                                      .getCityData(stateId);
                                } else {
                                  ref
                                      .read(locationProvider.notifier)
                                      .removeCityData();
                                }
                              } else if (hint == 'City') {
                                ref
                                    .read(searchFilterInputProvider.notifier)
                                    .updateInputReligionValues(
                                        'city', selectedValues);
                              }
                              if (mounted) {
                                setState(() {
                                  searchQuery = '';
                                });
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
