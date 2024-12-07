import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/payment_state.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanUpgradeScreen extends ConsumerStatefulWidget {
  const PlanUpgradeScreen({super.key});

  @override
  ConsumerState<PlanUpgradeScreen> createState() => _PlanUpgradeScreenState();
}

class _PlanUpgradeScreenState extends ConsumerState<PlanUpgradeScreen> {
  String selectedPlan = 'Basic';
  bool isThreeMonthSelected = true;

  late Razorpay _razorpay;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getPlan();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> getPlan() async {
    await Future.delayed(Duration.zero);
    ref.read(paymentNotifier.notifier).getPlan(1);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final userManagementState = ref.watch(userManagementProvider);
    final paymentState = ref.watch(paymentNotifier);
    setState(() {
      _isLoading = false;
    });
    String paymentId = response.paymentId!;
    String orderId = response.orderId!;
    String signature = response.signature!;

    Map<String, dynamic> paymentDetails = {
      'paymentId': paymentId,
      'orderId': orderId,
      'signature': signature,
      'amount': (paymentState.plan!.priceInr.toInt() * 100),
      'plan': selectedPlan,
      'duration': isThreeMonthSelected ? '3 months' : '6 months',
      'serviceName': 'RazorPay',
      'timeOfPurchase': DateTime.now().toIso8601String(),
      'phoneNumber': userManagementState.userDetails.phoneNumber,
      'email': userManagementState.userDetails.email,
      'userId': userManagementState.userDetails.userId,
    };
    Fluttertoast.showToast(
      msg: "Payment Successful: ${response.paymentId}",
      timeInSecForIosWeb: 4,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message}",
      timeInSecForIosWeb: 4,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isLoading = false;
    });
    Map<String, dynamic> walletResponse = {
      'walletName': response.walletName,
    };
    Fluttertoast.showToast(
      msg: "External Wallet Selected: ${response.walletName}",
      timeInSecForIosWeb: 4,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openPayment(UserDetails userDetails) {
    final paymentState = ref.watch(paymentNotifier);
    setState(() {
      _isLoading = true;
    });

    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      // 'amount': (double.parse(paymentState.plan!.priceInr.toInt().toString()) * 100).toInt(),
      'amount': (double.parse(1.toString()) * 100).toInt(),
      'name': 'Aha Thirumanam',
      'description': '$selectedPlan Membership',
      'prefill': {
        'contact': userDetails.phoneNumber ?? '',
        'email': userDetails.email ?? ''
      },
      'external': {
        'wallets': ['paytm', 'gpay', 'phonepe']
      }
    };
    print('Options');
    print(options);
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Error: $e",
        timeInSecForIosWeb: 4,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userManagementState = ref.watch(userManagementProvider);
    final paymentState = ref.watch(paymentNotifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFFCE8E8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSegmentButton('Basic'),
                  _buildSegmentButton('Premium'),
                  _buildSegmentButton('Elite'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3 month',
                  style: AppTextStyles.headingTextstyle.copyWith(
                      color: !isThreeMonthSelected
                          ? AppColors.headingTextColor
                          : Colors.black),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: !isThreeMonthSelected,
                    onChanged: (value) {
                      print(!value);
                      if (selectedPlan == 'Basic' && !value) {
                        ref.read(paymentNotifier.notifier).getPlan(1);
                      } else if (selectedPlan == 'Basic' && value) {
                        ref.read(paymentNotifier.notifier).getPlan(2);
                      } else if (selectedPlan == 'Premium' && !value) {
                        ref.read(paymentNotifier.notifier).getPlan(3);
                      } else if (selectedPlan == 'Premium' && value) {
                        ref.read(paymentNotifier.notifier).getPlan(4);
                      } else if (selectedPlan == 'Elite' && !value) {
                        ref.read(paymentNotifier.notifier).getPlan(5);
                      } else if (selectedPlan == 'Elite' && value) {
                        ref.read(paymentNotifier.notifier).getPlan(6);
                      }
                      setState(() {
                        isThreeMonthSelected = !value;
                      });
                    },
                    activeColor: Colors.red,
                    inactiveThumbColor: Colors.red,
                    activeTrackColor: Colors.red.withOpacity(0.5),
                    inactiveTrackColor: Colors.red.withOpacity(0.5),
                  ),
                ),
                Text(
                  '6 month',
                  style: AppTextStyles.headingTextstyle.copyWith(
                      color: !isThreeMonthSelected
                          ? AppColors.headingTextColor
                          : Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paymentState.plan?.packageName ?? '',
                        style: AppTextStyles.headingTextstyle
                            .copyWith(fontSize: 27),
                      ),
                      const Text(
                        'Starting at',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '₹${paymentState.plan?.priceInr.toInt()}',
                        style: AppTextStyles.headingTextstyle
                            .copyWith(fontSize: 50),
                      ),
                      Text(
                        '${paymentState.plan?.duration} (${paymentState.plan!.totalProfiles ~/ int.parse(paymentState.plan!.duration.split(' ')[0])} Profile/Month)',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Total Profiles ${paymentState.plan?.totalProfiles}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            openPayment(userManagementState.userDetails);
                          },
                          style: AppTextStyles.primaryButtonstyle,
                          child: _isLoading
                              ? const LoadingIndicator()
                              : const Text(
                                  'Get Price Estimate',
                                  style: AppTextStyles.primarybuttonText,
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: paymentState.plan!.planDetails
                                .map((feature) => _buildFeatureItem(
                                      feature.featureName,
                                      isThreeMonthSelected
                                          ? feature.isAvailableFor3Months
                                          : feature.isAvailableFor6Months,
                                      // additionalText: isThreeMonthSelected
                                      //     ? feature.threeMonthText
                                      //     : feature.sixMonthText,
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String text) {
    final paymentState = ref.watch(paymentNotifier);
    bool isSelected = paymentState.plan?.packageName.contains(text) ?? false;
    return GestureDetector(
      onTap: () {
        if (text == 'Basic' && isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(1);
        } else if (text == 'Basic' && !isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(2);
        } else if (text == 'Premium' && isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(3);
        } else if (text == 'Premium' && !isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(4);
        } else if (text == 'Elite' && isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(5);
        } else if (text == 'Elite' && !isThreeMonthSelected) {
          ref.read(paymentNotifier.notifier).getPlan(6);
        }
        setState(() {
          selectedPlan = text;
        });
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primaryButtonColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text,
              style: AppTextStyles.primarybuttonText.copyWith(
                color:
                    isSelected ? Colors.white : AppColors.secondaryButtonColor,
                fontWeight: FontWeight.w700,
              ))),
    );
  }

  Widget _buildFeatureItem(String text, bool isIncluded,
      {String? additionalText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Text.rich(
            TextSpan(
              text: text,
              style: AppTextStyles.spanTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              children: additionalText != null
                  ? [
                      TextSpan(
                        text: ' ($additionalText)',
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: AppColors.headingTextColor),
                      ),
                    ]
                  : [],
            ),
          )),
        ],
      ),
    );
  }
}

class FeatureItem {
  final String name;
  final bool isIncluded;
  final String? threeMonthText;
  final String? sixMonthText;

  FeatureItem(this.name, this.isIncluded,
      {this.threeMonthText, this.sixMonthText});
}
