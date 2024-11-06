import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_initial_profile_success_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';

class RegisterUserExtraDetailScreen extends ConsumerStatefulWidget {
  @override
  _RegisterUserExtraDetailScreenState createState() => _RegisterUserExtraDetailScreenState();
}

class _RegisterUserExtraDetailScreenState extends ConsumerState<RegisterUserExtraDetailScreen> {
  List<String> selectedDescribeTraits = [];
  List<String> selectedHobbies = [];

  final List<String> describeTraits = [
    'Affectionate', 'Ambitious', 'Caring', 'Confident', 'Creative',
    'Energetic', 'Friendly', 'Funny', 'Honest', 'Intelligent',
    'Kind', 'Loyal', 'Optimistic', 'Passionate', 'Reliable'
  ];

  final List<String> hobbies = [
    'Art', 'Blogging', 'Cooking', 'Dance', 'Fashion',
    'Fitness', 'Gaming', 'Music', 'Photography', 'Reading',
    'Sports', 'Travel', 'Writing', 'Yoga'
  ];

  @override
  Widget build(BuildContext context) {
        final registerState = ref.watch(registerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: ProgressIndicatorWidget(value: 10),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryButtonColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
                          const Align(
                alignment: Alignment.center,
                child: Text(
                  'Help me write this',
                  style: AppTextStyles.headingTextstyle,
                ),
              ),
              const SizedBox(height: 30,),
             
              Text(
                'People describe him as:',
                style: AppTextStyles.secondrySpanTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              const SizedBox(height:10),
              Wrap(
                spacing: 12,
                runSpacing:12,
                children: describeTraits.map((trait) => _buildChip(trait, selectedDescribeTraits)).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'His hobbies and interests are:',
                               style: AppTextStyles.secondrySpanTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: hobbies.map((hobby) => _buildChip(hobby, selectedHobbies)).toList(),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          RegisterUserInitialProfileSuccessScreen()),
                    );
                  },
                  style: AppTextStyles.primaryButtonstyle,
                  child: registerState.isLoading? const Center(child: CircularProgressIndicator(),): const Text('Save & Continue',style: AppTextStyles.primarybuttonText,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, List<String> selectedList) {
    final isSelected = selectedList.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedList.add(label);
          } else {
            selectedList.remove(label);
          }
        });
      },
      backgroundColor: isSelected ? AppColors.selectedWrapBacgroundColor : Colors.white,
      selectedColor:AppColors.selectedWrapBacgroundColor ,
      labelStyle: AppTextStyles.spanTextStyle.copyWith(
        color: isSelected ?Colors.black : AppColors.spanTextColor,
        
        fontWeight: FontWeight.w700
      ),
    );
  }
}