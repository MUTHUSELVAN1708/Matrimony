import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class BlockListScreen extends StatefulWidget {
  const BlockListScreen({super.key});

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'blocked profiles',
          style: AppTextStyles.headingTextstyle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 20,
              color: AppColors.headingTextColor,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000), // #00000008 (black with 8% opacity)
              offset: Offset(1, 2), // 1px to the right, 2px down
              blurRadius: 11.1,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/user1.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              child: Stack(children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const CustomSvg(name: 'blue_verify'),
                          Text(
                            'Id Verified',
                            style: AppTextStyles.spanTextStyle.copyWith(
                                fontSize: 13, color: const Color(0XFF1576F0)),
                          ),
                        ],
                      ),
                      const Text(
                        'M10308952',
                        style: AppTextStyles.spanTextStyle,
                      ),
                      Text(
                        'Soundarya',
                        style: AppTextStyles.headingTextstyle
                            .copyWith(fontSize: 16),
                      ),
                      const Text(
                        '23 Yrs, 5\'0\"',
                        style: AppTextStyles.spanTextStyle,
                      ),
                      const Text(
                        'Nadar',
                        style: AppTextStyles.spanTextStyle,
                      ),
                      const Text(
                        'B.Sc., Not Working',
                        style: AppTextStyles.spanTextStyle,
                      ),
                      const Text(
                        'Virudhunagar, Tamil Nadu,india',
                        style: AppTextStyles.spanTextStyle,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.headingTextColor),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const CustomSvg(
                            name: 'block_list',
                            color: AppColors.primaryButtonTextColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "UnBlock",
                            style: AppTextStyles.spanTextStyle.copyWith(
                                color: AppColors.primaryButtonTextColor),
                          )
                        ],
                      ),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
