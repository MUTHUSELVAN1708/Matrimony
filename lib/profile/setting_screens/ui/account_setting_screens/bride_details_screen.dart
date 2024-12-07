import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/partner_photo_upload_screen.dart';

class BrideDetailsScreen extends ConsumerStatefulWidget {
  const BrideDetailsScreen({super.key});

  @override
  ConsumerState<BrideDetailsScreen> createState() => _SiteNameScreenState();
}

class _SiteNameScreenState extends ConsumerState<BrideDetailsScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deleteAccountState = ref.watch(deleteAccountProvider);

    void updateReason(String reason) {
      ref.read(deleteAccountProvider.notifier).updateName(reason);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
        ),
        title: const Text('Delete Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButtonColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/giftbox.png')
                        as ImageProvider<Object>,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                height: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'We are happy you found your life partner through us! join the lakhs of people who have married through our platform.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Please share a few additional details for us to send you a gift.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF000000)),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameController,
                onChanged: (value) {
                  updateReason(value);
                },
                decoration: InputDecoration(
                  hintText:
                      '${ref.read(userManagementProvider).userDetails.gender == 'Male' ? 'Bride\'s' : 'Groom\'s'} Name',
                  hintStyle: const TextStyle(color: Color(0xFF898989)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    ref
                        .read(deleteAccountProvider.notifier)
                        .updateWeddingDate(selectedDate.toIso8601String());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          deleteAccountState.weddingDate.isEmpty
                              ? 'Wedding Date'
                              : DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                  deleteAccountState.weddingDate)),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      CustomSnackBar.show(
                          context: context,
                          message: 'Please Enter Partner\'s Name!',
                          isError: true);
                      return;
                    }
                    if (deleteAccountState.weddingDate.isEmpty) {
                      CustomSnackBar.show(
                          context: context,
                          message: 'Please Select Wedding Date!',
                          isError: true);
                      return;
                    }
                    ref.read(deleteAccountProvider.notifier).clearWeddingName();
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const UploadPhotoScreen(),
                    );
                  },
                  style: AppTextStyles.primaryButtonstyle,
                  child: Text(
                    'Next',
                    style:
                        AppTextStyles.primarybuttonText.copyWith(fontSize: 18),
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
