import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_auth_screens/login_screens/reverpod/login_password_notifier.dart';

class PhoneNumberField extends ConsumerStatefulWidget {
  final TextEditingController phoneNoController;
  const PhoneNumberField({super.key, required this.phoneNoController});

  @override
  ConsumerState<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends ConsumerState<PhoneNumberField> {
  FocusNode phoneNo = FocusNode();
  String countryCode = '91';
  String countryFlag = '🇮🇳';

  @override
  void initState() {
    super.initState();
    widget.phoneNoController.addListener(_onPhoneNoChanged);
  }

  void _onPhoneNoChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.phoneNoController.removeListener(_onPhoneNoChanged);
    widget.phoneNoController.dispose();
    phoneNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Country selector button
          InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  ref.read(logApiProvider.notifier).updatePhoneNo(
                      '+${country.phoneCode}${widget.phoneNoController.text}');
                  setState(() {
                    countryCode = country.phoneCode;
                    countryFlag = country.flagEmoji;
                  });
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  Text(
                    countryFlag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+$countryCode',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Expanded(
            child: TextField(
              controller: widget.phoneNoController,
              focusNode: phoneNo,
              onChanged: (value) {
                ref.read(logApiProvider.notifier).updatePhoneNo(
                    '+$countryCode${widget.phoneNoController.text}');
              },
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          if (widget.phoneNoController.text.length >= 10)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
