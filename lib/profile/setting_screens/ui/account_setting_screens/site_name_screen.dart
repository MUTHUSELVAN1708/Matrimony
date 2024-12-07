import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/bride_details_screen.dart';

class SiteNameScreen extends ConsumerStatefulWidget {
  final bool? isSite;

  const SiteNameScreen({super.key, this.isSite});

  @override
  ConsumerState<SiteNameScreen> createState() => _SiteNameScreenState();
}

class _SiteNameScreenState extends ConsumerState<SiteNameScreen> {
  final siteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deleteAccountState = ref.watch(deleteAccountProvider);

    void updateReason(String reason) {
      if (widget.isSite != null) {
        ref.read(deleteAccountProvider.notifier).updateSiteName(reason);
      } else {
        ref.read(deleteAccountProvider.notifier).updateSourceName(reason);
      }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  'Enter The ${widget.isSite != null ? 'Site' : 'Source'} Name',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: siteController,
                onChanged: (value) {
                  updateReason(value);
                },
                decoration: InputDecoration(
                  hintText: '${widget.isSite != null ? 'Site' : 'Source'} Name',
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (siteController.text.isEmpty) {
                      CustomSnackBar.show(
                          context: context,
                          message:
                              'Please Enter ${widget.isSite != null ? 'Site' : 'Source'} Name!',
                          isError: true);
                      return;
                    }
                    if (widget.isSite != null) {
                      ref.read(deleteAccountProvider.notifier).clearSiteName();
                    } else {
                      ref
                          .read(deleteAccountProvider.notifier)
                          .clearSourceName();
                    }
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const BrideDetailsScreen(),
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
