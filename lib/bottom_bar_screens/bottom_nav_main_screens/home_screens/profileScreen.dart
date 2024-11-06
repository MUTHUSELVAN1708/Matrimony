import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      // clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: const BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
              image: AssetImage(
                  'assets/profile_banner.png'), // Correct the asset path here
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: Colors.white),
                  const SizedBox(width: 20),
                  ProgressIndicatorWidget(value: 0.7),
                ],
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(
                "Bio Data",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Photos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Horoscope'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.pink.shade200,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person_add),
                Text('Put a face on a Profile'),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Persional Information'),
          _buildProfileOption(
            title: 'Personal Information',
            icon: Icons.person_outline,
            iconColor: Colors.blue,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Basic Details',
            icon: Icons.assignment_outlined,
            iconColor: Colors.blue,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Religious Information',
            icon: Icons.church_outlined,
            iconColor: Colors.orange,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Professional Information',
            icon: Icons.work_outline,
            iconColor: Colors.green,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Location',
            icon: Icons.location_on_outlined,
            iconColor: Colors.red,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Family Details',
            icon: Icons.family_restroom,
            iconColor: Colors.purple,
            onTap: () {},
          ),
          _buildProfileOption(
            title: 'Hobbies & Interests',
            icon: Icons.interests_outlined,
            iconColor: Colors.teal,
            onTap: () {},
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 0.6)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Your Partner Preferences To Get Better Matches',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Edit Preferences'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required String title,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  _buildProfileHeader(context),
                  Positioned(
                      bottom: -MediaQuery.of(context).size.height * 0.60,
                      left: 0,
                      right: 0,
                      child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            _buildProfileContent(context),
                            const Positioned(
                              top: -50,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/profile_avatar.png'),
                              ),
                            ),
                          ]))
                ]),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
