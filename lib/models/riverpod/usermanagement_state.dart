import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_notifier.dart';
import 'package:matrimony/models/partner_details_model.dart';
import 'package:matrimony/models/riverpod/usermanagement_provider.dart';
import 'package:matrimony/models/user_details_model.dart';

class UserManagementState {
  final UserDetails userDetails;
  final PartnerDetailsModel userPartnerDetails;
  final bool isLoadingForUser;
  final bool isLoadingForPartner;
  final String? error;
  final UserDetails? partnerDetails;
  final PartnerDetailsModel? partnerPartnerDetails;

  UserManagementState(
      {required this.userDetails,
      required this.userPartnerDetails,
      this.isLoadingForUser = false,
      this.isLoadingForPartner = false,
      this.error,
      this.partnerDetails,
      this.partnerPartnerDetails});

  UserManagementState copyWith({
    UserDetails? userDetails,
    PartnerDetailsModel? userPartnerDetails,
    bool? isLoadingForUser,
    bool? isLoadingForPartner,
    String? error,
    UserDetails? partnerDetails,
    PartnerDetailsModel? partnerPartnerDetails,
  }) {
    return UserManagementState(
      userDetails: userDetails ?? this.userDetails,
      userPartnerDetails: userPartnerDetails ?? this.userPartnerDetails,
      isLoadingForUser: isLoadingForUser ?? this.isLoadingForUser,
      isLoadingForPartner: isLoadingForPartner ?? this.isLoadingForPartner,
      error: error ?? this.error,
      partnerDetails: partnerDetails ?? this.partnerDetails,
      partnerPartnerDetails:
          partnerPartnerDetails ?? this.partnerPartnerDetails,
    );
  }
}

final userManagementProvider =
    StateNotifierProvider<UserManagementProvider, UserManagementState>(
  (ref) => UserManagementProvider(),
);
