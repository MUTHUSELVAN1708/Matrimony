import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/ui/search_filter_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/inbox_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/matches_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/new_home_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/notification_screen.dart';
import 'package:matrimony/common/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int? index;
  final bool isFetch;

  const BottomNavBarScreen({super.key, this.index, required this.isFetch});

  @override
  BottomNavBarScreenState createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends State<BottomNavBarScreen> {
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(child: _screens[_currentIndex]),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/matchesicon.svg'),
                label: 'Matches',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/notificationicon.svg'),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/smsicon.svg'),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/settingsicon.svg'),
                label: 'Filter',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
