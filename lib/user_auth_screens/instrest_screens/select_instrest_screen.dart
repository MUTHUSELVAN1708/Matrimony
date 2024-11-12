import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class InterestPageView extends ConsumerStatefulWidget {
  const InterestPageView({super.key});

  @override
  _InterestPageViewState createState() => _InterestPageViewState();
}

class _InterestPageViewState extends ConsumerState<InterestPageView> {
  final List<Map<String, List<String>>> categories = [
    {
      'Hobbies': [
        'Reading',
        'Traveling',
        'Cooking',
        'Gardening',
        'Painting',
        'Photography',
        'Music',
        'Gaming',
        'Fitness',
        'Writing',
        'Dancing',
        'Crafting',
        'Fishing',
        'Hiking',
        'Cycling',
        'Swimming',
        'Singing',
        'Yoga',
        'Meditation',
        'Shopping',
        'Knitting',
        'Birdwatching',
        'Baking',
        'Scrapbooking',
        'Woodworking',
        'Collecting Stamps',
        'Calligraphy',
        'Origami',
        'Pottery',
        'Quilting',
        'Leather Crafting',
        'Puzzles',
        'Card Games',
        'Chess',
        'Magic Tricks',
        'Birdwatching',
        'DIY Projects',
        'Home Brewing',
        'Flower Arranging',
        'Restoring Furniture',
        'Beekeeping',
        'Photography',
      ],
    },
    {
      'Interest': [
        'Astronomy',
        'Astrology',
        'World History',
        'Political Science',
        'Philosophy',
        'Anthropology',
        'Psychology',
        'Economics',
        'Genealogy',
        'Space Exploration',
        'Environmental Conservation',
        'Paleontology',
        'Architecture',
        'Geography',
        'Mythology',
        'Archaeology',
        'Physics',
        'Marine Biology',
        'Geology',
        'Biotechnology',
        'Zoology',
        'Cryptography',
        'Ecology',
        'Meteorology',
        'Artificial Intelligence',
        'Nanotechnology',
        'Blockchain',
        'Quantum Physics',
        'Digital Marketing',
        'Political Activism',
        'Global Health',
        'Cultural Studies',
        'Human Rights',
        'Sociology',
        'Linguistics',
        'Film Studies',
        'Futurism',
        'Mathematics',
        'Philanthropy',
        'Public Speaking',
        'Space Technology',
      ],
    },
    {
      'Sports and Fitness': [
        'Soccer',
        'Basketball',
        'Cricket',
        'Tennis',
        'Badminton',
        'Baseball',
        'Rugby',
        'Golf',
        'Volleyball',
        'Hockey',
        'Running',
        'Cycling',
        'Skating',
        'Boxing',
        'MMA',
        'Skiing',
        'Surfing',
        'Rock Climbing',
        'Gymnastics',
        'Snowboarding',
        'Wrestling',
        'Kayaking',
        'Archery',
        'Bowling',
        'Table Tennis',
        'Swimming',
        'Weightlifting',
        'Crossfit',
        'Pilates',
        'Yoga',
        'Martial Arts',
        'Rowing',
        'Snorkeling',
        'Scuba Diving',
        'Mountaineering',
        'Triathlon',
        'Track and Field',
        'Horse Riding',
        'Handball',
        'Frisbee',
        'Obstacle Course Racing',
      ],
    },
    {
      'Music': [
        'Playing Instruments',
        'Singing',
        'Composing',
        'Listening to Music',
        'Music Production',
        'DJing',
        'Songwriting',
        'Beatboxing',
        'Sound Engineering',
        'Conducting',
        'Guitar',
        'Piano',
        'Violin',
        'Drums',
        'Saxophone',
        'Flute',
        'Cello',
        'Clarinet',
        'Trumpet',
        'Harp',
        'Accordion',
        'Ukulele',
        'Banjo',
        'Mandolin',
        'Tabla',
        'Electronic Music',
        'Classical Music',
        'Jazz',
        'Blues',
        'Hip Hop',
        'Opera',
        'Rock',
        'Reggae',
        'Folk Music',
        'Pop Music',
        'Country Music',
        'Music History',
        'Music Theory',
        'Choral Singing',
        'Rap',
        'World Music',
      ],
    },
    {
      'Movies and TV Shows': [
        'Action Movies',
        'Comedy Movies',
        'Drama Movies',
        'Romantic Movies',
        'Sci-Fi Movies',
        'Horror Movies',
        'Documentaries',
        'Fantasy Movies',
        'Thrillers',
        'Animated Movies',
        'Crime Dramas',
        'Mystery Shows',
        'Historical Movies',
        'Superhero Movies',
        'Musicals',
        'Adventure Movies',
        'Film Noir',
        'Anime',
        'Reality TV Shows',
        'Game Shows',
        'Talk Shows',
        'Late Night Shows',
        'Sitcoms',
        'Cooking Shows',
        'Travel Shows',
        'Science Fiction Shows',
        'True Crime Series',
        'Legal Dramas',
        'Soap Operas',
        'Miniseries',
        'Nature Documentaries',
        'Fantasy Series',
        'Independent Films',
        'Silent Films',
        'Film Festivals',
        'Cinematic Universe',
        'Western Movies',
        'Dark Comedies',
        'Sports Documentaries',
        'Biographical Movies',
        'Classic Movies',
      ],
    },
    {
      'Food': [
        'Italian Cuisine',
        'Chinese Cuisine',
        'Mexican Cuisine',
        'Indian Cuisine',
        'French Cuisine',
        'Japanese Cuisine',
        'Greek Cuisine',
        'Thai Cuisine',
        'Spanish Cuisine',
        'Lebanese Cuisine',
        'Vietnamese Cuisine',
        'Korean Cuisine',
        'Brazilian Cuisine',
        'Mediterranean Cuisine',
        'Middle Eastern Cuisine',
        'Caribbean Cuisine',
        'American Cuisine',
        'Fusion Food',
        'Street Food',
        'Vegetarian Food',
        'Vegan Food',
        'Baking',
        'BBQ',
        'Sushi',
        'Pastries',
        'Seafood',
        'Desserts',
        'Salads',
        'Grilling',
        'Soups',
        'Sandwiches',
        'Breakfast Foods',
        'Appetizers',
        'Smoothies',
        'Ice Cream',
        'Cakes',
        'Fast Food',
        'Pizza',
        'Steaks',
        'Gourmet Food',
        'Pasta',
      ],
    },
    {
      'Spoken Languages': [
        'English',
        'Spanish',
        'Mandarin',
        'French',
        'German',
        'Arabic',
        'Hindi',
        'Portuguese',
        'Russian',
        'Japanese',
        'Korean',
        'Italian',
        'Turkish',
        'Dutch',
        'Bengali',
        'Swedish',
        'Greek',
        'Cantonese',
        'Hebrew',
        'Vietnamese',
        'Polish',
        'Persian',
        'Thai',
        'Indonesian',
        'Urdu',
        'Punjabi',
        'Tamil',
        'Malay',
        'Czech',
        'Hungarian',
        'Norwegian',
        'Danish',
        'Finnish',
        'Swahili',
        'Zulu',
        'Afrikaans',
        'Icelandic',
        'Romanian',
        'Filipino',
        'Serbian',
      ],
    },
  ];

