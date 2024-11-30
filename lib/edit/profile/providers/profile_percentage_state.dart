import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_provider.dart';

class IncompleteFields {
  final double completionPercentage;
  final bool registration;
  final bool religious;
  final bool uploadPhoto;
  final bool professional;
  final bool location;
  final bool horoscope;
  final bool govtIdProof;

  IncompleteFields({
    required this.completionPercentage,
    required this.registration,
    required this.religious,
    required this.uploadPhoto,
    required this.professional,
    required this.location,
    required this.horoscope,
    required this.govtIdProof,
  });

  factory IncompleteFields.fromJson(Map<String, dynamic> json) {
    bool isFieldComplete(List<dynamic> field) => field.isNotEmpty;

    return IncompleteFields(
      completionPercentage:
          double.parse(json['completionPercentage'].replaceAll('%', '')),
      registration: isFieldComplete(json['incompleteFields']["Registration"]),
      religious: isFieldComplete(json['incompleteFields']["Religious"]),
      uploadPhoto: isFieldComplete(json['incompleteFields']["UploadPhoto"]),
      professional: isFieldComplete(json['incompleteFields']["Professional"]),
      location: isFieldComplete(json['incompleteFields']["Location"]),
      horoscope: isFieldComplete(json['incompleteFields']["Horoscope"]),
      govtIdProof: isFieldComplete(json['incompleteFields']["GovtIdProof"]),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> getMissingField(bool isComplete, String missingText) {
      return isComplete ? [] : [missingText];
    }

    return {
      "Registration": getMissingField(registration, "Personal Details Missing"),
      "Religious": getMissingField(religious, "Religious Information Missing"),
      "UploadPhoto": getMissingField(uploadPhoto, "UploadPhoto Field Missing"),
      "Professional":
          getMissingField(professional, "Professional Information Missing"),
      "Location": getMissingField(location, "Location Information Missing"),
      "Horoscope": getMissingField(horoscope, "Horoscope Details Missing"),
      "GovtIdProof": getMissingField(govtIdProof, "Government ID Missing"),
    };
  }
}

class IncompleteFieldsState {
  final IncompleteFields incompleteFields;
  final bool isLoading;

  IncompleteFieldsState({
    required this.incompleteFields,
    this.isLoading = false,
  });

  IncompleteFieldsState copyWith({
    IncompleteFields? incompleteFields,
    bool? isLoading,
  }) {
    return IncompleteFieldsState(
      incompleteFields: incompleteFields ?? this.incompleteFields,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final completionProvider =
    StateNotifierProvider<IncompleteFieldsNotifier, IncompleteFieldsState>(
  (ref) => IncompleteFieldsNotifier(),
);
