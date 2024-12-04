import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IdentifyFraudScreen extends StatelessWidget {
  const IdentifyFraudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Safe Matrimony",
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
                "HOW TO IDENTIFY FRAUDSTERS?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6D6868),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF898989)),
                  ),
                  Expanded(
                    child: Text(
                      "They Will Not Be Willing To Show Their Face Meet In Person, Share Personal Details  Profile Photo May Not Be Theirs",
                      style: TextStyle(fontSize: 16, color: Color(0xFF898989)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF898989)),
                  ),
                  Expanded(
                    child: Text(
                      'They May Ask For Money Transfer, Citing Some Emergency/Seeking Sympathy.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF898989)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF898989)),
                  ),
                  Expanded(
                    child: Text(
                      'They Will Express Love Too Quickly Even Before Fully Understanding '
                      'Each Other.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF898989)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF898989)),
                  ),
                  Expanded(
                    child: Text(
                      "They Will Call From Multiple Phone Numbers. They Usually Don't Give A Phone Number To Call back.",
                      style: TextStyle(fontSize: 16, color: Color(0xFF898989)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontSize: 25, color: Color(0xFF898989)),
                  ),
                  Expanded(
                    child: Text(
                      "They May Ask For Email Address/Password Or Credit Card/Bank Account Details.",
                      style: TextStyle(fontSize: 16, color: Color(0xFF898989)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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

              // Call Us Button
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
              // Center(
              //   child: TextButton(
              //     onPressed: () {
              //
              //     },
              //     child: const Text(
              //       "click here to view our privacy policy",
              //       style: TextStyle(
              //         color: Colors.blue,
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
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
