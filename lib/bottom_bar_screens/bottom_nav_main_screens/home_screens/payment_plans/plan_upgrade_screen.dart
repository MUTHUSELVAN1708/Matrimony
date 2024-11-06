import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanUpgradeScreen extends StatefulWidget {
  const PlanUpgradeScreen({Key? key}) : super(key: key);

  @override
  State<PlanUpgradeScreen> createState() => _PlanUpgradeScreenState();
}

class _PlanUpgradeScreenState extends State<PlanUpgradeScreen> {
  String selectedPlan = 'Basic';
  bool isThreeMonthSelected = true;

  final List<FeatureItem> basicFeatures = [
    FeatureItem('Send unlimited personalized messages', true),
    FeatureItem('Access verified mobile numbers', true, 
      threeMonthText: '40 Nos', sixMonthText: '80 Nos'),
    FeatureItem('Send SMS', true,
      threeMonthText: '30 SMS', sixMonthText: '60 SMS'),
    FeatureItem('Chat instantly with prospects', true),
    FeatureItem('View horoscope of members', true),
    FeatureItem('Profile Highlighter-Makes your profile stand out', false),
    FeatureItem('Message - Stamping Shortcuts and contacts', false),
    FeatureItem('Priority in search results', true),
    FeatureItem('Profile tagged as paid member for more response', true),
    FeatureItem('Premium display in search results', false),
    FeatureItem('Get instant notifications', true),
    FeatureItem('View Social and Professional profile of members', true),
  ];

  final List<FeatureItem> premiumFeatures = [
    FeatureItem('Send unlimited personalized Messages', true),
    FeatureItem('Access verified mobile numbers', true, 
      threeMonthText: '80 Nos', sixMonthText: '160 Nos'),
    FeatureItem('Send SMS', true,
      threeMonthText: '60 SMS', sixMonthText: '120 SMS'),
    FeatureItem('Chat instantly with prospects', true),
    FeatureItem('View horoscope of members', true),
    FeatureItem('Profile Highlighter-Makes your profile stand out', true,
      threeMonthText: '4 month', sixMonthText: '6 month'),
    FeatureItem('Message - Stamping Shortcuts and contacts', false),
    FeatureItem('Priority in search results', true),
    FeatureItem('Profile tagged as paid member for more response', true),
    FeatureItem('Premium display in search results', true),
    FeatureItem('Get instant notifications', true),
    FeatureItem('View Social and Professional profile of members', true),
  ];

  final List<FeatureItem> eliteFeatures = [
    FeatureItem('Send unlimited personalized Messages', true),
    FeatureItem('Access verified mobile numbers', true),
    FeatureItem('Send SMS', true),
    FeatureItem('Chat instantly with prospects', true),
    FeatureItem('View horoscope of members', true),
    FeatureItem('Profile Highlighter-Makes your profile stand out', true,
      threeMonthText: '1 month', sixMonthText: '2 month'),
    FeatureItem('Message - Stamping Shortcuts and contacts', true),
    FeatureItem('Priority in search results', true),
    FeatureItem('Profile tagged as paid member for more response', true),
    FeatureItem('Premium display in search results', true),
    FeatureItem('Get instant notifications',  true ),
    FeatureItem('Profile Horoscope / Reference', true),
    FeatureItem('View Social and Professional profile of members', true),
  ];

  List<FeatureItem> get currentFeatures {
    switch (selectedPlan) {
      case 'Premium':
        return premiumFeatures;
      case 'Elite':
        return eliteFeatures;
      default:
        return basicFeatures;
    }
  }

  String get currentPrice {
    switch (selectedPlan) {
      case 'Premium':
        return isThreeMonthSelected ? '₹3000' : '₹9000';
      case 'Elite':
        return isThreeMonthSelected ? '₹4000' : '₹12000';
      default:
        return isThreeMonthSelected ? '₹2000' : '₹6000';
    }
  }

