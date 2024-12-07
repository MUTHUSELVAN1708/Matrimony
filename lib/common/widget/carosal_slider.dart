import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/daily_recommented_notifier.dart';

class SuccessStoryWidget extends ConsumerStatefulWidget {
  const SuccessStoryWidget({super.key});

  @override
  SuccessStoryWidgetState createState() => SuccessStoryWidgetState();
}

class SuccessStoryWidgetState extends ConsumerState<SuccessStoryWidget> {
  int _currentIndex = 0;
  final Map<int, Uint8List> _imageCache = {};

  @override
  Widget build(BuildContext context) {
    final successStories = ref.watch(dailyRecommendProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF5050)),
        image: const DecorationImage(
          image: AssetImage('assets/image/successstoryback.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Center(
            child: successStories.successStories.isEmpty
                ? const Text(
                    'No Success Stories',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                : CarouselSlider.builder(
                    itemCount: successStories.successStories.length,
                    itemBuilder: (context, index, realIndex) {
                      final successStory = successStories.successStories[index];
                      if (!_imageCache.containsKey(index)) {
                        final decodedImage = base64Decode(
                          successStory.image
                              .toString()
                              .replaceAll('\n', '')
                              .replaceAll('\r', ''),
                        );
                        _imageCache[index] = decodedImage;
                      }
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _imageCache[index]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                successStory.weddingDate != null &&
                                        successStory.weddingDate!.isNotEmpty
                                    ? formatDate(successStory.weddingDate!)
                                    : '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.35,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
          ),
          // Dots Indicator
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(successStories.successStories.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == index ? 16 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.pink
                        : Colors.pink.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateTimeString) {
    final DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }
}