  int _selectedIndex = 0;
  List<String> _selectedHobbies = [];
  List<String> _selectedInterest = [];
  List<String> _selectedSportsAndFitness = [];
  List<String> _selectedMusic = [];
  List<String> _selectedMoviesTvShows = [];
  List<String> _selectedFood = [];
  List<String> _selectedSpokenLanguages = [];

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _onNextCategory(BuildContext context) async {
    setState(() {
      switch (_selectedIndex) {
        case 0:
          _selectedHobbies = List.from(_selectedHobbies);
          ref
              .read(preferenceInputProvider.notifier)
              .updatePreferenceInput(hobbies: _selectedHobbies.toString());
          break;
        case 1:
          _selectedInterest = List.from(_selectedInterest);
          ref
              .read(preferenceInputProvider.notifier)
              .updatePreferenceInput(interest: _selectedInterest.toString());
          break;
        case 2:
          _selectedSportsAndFitness = List.from(_selectedSportsAndFitness);
          ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
              sportsAndFitness: _selectedSportsAndFitness.toString());
          break;
        case 3:
          _selectedMusic = List.from(_selectedMusic);
          ref
              .read(preferenceInputProvider.notifier)
              .updatePreferenceInput(music: _selectedMusic.toString());
          break;
        case 4:
          _selectedMoviesTvShows = List.from(_selectedMoviesTvShows);
          ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
              moviesTvShows: _selectedMoviesTvShows.toString());
          break;
        case 5:
          _selectedFood = List.from(_selectedFood);
          ref
              .read(preferenceInputProvider.notifier)
              .updatePreferenceInput(food: _selectedFood.toString());
          break;
      }
    });

    if (_selectedIndex == 6) {
      _selectedSpokenLanguages = List.from(_selectedSpokenLanguages);
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
          spokenLanguages: _selectedSpokenLanguages.toString());
      final preference = ref.read(preferenceInputProvider);

      if (preference != null) {
        await ref
            .read(partnerPreferenceProvider.notifier)
            .uploadPartnerPreference(
              userId: preference.userId,
              fromAge: preference.fromAge,
              toAge: preference.toAge,
              height: preference.height,
              maritalStatus: preference.maritalStatus,
              motherTongue: preference.motherTongue,
              physicalStatus: preference.physicalStatus,
              eatingHabits: preference.eatingHabits,
              smokingHabits: preference.smokingHabits,
              religion: preference.religion,
              caste: preference.caste,
              subCaste: preference.subcaste,
              star: preference.star,
              rassi: preference.rassi,
              dosham: preference.dosham,
              education: preference.education,
              employedIn: preference.employedIn,
              profession: preference.profession,
              annualIncome: preference.annualIncome,
              country: preference.country,
              states: preference.states,
              city: preference.city,
              lookingFor: preference.lookingFor,
              lifestyle: preference.lifestyle,
              hobbies: preference.hobbies,
              music: preference.music,
              reading: preference.reading,
              moviesTvShows: preference.moviesTvShows,
              sportsAndFitness: preference.sportsAndFitness,
              food: preference.food,
              spokenLanguages: preference.spokenLanguages,
              interest: preference.interest,
            );
      }
    }

    setState(() {
      if (_selectedIndex < categories.length - 1) {
        _selectedIndex++;
      } else {
        if (ref.watch(partnerPreferenceProvider).successMessage?.isNotEmpty ??
            false) {
          _selectedHobbies = [];
          _selectedInterest = [];
          _selectedSportsAndFitness = [];
          _selectedMusic = [];
          _selectedMoviesTvShows = [];
          _selectedFood = [];
          _selectedSpokenLanguages = [];
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen()),
              (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Interests',
            style: AppTextStyles.headingTextstyle),
        centerTitle: true,
        actions: const [
          Row(
            children: [
              Text(
                'Skip',
                style: AppTextStyles.headingTextstyle,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // Custom Scrollable Tab Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => _onCategoryTapped(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryButtonColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color:
                                isSelected ? Colors.transparent : Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          categories[index].keys.first,
                          style: AppTextStyles.spanTextStyle.copyWith(
                            color: isSelected
                                ? AppColors.primaryButtonTextColor
                                : AppColors.secondaryButtonColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: InterestCategoryScreen(
              category: categories[_selectedIndex].keys.first,
              items: categories[_selectedIndex].values.first,
              selectedItems: categories[_selectedIndex].keys.first == 'Hobbies'
                  ? _selectedHobbies
                  : categories[_selectedIndex].keys.first == 'Interest'
                      ? _selectedInterest
                      : categories[_selectedIndex].keys.first ==
                              'Sports and Fitness'
                          ? _selectedSportsAndFitness
                          : categories[_selectedIndex].keys.first == 'Music'
                              ? _selectedMusic
                              : categories[_selectedIndex].keys.first ==
                                      'Movies and TV Shows'
                                  ? _selectedMoviesTvShows
                                  : categories[_selectedIndex].keys.first ==
                                          'Food'
                                      ? _selectedFood
                                      : categories[_selectedIndex].keys.first ==
                                              'Spoken Languages'
                                          ? _selectedSpokenLanguages
                                          : [],
              onItemSelected: (item) {
                setState(() {
                  final currentCategory = categories[_selectedIndex].keys.first;
                  List<String> selectedList;
                  if (currentCategory == 'Hobbies') {
                    selectedList = _selectedHobbies;
                  } else if (currentCategory == 'Interest') {
                    selectedList = _selectedInterest;
                  } else if (currentCategory == 'Sports and Fitness') {
                    selectedList = _selectedSportsAndFitness;
                  } else if (currentCategory == 'Music') {
                    selectedList = _selectedMusic;
                  } else if (currentCategory == 'Movies and TV Shows') {
                    selectedList = _selectedMoviesTvShows;
                  } else if (currentCategory == 'Food') {
                    selectedList = _selectedFood;
                  } else if (currentCategory == 'Spoken Languages') {
                    selectedList = _selectedSpokenLanguages;
                  } else {
                    selectedList = [];
                  }
                  if (selectedList.contains(item)) {
                    selectedList.remove(item);
                  } else {
                    selectedList.add(item);
                  }
                });
              },
              onNext: () => _onNextCategory(context),
            ),
          )
        ],
      ),
    );
  }
}

class InterestCategoryScreen extends ConsumerWidget {
  final String category;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<String> onItemSelected;
  final VoidCallback onNext;

  InterestCategoryScreen({
    required this.category,
    required this.items,
    required this.selectedItems,
    required this.onItemSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerState = ref.watch(partnerPreferenceProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: items.map((item) {
                      final bool isSelected = selectedItems.contains(item);
                      return ChoiceChip(
                        label: Text(
                          item,
                          style: AppTextStyles.spanTextStyle.copyWith(
                            color: isSelected
                                ? Colors.black
                                : AppColors.spanTextColor,
                            fontSize: 20,
                          ),
                        ),
                        selected: isSelected,
                        backgroundColor: Colors.white,
                        selectedColor: AppColors.selectedWrapBacgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey[300]!,
                          ),
                        ),
                        onSelected: (selected) {
                          onItemSelected(item);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20), // Space at the bottom of the list
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              style: AppTextStyles.primaryButtonstyle,
              child: partnerState.isLoading
                  ? const LoadingIndicator()
                  : Text(
                      category == 'Spoken Languages'
                          ? 'Save & Continue'
                          : 'Next',
                      style: AppTextStyles.primarybuttonText,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
