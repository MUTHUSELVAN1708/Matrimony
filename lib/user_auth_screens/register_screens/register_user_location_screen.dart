import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_additional_info_screen.dart';

class RegisterUserLocationScreen extends ConsumerStatefulWidget {
  @override
  _RegisterUserLocationScreenState createState() => _RegisterUserLocationScreenState();
}

class _RegisterUserLocationScreenState extends ConsumerState<RegisterUserLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? country, state, city, pincode, flatNumber, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ProgressIndicatorWidget(value: 0.8),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Location Information',
                style: AppTextStyles.headingTextstyle,
              ),
               const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'The Perfect Match for your Personal Preference...',
                  style: AppTextStyles.spanTextStyle,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your Residing Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => country = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your Residing State',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => state = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your Residing City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => city = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => pincode = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Flat Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => flatNumber = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)), // BorderRadius 12
                  ),
                ),
                onSaved: (value) => address = value,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                  final   registerState =  ref.read(registerProvider.notifier);
              bool success =     await  registerState.createLocationApi(
                    country: country ?? '',
                     states: state ?? '' ,
                      pincode: pincode ?? '',
                       city: city ?? '',
                        flatNumber: flatNumber ?? '',
                         address: address ?? ''
                         );
                         if(success){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterUserAdditionalInfoScreen()),
                      );
                         }

                    }
                  },
                  style: AppTextStyles.primaryButtonstyle,
                  child: const Text(
                    'Next',
                    style: AppTextStyles.primarybuttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
