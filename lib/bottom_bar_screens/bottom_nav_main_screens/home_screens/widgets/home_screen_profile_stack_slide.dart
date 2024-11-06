import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class ProfileCardStack extends StatefulWidget {
  const ProfileCardStack({super.key});

  @override
  State<ProfileCardStack> createState() => _ProfileCardStackState();
}

class _ProfileCardStackState extends State<ProfileCardStack> {
  int currentIndex = 0;

  final List<Map<String, String>> profiles = [
    {
      'name': 'Ragavan',
      'id': '#id45473547',
      'age': '32 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Mechanical',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Muthu',
      'id': '#id45473548',
      'age': '23 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Mechanical',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Abinaya',
      'id': '#id45473549',
      'age': '19 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Computer science',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Akshaya',
      'id': '#id45473550',
      'age': '19 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Computer science',
      'location': 'Chennai, Tamilnadu',
    },
  ];

  void nextProfile() {
    if (currentIndex < profiles.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousProfile() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = profiles[currentIndex];

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Waiting For Your Response',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryButtonColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Text(
                        'View Details',
                        style: AppTextStyles.primarybuttonText
                            .copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Image.asset(
                        'assets/image/successimage.png',
                        width: 120,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currentProfile['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis, // Apply ellipsis
                            maxLines: 1, // Limit to one line
                          ),
                          Text(
                            currentProfile['id']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentProfile['age']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['height']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['education']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['location']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: SizedBox(
                        height: 133,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '"He has sent an\ninterest to you"',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '15 Oct 2024',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 20,
                              width: 98,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                'Decline',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Navigation Arrows
        Positioned(
          left: 0,
          top: 25,
          bottom: 0,
          child: Center(
            child: IconButton(
              onPressed: currentIndex > 0 ? previousProfile : null,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: currentIndex > 0 ? Colors.black : Colors.grey,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 25,
          bottom: 0,
          child: Center(
            child: IconButton(
              onPressed:
                  currentIndex < profiles.length - 1 ? nextProfile : null,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: currentIndex < profiles.length - 1
                      ? Colors.black
                      : Colors.grey,
                  size: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
