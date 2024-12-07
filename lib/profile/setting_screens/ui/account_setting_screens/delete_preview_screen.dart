import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/thanks_screen.dart';

class DeletePreviewScreen extends ConsumerStatefulWidget {
  const DeletePreviewScreen({super.key});

  @override
  SuccessStoryScreenState createState() => SuccessStoryScreenState();
}

class SuccessStoryScreenState extends ConsumerState<DeletePreviewScreen> {
  final _storyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setStory();
  }

  Future<void> setStory() async {
    await Future.delayed(Duration.zero);
    _storyController.text =
        "I found ${ref.read(deleteAccountProvider).name}'s profile on "
        "Ahathirumanam and contacted her. Our interests matched so well, and we informed our "
        "families to take this forward. We met soon after and finalized things."
        " I am happy to have found a perfect partner with similar preferences through Ahathirumanam.";
    ref
        .read(deleteAccountProvider.notifier)
        .updateSuccessStory(_storyController.text);
  }

  @override
  Widget build(BuildContext context) {
    final deleteAccountState = ref.watch(deleteAccountProvider);
    return EnhancedLoadingWrapper(
      isLoading: deleteAccountState.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: AppColors.primaryButtonColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Preview before submitting',
            style: TextStyle(
                color: AppColors.primaryButtonColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/image/giftbox.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  '${ref.read(userManagementProvider).userDetails.name} & ${ref.read(deleteAccountProvider).name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryButtonColor,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Success Story',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Life is happier, thanks to Ahathirumanam',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _storyController,
                        maxLines: 7,
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                          hintText: 'Your success story',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          ref
                              .read(deleteAccountProvider.notifier)
                              .updateSuccessStory(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Edit story',
                    style: TextStyle(
                      color: AppColors.primaryButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (!deleteAccountState.isLoading) {
                      if (_storyController.text.isEmpty) {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Please Enter Your Success Story!',
                            isError: true);
                        return;
                      }
                      final result = await ref
                          .read(deleteAccountProvider.notifier)
                          .deleteAccount();
                      if (result) {
                        NavigationHelper.slideNavigateTo(
                            context: context, screen: const ThanksScreen());
                      } else {
                        CustomSnackBar.show(
                            context: context,
                            message:
                                'Unable To Delete Account. Please Try Again!',
                            isError: true);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
