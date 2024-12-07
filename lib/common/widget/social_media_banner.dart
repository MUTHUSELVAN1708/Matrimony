import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> svg = [
      FontAwesomeIcons.whatsapp,
      FontAwesomeIcons.linkedin,
      FontAwesomeIcons.instagram,
      FontAwesomeIcons.youtube,
      FontAwesomeIcons.xTwitter,
      FontAwesomeIcons.facebook
    ];
    List<dynamic> colors = [
      Colors.green,
      Colors.blue,
      Colors.pink,
      Colors.red,
      Colors.black,
      Colors.blue
    ];
    List<VoidCallback> actions = [
      () async {
        const whatsappUrl = 'https://wa.me/+918754712376';
        if (await canLaunch(whatsappUrl)) {
          await launch(whatsappUrl);
        }
      },
      () {},
      () {},
      () {},
      () {},
      () {},
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/follow.png'),
        fit: BoxFit.cover,
      )),
      // color: const Color(0xFFFF5050).withOpacity(0.6)),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Column(
                  children: [
                    SizedBox(height: 10),
                    Image(
                      image: AssetImage(
                        'assets/image/astro_logo.png',
                      ),
                      height: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Follow us for more',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontFamily: 'Michroma',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(svg.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: socialIcons(
                            actions[index], svg[index], colors[index]),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialIcons(VoidCallback onTap, IconData icon, Color color) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: color,
        ));
  }
}
