import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/payment_state.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/profile_card_stack.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/daily_recommented_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/matches_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/carosal_slider.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/common/widget/social_media_banner.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_state.dart';
import 'package:matrimony/interest_accept_reject/screens/all_accepted_profiles_to_you.dart';
import 'package:matrimony/interest_accept_reject/screens/all_recieved_profile_list_screen.dart';
import 'package:matrimony/interest_accept_reject/screens/all_shortlisted_you_by_others_screen.dart';
import 'package:matrimony/interest_accept_reject/screens/all_viewed_to_you_screen.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/profile/main_profile_screen.dart';
import 'package:matrimony/profile/profile.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_screen.dart';
import 'package:matrimony/user_auth_screens/register_star_details/heroscope_add_details_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'circularPercentIndicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewHomeScreen extends ConsumerStatefulWidget {
  const NewHomeScreen({super.key});

  @override
  ConsumerState<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<NewHomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool isAllMatchesLoading = false;
  bool isImageLoading = false;
  bool isDailyRecommendLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(userManagementProvider.notifier).getUserDetails();
    ref.read(userManagementProvider.notifier).getLocalData();
    fetchAllMatches();
    fetchImage();
    fetchDailyRecommendations();
    fetchInterests();
    fetchPercentage();
    fetchAllPlans();
    fetchSuccessStories();
  }

  Future<void> fetchSuccessStories() async {
    if (mounted) {
      await ref.read(dailyRecommendProvider.notifier).fetchSuccessStories();
    }
  }

  Future<void> fetchAllMatches() async {
    await ref.read(allMatchesProvider.notifier).allMatchDataFetch();
    if (mounted) {
      setState(() {
        isAllMatchesLoading = false;
      });
    }
  }

  Future<void> fetchAllPlans() async {
    if (mounted) {
      await ref.read(paymentNotifier.notifier).getAllPlans();
    }
  }

  Future<void> fetchPercentage() async {
    if (mounted) {
      await ref.read(completionProvider.notifier).getIncompleteFields();
    }
  }

  Future<void> fetchInterests() async {
    if (mounted) {
      ref.read(interestModelProvider.notifier).getReceivedInterests();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getSentInterests();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getBlockedUsers();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getDoNotShowUsers();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getReportedUsers();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getMeBlockedUsers();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getViewedList();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getShortList();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getShortListToMe();
    }
    if (mounted) {
      ref.read(interestModelProvider.notifier).getViewedToMeList();
    }
  }

  Future<void> fetchImage() async {
    if (ref.watch(getImageApiProvider).data == null) {
      await ref.read(getImageApiProvider.notifier).getImage();
      if (mounted) {
        setState(() {
          isImageLoading = false;
        });
      }
    }
  }

  Future<void> fetchDailyRecommendations() async {
    await ref.read(dailyRecommendProvider.notifier).fetchDailyRecommendations();
    if (mounted) {
      setState(() {
        isDailyRecommendLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    final userManagementState = ref.watch(userManagementProvider);
    return EnhancedLoadingWrapper(
      isLoading: userManagementState.isLoadingForPartner,
      child: Scaffold(
        key: _scaffoldKey, // Add this line
        endDrawer: const ProfileMainScreen(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildAllMatches(),
              _buildCompleteProfile(),
              const SuccessStoryWidget(),
              if (getImageApiProviderState.data != null &&
                  !getImageApiProviderState.data!.paymentStatus) ...[
                _buildUpgradeNow(context),
              ],
              const SocialMediaIcon(),
              const ProfileCardStack(),
              _buildAssistanceService(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        if (getImageApiProviderState.isLoading || isImageLoading)
          const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          )
        else
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
                          ? const AssetImage('assets/image/emptyProfile.png')
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getImageApiProviderState.data?.name ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            '#${getImageApiProviderState.data?.uniqueId ?? ''}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6)),
                      child: GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: const Icon(Icons.menu, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Container(
            margin: const EdgeInsets.only(top: 150),
            child: _buildDailyRecommendations(context, ref))
      ],
    );
  }

  Widget _buildPendingTasks() {
    final colors = [0xFF0D5986, 0xFFD6151A, 0xFFD65915, 0xFF7C590C];
    final colorsBackground = [0xFFE7F6FF, 0xFFFFE4E4, 0xFFFDDACB, 0xFFFFF4E7];
    final interestState = ref.watch(interestModelProvider);
    final dailyRecommendState = ref.watch(dailyRecommendProvider);
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
        (index) => GestureDetector(
          onTap: () async {
            final getImageApiProviderState = ref.watch(getImageApiProvider);
            if (getImageApiProviderState.data != null &&
                getImageApiProviderState.data!.paymentStatus) {
              if (mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => index == 0
                            ? const AllAcceptedProfilesToYou()
                            : index == 1
                                ? const RequestProfilesScreen()
                                : index == 2
                                    ? const AllViewedToYouScreen()
                                    : const AllShortlistedYouByOthersScreen()));
              }
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlanUpgradeScreen()));
            }
          },
          child: Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: Color(colorsBackground[index]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  index == 0
                      ? interestState.sentInterests
                          .where((accept) => accept.status == 'Accepted')
                          .length
                          .toString()
                          .padLeft(2, '0')
                      : index == 1
                          ? interestState.receivedInterests.length
                              .toString()
                              .padLeft(2, '0')
                          : index == 2
                              ? interestState.viewListToMe.length
                                  .toString()
                                  .padLeft(2, '0')
                              : interestState.shortListToMe.length
                                  .toString()
                                  .padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(colors[index]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
        ),
      ),
    );
  }

  Widget _buildDailyRecommendations(BuildContext context, WidgetRef ref) {
    final dailyRecommendsState = ref.watch(dailyRecommendProvider);
    final interestModelState = ref.watch(interestModelProvider);
    final dailyRecommendList = dailyRecommendsState.dailyRecommendList
        .where(
            (model) => !interestModelState.blockedMeList.contains(model.userId))
        .toList();
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(top: 50, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
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
                child: dailyRecommendsState.error != null
                    ? Center(
                        child: Text(dailyRecommendsState.error.toString()),
                      )
                    : dailyRecommendsState.isLoading || isDailyRecommendLoading
                        ? const Center(child: CircularProgressIndicator())
                        : (dailyRecommendList.isEmpty)
                            ? const Center(
                                child:
                                    Text('No Daily Recommendation Available'))
                            : _buildRecommendationsList(
                                dailyRecommendList, context),
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

  Widget _buildRecommendationsList(
      dynamic dailyRecommendsState, BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      itemCount: dailyRecommendsState.length,
      itemBuilder: (context, index) {
        final dailyRecommendData = dailyRecommendsState[index];
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 120,
                  height: MediaQuery.of(context).size.height * 0.24 / 2,
                  decoration: BoxDecoration(
                    color: Colors.pink[200],
                  ),
                  child: Image.memory(
                    base64Decode(
                      dailyRecommendData.images![0]
                          .toString()
                          .replaceAll('\n', '')
                          .replaceAll('\r', ''),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 4),
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
                        dailyRecommendData.name.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${dailyRecommendData.age.toString()} Yrs',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
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
    );
  }

  Widget _buildAllMatches() {
    final matingData = ref.watch(allMatchesProvider);
    final interestModelState = ref.watch(interestModelProvider);
    final allMatchList = matingData.allMatchList
        ?.where((model) => !interestModelState.blockedMeList.contains(model.id))
        .toList();
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
                          builder: (context) => const MatchesScreen()));
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
                ? Center(
                    child: Text(
                    matingData.error.toString(),
                    style: const TextStyle(color: Colors.white),
                  ))
                : matingData.isLoading || isAllMatchesLoading
                    ? const Center(child: CircularProgressIndicator())
                    : matingData.allMatchList == null ||
                            (matingData.allMatchList != null &&
                                allMatchList!.isEmpty)
                        ? const Center(
                            child: Text(
                            'No Matches Available',
                            style: const TextStyle(color: Colors.white),
                          ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allMatchList!.length,
                            itemBuilder: (context, index) {
                              final matching = allMatchList[index];
                              return GestureDetector(
                                onTap: () async {
                                  final getImageApiProviderState =
                                      ref.watch(getImageApiProvider);

                                  if (getImageApiProviderState.data != null &&
                                      getImageApiProviderState
                                          .data!.paymentStatus) {
                                    final partnerDetails = await ref
                                        .read(userManagementProvider.notifier)
                                        .getPartnerDetails(matching.id ?? 0);
                                    if (mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllMatchesDetailsScreen(
                                                    userPartnerData:
                                                        partnerDetails ??
                                                            UserPartnerData(),
                                                  )));
                                    }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PlanUpgradeScreen()));
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: MemoryImage(
                                        base64Decode(
                                          matching.images![0]
                                              .toString()
                                              .replaceAll('\n', '')
                                              .replaceAll('\r', '')
                                              .replaceAll(' ', ''),
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8))),
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                matching.name.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${matching.age.toString()} Yrs',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    final incompleteFields = ref.watch(completionProvider).incompleteFields;
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
              CircularPercentIndicator(
                percent: incompleteFields.completionPercentage / 100,
                size: 30,
                strokeWidth: 2,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (incompleteFields.uploadPhoto)
                _buildProfileTask(
                  'Add Your Photos',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUserPhotoUploadScreen(
                          isEditPhoto: true,
                          images: getImageApiProviderState.data?.images,
                        ),
                      ),
                    );
                  },
                ),
              if (incompleteFields.govtIdProof)
                _buildProfileTask(
                  'Add Your ID Card',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUserGovernmentProof(
                          title: 'update',
                          userDetails:
                              ref.watch(userManagementProvider).userDetails,
                        ),
                      ),
                    );
                  },
                ),
              if (incompleteFields.religious)
                _buildProfileTask(
                  'Add Religion',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
              if (incompleteFields.horoscope)
                _buildProfileTask(
                  'Add Horoscope',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HoroscopeAddDetailScreen(
                          onPop: (value) {},
                        ),
                      ),
                    );
                  },
                ),
              if (incompleteFields.location)
                _buildProfileTask(
                  'Add Location',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
              if (incompleteFields.professional)
                _buildProfileTask(
                  'Add Institution Details',
                  'assets/add_one_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
              if (incompleteFields.registration)
                _buildProfileTask(
                  'Add Personal Details',
                  'assets/add_icon.svg',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTask(String title, String icon, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
        child: const Row(
          children: [
            TwinkleButtonScreen(),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/image/successimage.png'),
              backgroundColor: Colors.transparent,
            )
          ],
        ),
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

class TwinkleButtonScreen extends StatefulWidget {
  const TwinkleButtonScreen({super.key});

  @override
  TwinkleButtonScreenState createState() => TwinkleButtonScreenState();
}

class TwinkleButtonScreenState extends State<TwinkleButtonScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _twinkleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _twinkleAnimation =
        Tween<double>(begin: 0.2, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade now to find your\nperfect life partner\nfaster than ever!',
            style: TextStyle(color: Colors.red.shade700, fontSize: 20),
          ),
          const Text('Take the Next Step Towards Your\nHappily Even After!',
              style: TextStyle(color: Colors.black, fontSize: 15)),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlanUpgradeScreen()),
              );
            },
            child: AnimatedBuilder(
              animation: _twinkleAnimation,
              builder: (context, child) {
                return Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(
                            _twinkleAnimation.value), // Animate opacity
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
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
