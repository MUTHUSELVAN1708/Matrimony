import 'package:flutter/material.dart';

class RequestUsersList extends StatelessWidget {
  final List<String> userImages;
  final int totalRequests;
  final VoidCallback onAddPhoto;

  const RequestUsersList({
    super.key,
    required this.userImages,
    required this.totalRequests,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Stacked Profile Images
              SizedBox(
                width: 180,
                height: 50,
                child: Stack(
                  children: [
                    for (int i = 0; i < userImages.length && i < 5; i++)
                      Positioned(
                        left: i * 35.0,
                        child: ProfileImageWithBorder(
                          imageUrl: userImages[i],
                        ),
                      ),
                    if (totalRequests > 5)
                      Positioned(
                        left: 5 * 35.0,
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '+${totalRequests - 5}',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$totalRequests members have requested to add a\nphoto to your profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddPhoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add Your Photo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImageWithBorder extends StatelessWidget {
  final String imageUrl;

  const ProfileImageWithBorder({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.5),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Example usage:
class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample image URLs
    final List<String> sampleImages = [
      'https://placeholder.com/150',
      'https://placeholder.com/150',
      'https://placeholder.com/150',
      'https://placeholder.com/150',
      'https://placeholder.com/150',
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RequestUsersList(
          userImages: sampleImages,
          totalRequests: 7,
          onAddPhoto: () {
            // Handle add photo action
            print('Add photo button pressed');
          },
        ),
      ),
    );
  }
}
