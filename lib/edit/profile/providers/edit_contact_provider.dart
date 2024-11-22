import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/edit/profile/state/edit_contact_state.dart';
import 'package:matrimony/models/user_details_model.dart';

class EditContactProvider extends StateNotifier<EditContactState> {
  EditContactProvider() : super(EditContactState());

  void updateCurrentEmail(String email) {
    state = state.copyWith(currentEmail: email);
  }

  void updateNewEmail(String email) {
    state = state.copyWith(newEmail: email);
  }

  void updateCurrentPhoneNumber(String phoneNumber) {
    state = state.copyWith(currentPhoneNumber: phoneNumber);
  }

  void updateNewPhoneNumber(String phoneNumber) {
    state = state.copyWith(newPhoneNumber: phoneNumber);
  }

  void updateWhomToContact(String value) {
    state = state.copyWith(whomToContact: value);
  }

  void updateContactPersonsName(String value) {
    state = state.copyWith(contactPersonsName: value);
  }

  void updateAvailableTimeToCall(String value) {
    state = state.copyWith(availableTimeToCall: value);
  }

  void updateComments(String value) {
    state = state.copyWith(comments: value);
  }

  void setContactDetails(UserDetails userDetails) {
    state = state.copyWith(
        currentEmail: userDetails.email,
        availableTimeToCall: userDetails.availableTimeToCall,
        comments: userDetails.comments,
        contactPersonsName: userDetails.contactPersonName,
        whomToContact: userDetails.whomToContact,
        currentPhoneNumber: userDetails.phoneNumber);
  }

  Future<String> updateContactDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final countryCode = state.currentPhoneNumber
          ?.substring(0, state.currentPhoneNumber!.length - 10);
      final response = await http.put(
        Uri.parse(Api.editContact),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: state.newPhoneNumber != null && state.newPhoneNumber!.isNotEmpty
            ? jsonEncode({
                'userId': userId,
                'phoneNumber': state.newPhoneNumber != null &&
                        state.newPhoneNumber!.isNotEmpty
                    ? '$countryCode${state.newPhoneNumber}'
                    : state.currentPhoneNumber,
                'email': state.currentEmail,
                'whomToContact': state.whomToContact,
                'contactPersonName': state.contactPersonsName,
                'availableTimeToCall': state.availableTimeToCall,
                'comments': state.comments,
              })
            : jsonEncode({
                'userId': userId,
                'email': state.currentEmail,
                'whomToContact': state.whomToContact,
                'contactPersonName': state.contactPersonsName,
                'availableTimeToCall': state.availableTimeToCall,
                'comments': state.comments,
              }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return 'Success';
      } else {
        state = state.copyWith(isLoading: false);
        return jsonDecode(response.body)['errorMessage'];
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      return 'Something Went Wrong. Please Try Again!';
    }
  }

  String validateContactDetails() {
    try {
      // if (state.newEmail != null &&
      //     state.newEmail!.isNotEmpty &&
      //     !validateEmail(state.newEmail!)) {
      //   return 'Enter Valid New Email!';
      // }
      // if (state.currentEmail == state.newEmail) {
      //   return 'Entered Email Name Is Same as Current Email Name!';
      // }
      if (state.newPhoneNumber != null &&
          state.newPhoneNumber!.isNotEmpty &&
          state.newPhoneNumber!.length != 10) {
        return 'Enter Valid New Phone Number!';
      }
      if (state.newPhoneNumber ==
          state.currentPhoneNumber
              ?.substring(state.currentPhoneNumber!.length - 10)) {
        return 'Entered Phone Number Is Same as Current Phone Number!';
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  // bool validateEmail(String email) {
  //   const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  //   final regex = RegExp(emailRegex);
  //   return regex.hasMatch(email);
  // }

  void disposeState() {
    state = EditContactState();
  }
}

final editContactProvider =
    StateNotifierProvider<EditContactProvider, EditContactState>((ref) {
  return EditContactProvider();
});

// body: state.newEmail != null &&
// state.newEmail!.isNotEmpty &&
// state.newPhoneNumber != null &&
// state.newPhoneNumber!.isNotEmpty
// ? jsonEncode({
// 'userId': userId,
// 'email': state.newEmail != null && state.newEmail!.isNotEmpty
// ? state.newEmail
//     : state.currentEmail,
// 'phoneNumber': state.newPhoneNumber != null &&
// state.newPhoneNumber!.isNotEmpty
// ? '$countryCode${state.newPhoneNumber}'
//     : state.currentPhoneNumber,
// 'whomToContact': state.whomToContact,
// 'contactPersonName': state.contactPersonsName,
// 'availableTimeToCall': state.availableTimeToCall,
// 'comments': state.comments,
// })
//     : state.newPhoneNumber != null && state.newPhoneNumber!.isNotEmpty
// ? jsonEncode({
// 'userId': userId,
// 'phoneNumber': state.newPhoneNumber != null &&
// state.newPhoneNumber!.isNotEmpty
// ? '$countryCode${state.newPhoneNumber}'
//     : state.currentPhoneNumber,
// 'whomToContact': state.whomToContact,
// 'contactPersonName': state.contactPersonsName,
// 'availableTimeToCall': state.availableTimeToCall,
// 'comments': state.comments,
// })
//     : state.newEmail != null && state.newEmail!.isNotEmpty
// ? jsonEncode({
// 'userId': userId,
// 'email':
// state.newEmail != null && state.newEmail!.isNotEmpty
// ? state.newEmail
//     : state.currentEmail,
// 'whomToContact': state.whomToContact,
// 'contactPersonName': state.contactPersonsName,
// 'availableTimeToCall': state.availableTimeToCall,
// 'comments': state.comments,
// })
//     : jsonEncode({
// 'userId': userId,
// 'whomToContact': state.whomToContact,
// 'contactPersonName': state.contactPersonsName,
// 'availableTimeToCall': state.availableTimeToCall,
// 'comments': state.comments,
// }),
