import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class InterestPageView extends ConsumerStatefulWidget {
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
  List<String> _selectedItems = []; 

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedIndex = index; 
      _selectedItems = [];
    });
  }

 void _onNextCategory(BuildContext context) {
  setState(() {
    // Save current selections to the appropriate field
    if (_selectedIndex == 0) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
         hobbies: _selectedItems.toString()
        );
        _selectedItems = [];
    } else if (_selectedIndex == 1) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
        interest: _selectedItems.toString()
        );
         _selectedItems = [];
    } else if (_selectedIndex == 2) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
       sportsAndFitness:  _selectedItems.toString()
        );
         _selectedItems = [];
    } else if (_selectedIndex == 3) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
        music:  _selectedItems.toString()
        );
         _selectedItems = [];
    } else if (_selectedIndex == 4) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
       moviesTvShows:  _selectedItems.toString()
       );
        _selectedItems = [];
    } else if (_selectedIndex == 5) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
       moviesTvShows:  _selectedItems.toString()
       );
        _selectedItems = [];
    } else if (_selectedIndex == 6) {
      ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
        spokenLanguages: _selectedItems.toString()
        );
        
         _selectedItems = [];
    final preference = ref.read(preferenceInputProvider);
    
    if (preference != null) {
      ref.read(partnerPreferenceProvider.notifier).uploadPartnerPreference(
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
        interest: preference.interest
        );
    }
    }

    // Move to the next category or finish
    if (_selectedIndex < categories.length - 1) {
      _selectedIndex++;
      _selectedItems = [];
    } else {
      if(ref.watch(partnerPreferenceProvider).successMessage!.isNotEmpty){
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
        );
      }
    
    }
  });
}

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Interests', style: AppTextStyles.headingTextstyle),
        centerTitle: true,
        actions: [
          const Text(
            'Skip',
            style: AppTextStyles.headingTextstyle,
          )
        ],
      ),
      body: Column(
        children: [
          // Custom Scrollable Tab Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryButtonColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.black,
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
              selectedItems: _selectedItems,
              onItemSelected: (item) {
                setState(() {
                  if (_selectedItems.contains(item)) {
                    _selectedItems.remove(item); // Deselect if already selected
                  } else {
                    _selectedItems.add(item); // Select if not already selected
                  }

                });
              },
              onNext: () => _onNextCategory(context), // Call the modified next category function
            ),
          ),
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
  Widget build(BuildContext context,WidgetRef ref) {
       final partnerState =  ref.watch(partnerPreferenceProvider);
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
                            color: isSelected ? Colors.black : AppColors.spanTextColor,
                            fontSize: 20,
                          ),
                        ),
                        selected: isSelected,
                        backgroundColor: Colors.white,
                        selectedColor: AppColors.selectedWrapBacgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: isSelected ? Colors.transparent : Colors.grey[300]!,
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
              child:partnerState.isLoading?const Center(child: CircularProgressIndicator()): const Text(
                'Save & Continue',
                style: AppTextStyles.primarybuttonText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
