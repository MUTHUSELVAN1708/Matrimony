import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/ui/search_filter_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/inbox_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/matches_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/new_home_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/notification_screen.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/network_provider/network_state.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import 'package:matrimony/user_register_riverpods/service/fcm_token_service.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  final int? index;
  final bool isFetch;

  const BottomNavBarScreen({super.key, this.index, required this.isFetch});

  @override
  BottomNavBarScreenState createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> {
  int _currentIndex = 0;
  DateTime? _lastBackPressTime;

  final List<Widget> _screens = [
    const NewHomeScreen(),
    const MatchesScreen(),
    const Notification2Screen(),
    const Inbox(),
    const PartnerSearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _currentIndex = widget.index!;
    }
    clearState();
  }

  Future<void> clearState() async {
    await Future.delayed(Duration.zero);
    ref.read(getImageApiProvider.notifier).clearImage();
    // await NotificationService().initializeFCM();
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(networkProvider, (previous, next) async {
    //   if (next is LowNetwork) {
    //     CustomSnackBar.show(
    //         context: context, message: 'Your Network is Poor', isError: true);
    //   }
    //   if (previous!.connectivityResult == ConnectivityResult.none &&
    //       next.connectivityResult != ConnectivityResult.none) {}
    // });
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
        bottomNavigationBar: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.primaryButtonColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/homeicon.svg'),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/matchesicon.svg'),
                label: 'MATCHES',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/notificationicon.svg'),
                label: 'NOTIFICATION',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/smsicon.svg'),
                label: 'INBOX',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/settingsicon.svg'),
                label: 'SEARCH',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
