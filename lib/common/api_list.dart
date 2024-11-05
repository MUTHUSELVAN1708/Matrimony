
class Api {
  static const String baseUrl = 'http://192.168.29.223:8080/api/ahathirumanam';

  static const String createUser   = '$baseUrl/userCreate';
  static const String otpVerify  = '$baseUrl/verifyOTP';
  static const String createPersonalDetails  = '$baseUrl/personalDetails';
  static const String createReligionsApi  = '$baseUrl/religiousInformation';
  static const String createProfessionalInformation  = '$baseUrl/ProfessionalInformation';
  static const String createLocationDetails  = '$baseUrl/loctionInformation';
  static const String createAddtionalInformation  = '$baseUrl/addtionalInformation';
  static const String createUploadPhoto  = '$baseUrl/uploadPhoto';
  static const String createUploadGovernmentProof  = '$baseUrl/govtIdProof';
    static const String createpartnerPreference  = '$baseUrl/partnerPreference';
  static const String allMatchesGetAPi  = '$baseUrl/allautomatch';
  // static const String allMatchesGetAPi  = '$baseUrl/allautomatch';
}
