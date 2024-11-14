import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_notifier.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PartnerSearchScreen extends ConsumerStatefulWidget {
  const PartnerSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerSearchScreen> createState() =>
      _PartnerSearchScreenState();
}

class _PartnerSearchScreenState extends ConsumerState<PartnerSearchScreen> {
  // Selected values
  RangeValues _ageRange = const RangeValues(22, 29);
  RangeValues _heightRange = const RangeValues(4.9, 5.9);
  final String _profileCreatedBy = 'Any';
  final String _maritalStatus = 'Never Married';
  final String _motherTongue = 'Any';
  final String _physicalStatus = 'Normal';
  String _selectedTimeFilter = 'Any Time';
  bool _showProfilesWithPhoto = false;

  // Time filter options
  final List<String> timeFilters = [
    'Any Time',
    'Today',
    'Last 3 Days',
    'One Week',
    'One Month'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                      'search profile using the below criteria',
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
                          '${_ageRange.start.round()} yrs - ${_ageRange.end.round()} yrs',
                          // onTap: () => _showAgeRangeDialog(),
                        ),
                        _buildListTile(
                          'Height',
                          "${_heightRange.start}' - ${_heightRange.end}'",
                          // onTap: () => _showHeightRangeDialog(),
                        ),
                        _buildListTile('Profile created by', _profileCreatedBy),
                        _buildListTile('Marital Status', _maritalStatus),
                        _buildListTile('Mother Tongue', _motherTongue),
                        _buildListTile('Physical Status', _physicalStatus),
                      ],
                    ),

                    _buildExpandableSection(
                      title: 'Religious Information',
                      icon: SvgPicture.asset('assets/image/basic_filter.svg'),
                      children: [
                        _buildListTile('Religion', 'Hindu'),
                        _buildListTile('division', 'Any'),
                        _buildListTile('Sub-Caste', 'Any'),
                      ],
                    ),

                    // Professional Information Section
                    _buildExpandableSection(
                      title: 'Professional Information',
                      icon:
                          SvgPicture.asset('assets/image/filter_religion.svg'),
                      children: [
                        _buildListTile('Occupation', 'Software Engineer'),
                        _buildListTile('annual income', 'Any'),
                        _buildListTile('employment type', 'Any'),
                        _buildListTile('Education', 'Bachelor\'s Degree'),
                      ],
                    ),

                    // Location Section
                    _buildExpandableSection(
                      title: 'Location',
                      icon:
                          SvgPicture.asset('assets/image/filter_location.svg'),
                      children: [
                        _buildListTile('country', 'Any'),
                        _buildListTile('citizenship', 'Any'),
                      ],
                    ),

                    // Family Details Section
                    _buildExpandableSection(
                      title: 'Family Details',
                      icon: SvgPicture.asset('assets/image/filter_family.svg'),
                      children: [
                        _buildListTile('family status', 'Any'),
                        _buildListTile('family type', 'Any'),
                      ],
                    ),

                    // Hobbies & Lifestyle Section
                    _buildExpandableSection(
                      title: 'Hobbies & Lifestyle',
                      icon: SvgPicture.asset('assets/image/filter_hobbie.svg'),
                      children: [
                        _buildListTile(
                          'eating habits',
                          'doesn\'t matter',
                        ),
                        _buildListTile('smoking habits', 'doesn\'t matter'),
                        _buildListTile(
                          'drinking habits',
                          'doesn\'t matter',
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFF4F4), // #FFF4F4 color
                            Color(0xFFFDFDFD), // #FDFDFD color
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Recently Created Profiles',
                          style: AppTextStyles.headingTextstyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile Created',
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Profiles Based On Created Date',
                            style: AppTextStyles.spanTextStyle
                                .copyWith(color: Colors.black))),
                    const SizedBox(height: 15),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 15, // Horizontal space between the chips
                      runSpacing: 8, // Vertical space between rows of chips
                      children: timeFilters.map((filter) {
                        bool isSelected = _selectedTimeFilter == filter;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTimeFilter =
                                  filter; // Toggle selected filter
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Padding inside the container
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.red
                                  : Colors
                                      .white, // Red background when selected, white when unselected
                              border: Border.all(
                                color:
                                    Colors.grey, // Grey border when unselected
                                width: 1.0, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                  20), // Border radius of 20
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontFamily:
                                    'Helvetica', // Set font-family to Helvetica
                                fontSize: 12, // Font size
                                fontWeight: FontWeight.w400, // Font weight
                                height: 13.8 /
                                    12, // Line height (line-height / font-size)
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black, // Center align the text
                                decoration:
                                    TextDecoration.none, // No text decoration
                                decorationStyle: TextDecorationStyle
                                    .solid, // No text decoration (for clarity)
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Profile Type Section
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFF4F4), // #FFF4F4 color
                            Color(0xFFFDFDFD), // #FDFDFD color
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Profile Type',
                          style: AppTextStyles.headingTextstyle,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      width: double.infinity, // Set the height of the container
                      padding: const EdgeInsets.fromLTRB(
                          20, 7, 22, 7), // Set the padding for the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, // Set the background color
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.08), // Shadow color with opacity
                            offset: const Offset(
                                1, 2), // Shadow offset (horizontal, vertical)
                            blurRadius: 11.1, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Distribute the children evenly
                        children: [
                          // The text part
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Profiles with photo ',
                                    style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Matches who have added photos',
                                    style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      color: Color(
                                          0xFF514D4D), // Correct color code
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow
                                  .ellipsis, // To prevent text from overflowing
                            ),
                          ),

                          // The checkbox part
                          Checkbox(
                            value: _showProfilesWithPhoto,
                            onChanged: (bool? value) {
                              setState(() {
                                _showProfilesWithPhoto = value ?? false;
                              });
                            },
                            activeColor: Colors
                                .green, // Checkbox will be green when checked
                            checkColor: Colors.white, // White check mark
                            side: const BorderSide(
                              color: Colors.red,
                              width: 2.0, // Border width
                            ),
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // Shrink the tap area for a compact look
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 50,
                      width: double.infinity, // Set the height of the container
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10), // Set the padding for the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, // Set the background color
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.08), // Shadow color with opacity
                            offset: const Offset(
                                1, 2), // Shadow offset (horizontal, vertical)
                            blurRadius: 11.1, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Don't Show Profiles",
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ignored, Shortlisted",
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Matches Count
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '2,634',
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: AppColors.headingTextColor,
                                fontWeight:
                                    FontWeight.w700), // red color for 634
                          ),
                          TextSpan(
                            text: ' Matches Based On Your Preferences',
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                color: Colors.black,
                                fontWeight: FontWeight
                                    .w700), // black color for the rest
                          ),
                        ],
                      ),
                    ),

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
                    onPressed: () {
                      ref
                          .read(searchFilterInputProvider.notifier)
                          .updateSearchFilterInput();
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
    );
  }

  Widget _buildListTile(String title, String subtitle, {VoidCallback? onTap}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10), // Margin of 10
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
          subtitle: Text(
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
}
