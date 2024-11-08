import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/daily_recommented_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/home_screen_circle_precentage_integator.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/home_screen_profile_stack_slide.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/matches_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

import '../../../profile/profile.dart';

class NewHomeScreen extends ConsumerStatefulWidget {
  const NewHomeScreen({super.key});

  @override
  ConsumerState<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<NewHomeScreen> {
  bool isAllMatchesLoading = true;
  bool isImageLoading = true;
  bool isDailyRecommendLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    fetchAllMatches();
    fetchImage();
    fetchDailyRecommendations();
  }

  Future<void> fetchAllMatches() async {
    await ref.read(allMatchesProvider.notifier).allMatchDataFetch();
    if (mounted) {
      setState(() {
        isAllMatchesLoading = false;
      });
    }
  }

  Future<void> fetchImage() async {
    await ref.read(getImageApiProvider.notifier).getImage();
    if (mounted) {
      setState(() {
        isImageLoading = false;
      });
    }
  }

  Future<void> fetchDailyRecommendations() async {
    await ref.read(dailyRecommentProvider.notifier).dailyRecommentFetchData();
    if (mounted) {
      setState(() {
        isDailyRecommendLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 200),
            _buildAllMatches(ref),
            _buildCompleteProfile(),
            _buildSuccessStory(context),
            _buildUpgradeNow(context),
            // _buildUpgradeCard(),
            const ProfileCardStack(),
            _buildAssistanceService(),
            // _buildWaitingResponse(),
            // _buildAssistedService(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            image: getImageApiProviderState.isLoading || isImageLoading
                ? null
                : DecorationImage(
                    image: getImageApiProviderState.error != null ||
                            getImageApiProviderState.data == null ||
                            getImageApiProviderState.data!.images.isEmpty
                        ? const AssetImage('assets/image/user1.png')
                            as ImageProvider<Object>
                        : MemoryImage(
                            base64Decode(
                              getImageApiProviderState.data!.images[0]
                                  .toString()
                                  .replaceAll('\n', '')
                                  .replaceAll('\r', ''),
                            ),
                          ) as ImageProvider<
                            Object>, // Use MemoryImage for fetched image
                    fit: BoxFit.cover,
                  ),
          ),
          child: getImageApiProviderState.isLoading || isImageLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mano',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '#d23543245',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            child: _buildDailyRecommendations(context, ref))
      ],
    );
  }

  Widget _buildPendingTasks() {
    final colors = [0xFF0D5986, 0xFFD6151A, 0xFFD65915, 0xFF7C590C];
    final strings = [
      'Accept\nReceived',
      'Interests\nReceived',
      'Viewed\nYou',
      'Shortlisted\nYou'
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => Column(
          children: [
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '02',
                    style: TextStyle(
                      fontSize: 35,
                      color: Color(colors[index]),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  Text(
                    strings[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(colors[index]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyRecommendations(BuildContext context, WidgetRef ref) {
    final dailyRecommentsState = ref.watch(dailyRecommentProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), // Adjust the radius as needed
              topRight: Radius.circular(20), // Adjust the radius as needed
            ),
            color: Colors.white, // Background color for the container
          ),
          margin: const EdgeInsets.only(top: 50, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Daily Recommendations',
                  style: AppTextStyles.headingTextstyle
                      .copyWith(color: Colors.black38, fontSize: 25),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width - 20,
                child: dailyRecommentsState.error != null
                    ? Center(
                        child: Text(dailyRecommentsState.error.toString()),
                      )
                    : dailyRecommentsState.isLoading || isDailyRecommendLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(16),
                            itemCount:
                                dailyRecommentsState.dailyRecommentList!.length,
                            itemBuilder: (context, index) {
                              final dailyRecommentData = dailyRecommentsState
                                  .dailyRecommentList![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: 120,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25 /
                                                2,
                                        decoration: BoxDecoration(
                                          color: Colors.pink[200],
                                        ),
                                        child: Image.memory(
                                          base64Decode(dailyRecommentData
                                              .photos![0]
                                              .toString()
                                              .replaceAll('\n', '')
                                              .replaceAll('\r', '')),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              dailyRecommentData.name
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors
                                                    .red, // Customized color
                                                fontSize:
                                                    14, // Adjusted font size
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              '${dailyRecommentData.age.toString()} Yrs',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    10, // Adjusted font size
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildPendingTasks(),
        ),
      ],
    );
  }

  Widget _buildAllMatches(WidgetRef ref) {
    final matingData = ref.watch(allMatchesProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.userCardListColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Matches',
                style: AppTextStyles.headingTextstyle
                    .copyWith(color: AppColors.primaryButtonTextColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBarScreen(
                                index: 1,
                              )));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryButtonColor,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Text(
                    'View All',
                    style:
                        AppTextStyles.primarybuttonText.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 120,
            child: matingData.error != null
                ? Center(child: Text(matingData.error.toString()))
                : matingData.isLoading || isAllMatchesLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: matingData.allMatchList!.length,
                        itemBuilder: (context, index) {
                          final matching = matingData.allMatchList![index];
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: MemoryImage(base64Decode(matching
                                    .photos![0]
                                    .toString()
                                    .replaceAll('\n', '')
                                    .replaceAll('\r', '')
                                    .replaceAll(' ', ''))),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: matching.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: matching.age.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Match Your Partner Preference',
            style: AppTextStyles.spanTextStyle,
          )
        ],
      ),
    );
  }

  Widget _buildCompleteProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700),
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700),
                      )
                    ],
                  ),
                ],
              ),
              const CircularPercentIndicator(
                percent: 0.75,
                size: 30,
                strokeWidth: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildProfileTask('Add Your Photos', 'assets/add_icon.svg'),
              _buildProfileTask('Add Your ID Card', 'assets/add_icon.svg'),
              _buildProfileTask('Add Star', 'assets/add_icon.svg'),
              _buildProfileTask('Add Your Aadhar Card', 'assets/add_icon.svg'),
              _buildProfileTask('Add Horoscope', 'assets/add_icon.svg'),
              _buildProfileTask(
                  'Add Family Details', 'assets/add_one_icon.svg'),
              _buildProfileTask(
                  'Add Institution Details', 'assets/add_one_icon.svg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTask(String title, String icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        // border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildDownloadBanner() {
  Widget _buildSuccessStory(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/image/successimage.png')),
        borderRadius: BorderRadius.circular(8),
        color: Colors.pink[100], // Placeholder color
      ),
    );
  }

  Widget _buildUpgradeNow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        // height: 300,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.black12)
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upgrade now to find your\nperfect life partner\nfaster than ever!',
                  style: TextStyle(color: Colors.red.shade700, fontSize: 20),
                ),
                const Text(
                    'Take the Next Step Towards Your\nHappily Even After!',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlanUpgradeScreen()),
                    );
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black38,),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 2), // Add a slight shadow for a raised effect
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Upgrade Now',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            )),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/image/successimage.png'),
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upgrade now to find your\nperfect life partner\nfaster than Ever!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingResponse() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            'Waiting For Your Response',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.pink[100], // Placeholder color
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'User is waiting for your response. Please check their profile and respond.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssistanceService() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/assist.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Assisted Service',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8), // Space between texts
              Text(
                'Personalized matchmaking by experienced\nrelationship managers (RM)',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8), // Space between texts
              Text(
                'RM handpicks suitable matches from a\nlarge pool of profiles',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8), // Space between texts
              Text(
                'RM arranges meetings with prospects\nyou are interested in',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(100, 10),
                  fixedSize: const Size(100, 25),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Circular border
                  ),
                ),
                child: const Text(
                  'Know more',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
