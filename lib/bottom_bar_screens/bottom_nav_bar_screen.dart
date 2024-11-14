import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/ui/search_filter_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/inbox_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/matches_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/new_home_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/notification_screen.dart';
import 'package:matrimony/common/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int? index;
  const BottomNavBarScreen({super.key, this.index});

  @override
  BottomNavBarScreenState createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const NewHomeScreen(),
    const MatchesScreen(),
    const Notification2Screen(),
    const Inbox(),
    // const InboxScreen(),
    PartnerSearchScreen() // Replace with the actual Profile screen widget
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _currentIndex = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
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
              icon:
                  SvgPicture.asset('assets/matchesicon.svg'), // Corrected here
              label: 'Matches',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/notificationicon.svg'), // Corrected here
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/smsicon.svg'), // Corrected here
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon:
                  SvgPicture.asset('assets/settingsicon.svg'), // Corrected here
              label: 'Filter',
            ),
          ],
        ),
      ),
    );
  }
}