    String get providedProfile {
    switch (selectedPlan) {
      case 'Elite':
        return isThreeMonthSelected ?  '3 month (50 Profile/Month)'
                              : '6 month (50 Profile/Month)';
      case 'Premium':
        return isThreeMonthSelected
                              ?  '3 month (25 Profile/Month)'
                              : '6 month (25 Profile/Month)';
      default:
        return isThreeMonthSelected
                              ?  '3 month (5 Profile/Month)'
                              : '6 month (5 Profile/Month)';
    }
  }
    String get totalProfile {
    switch (selectedPlan) {
      case 'Elite':
        return isThreeMonthSelected ?  'Total Profile (150)'
                              : 'Total Profile(300)';
      case 'Premium':
        return isThreeMonthSelected
                              ?  'Total Profile (75)'
                              : 'Total Profile (150)';
      default:
        return isThreeMonthSelected
                              ?  'Total Profile (5)'
                              : 'Total Profile(15)';
    }
  }


    late Razorpay _razorpay;
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isLoading = false; 
    });
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
    Fluttertoast.showToast(
      msg: "External Wallet Selected: ${response.walletName}",
      timeInSecForIosWeb: 4,
    );
  }

  void openPayment() {
    setState(() {
      _isLoading = true; 
    });

    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb', 
      'amount': currentPrice * 100, 
      'name': 'MatriMony',
      'description': 'Premium Membership',
      'prefill': {
        'contact': '9876543210', 
        'email': 'user@example.com' 
      },
      'external': {
        'wallets': ['paytm']
      }
    };

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
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
                 Text('3 month',
                style: AppTextStyles.headingTextstyle.copyWith(
                  color: !isThreeMonthSelected? AppColors.headingTextColor :Colors.black
                ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: !isThreeMonthSelected,
                    onChanged: (value) {
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
                Text('6 month',
                style: AppTextStyles.headingTextstyle.copyWith(
                  color:!isThreeMonthSelected? AppColors.headingTextColor :Colors.black
                ),),
              ],
            ),
            const SizedBox(height:2),
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
                        '$selectedPlan Plan',
                      
                                style: AppTextStyles.headingTextstyle.copyWith(
                fontSize: 27
                                ),
                      ),
                      const Text(
                        'Starting at',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        currentPrice,
                        
                                style: AppTextStyles.headingTextstyle.copyWith(
                fontSize: 50
                                ),
                      ),
                      Text(
                       providedProfile,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3,),
                       Text(
                       totalProfile,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        
                          onPressed: () {
                            openPayment();
                          },
                          style:AppTextStyles.primaryButtonstyle,
                          child: _isLoading
                                  ? const CircularProgressIndicator():  const Text(
                            'Get Price Estimate',
                            style: AppTextStyles.primarybuttonText,
                          ),
                        ),
                    ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: currentFeatures.map((feature) => _buildFeatureItem(
                              feature.name,
                              feature.isIncluded,
                              additionalText: isThreeMonthSelected
                                  ? feature.threeMonthText
                                  : feature.sixMonthText,
                            )).toList(),
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
    bool isSelected = selectedPlan == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryButtonColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: 
          AppTextStyles.primarybuttonText.copyWith(
                        color: isSelected ? Colors.white : AppColors.secondaryButtonColor,
            fontWeight: FontWeight.w700,
          )   
        )
      ),
    );
  }

  Widget _buildFeatureItem(String text, bool isIncluded, {String? additionalText}) {
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
    style: AppTextStyles.spanTextStyle.copyWith(color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400),
    children: additionalText != null
        ? [
            TextSpan(
              text: ' ($additionalText)',
              style: AppTextStyles.spanTextStyle.copyWith(color: AppColors.headingTextColor),
            ),
          ]
        : [],
  ),
)

          ),
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

  FeatureItem(this.name, this.isIncluded, {this.threeMonthText, this.sixMonthText});
}

