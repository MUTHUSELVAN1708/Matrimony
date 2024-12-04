import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportProfileScreen extends ConsumerStatefulWidget {
  final String? uniqueId;
  final int? userId;

  const ReportProfileScreen({super.key, this.uniqueId, this.userId});

  @override
  ConsumerState<ReportProfileScreen> createState() =>
      _ReportProfileScreenState();
}

class _ReportProfileScreenState extends ConsumerState<ReportProfileScreen> {
  final idController = TextEditingController();
  final otherReasonController = TextEditingController();
  String reason = '';

  @override
  Widget build(BuildContext context) {
    final interestState = ref.watch(interestProvider);
    final interestModelState = ref.watch(interestModelProvider);
    return EnhancedLoadingWrapper(
      isLoading: interestState.isLoading || interestModelState.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Report Profile",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const Text(
                  "You are safe with us! we will never inform this profile about your safety concern & this reporting shall always be anonymous.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF898989),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                widget.uniqueId != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(1, 2),
                              blurRadius: 8.1,
                            ),
                          ],
                        ),
                        child: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: 'ASTAR ID Of The Member\n',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF898989),
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: widget.uniqueId ?? 'ASTAR',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black))
                        ])),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ASTAR ID Of The Member',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF898989),
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 4,
                          ),
                          TextField(
                            controller: idController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              // TextInputFormatter.withFunction(
                              //     (oldValue, newValue) {
                              //   if (newValue.text.length < 5) {
                              //     return oldValue;
                              //   }
                              //   return newValue;
                              // }),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter ASTAR ID',
                              hintStyle:
                                  const TextStyle(color: Color(0xFF898989)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _showReportDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.7))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reason.isNotEmpty ? reason : 'Reason',
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.6),
                              fontSize: 18),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey.withOpacity(0.6),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (reason == 'Other') ...[
                  TextField(
                    controller: otherReasonController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter Other Reason',
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
                ],
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    if (interestState.isLoading) {
                    } else {
                      if (idController.text.isEmpty && widget.userId == null) {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Please Enter ASTAR ID!',
                            isError: true);
                        return;
                      }
                      if (reason == 'Other' &&
                          otherReasonController.text.isEmpty) {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Please Enter Other Reason!',
                            isError: true);
                        return;
                      }
                      if (widget.userId != null) {
                        final result = await ref
                            .read(interestProvider.notifier)
                            .reportProfile(
                                widget.userId!,
                                reason == 'Other'
                                    ? otherReasonController.text
                                    : reason);
                        if (result) {
                          await ref
                              .read(interestModelProvider.notifier)
                              .getReportedUsers();
                          CustomSnackBar.show(
                              context: context,
                              message:
                                  '${widget.uniqueId} is Reported Successfully',
                              isError: false);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBarScreen(
                                isFetch: true,
                                index: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message:
                                  'Unable to Report this Profile. Please Try Again!',
                              isError: true);
                        }
                      } else {
                        final userId = await ref
                            .read(interestProvider.notifier)
                            .getUserIdWithUniqueId(idController.text);
                        if (userId != null) {
                          final result = await ref
                              .read(interestProvider.notifier)
                              .reportProfile(
                                  userId,
                                  reason == 'Other'
                                      ? otherReasonController.text
                                      : reason);
                          if (result) {
                            await ref
                                .read(interestModelProvider.notifier)
                                .getReportedUsers();
                            CustomSnackBar.show(
                                context: context,
                                message:
                                    '${idController.text} is Reported Successfully',
                                isError: false);
                            Navigator.of(context).pop();
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                message:
                                    'Unable to Report this Profile. Please Try Again!',
                                isError: true);
                          }
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message: 'Please Enter Correct ASTAR ID!',
                              isError: true);
                        }
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppColors.primaryButtonColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "CONTACT US",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6D6868)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "To Report Fraud, Contact Our Fraud Assistance Team Immediately. Your Information Will Be Kept Confidential.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF6D6868)),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _makePhoneCall('+918754712376');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    elevation: 2,
                    color: Colors.white,
                    shadowColor: Colors.black38,
                    child: const ListTile(
                      minTileHeight: 60,
                      leading: Icon(Icons.phone, color: Colors.red),
                      title: Text(
                        "Call Us",
                        style: TextStyle(color: Color(0xFF898989)),
                      ),
                      subtitle: Text(
                        "+918754712376",
                        style: TextStyle(color: Color(0xFF898989)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _sendEmail('info@ahathirumanam.com');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    elevation: 2,
                    color: Colors.white,
                    shadowColor: Colors.black38,
                    child: const ListTile(
                      minTileHeight: 60,
                      leading: Icon(Icons.email, color: Colors.red),
                      title: Text(
                        "Write To Us",
                        style: TextStyle(color: Color(0xFF898989)),
                      ),
                      subtitle: Text(
                        "info@ahathirumanam.com",
                        style: TextStyle(color: Color(0xFF898989)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReportDialog() {
    List<String> filteredItems = [
      'Obscene/Fraud Profile',
      'Inappropriate Details',
      'Duplicate Profile',
      'Fake Profile',
      'Unsolicited And Illicit Emails/Ads',
      'Other'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 0),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Report Profile Reason',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF424242),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String>(
                          title: Text(filteredItems[index]),
                          value: filteredItems[index],
                          groupValue: reason,
                          activeColor: Colors.red,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                reason = newValue;
                                otherReasonController.text = newValue != 'Other'
                                    ? ''
                                    : otherReasonController.text;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
