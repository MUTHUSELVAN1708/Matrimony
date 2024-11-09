class Api {
  static const String baseUrl = 'http://192.168.29.223:8080/api/ahathirumanam';
  // static const String baseUrl = 'http://192.168.29.15:8080/api/ahathirumanam';

  static const String createUser = '$baseUrl/userCreate';
  static const String otpVerify = '$baseUrl/verifyOTP';
  static const String createPersonalDetails = '$baseUrl/personalDetails';
  static const String createReligionsApi = '$baseUrl/religiousInformation';
  static const String createProfessionalInformation =
      '$baseUrl/professionalInformation';
  static const String createLocationDetails = '$baseUrl/loctionInformation';
  static const String createAddtionalInformation =
      '$baseUrl/addtionalInformation';
  static const String createUploadPhoto = '$baseUrl/uploadPhoto';
  static const String createUploadGovernmentProof = '$baseUrl/govtIdProof';
  static const String createpartnerPreference = '$baseUrl/partnerPreference';
  static const String getAllMatches = '$baseUrl/allautomatch';
  static const String dailyRecommented = '$baseUrl/dailyRecommendation';
  static const String getReligious = '$baseUrl/getreligion';
  static const String getcaste = '$baseUrl/getcaste';
  static const String getSubcaste = '$baseUrl/getSubcaste';
  static const String getallCountry = '$baseUrl/getallCountry';
  static const String getState = '$baseUrl/getState';
  static const String getcity = '$baseUrl/getcity';
  static const String getUserImage = '$baseUrl/userDetails';
  static const String passwordWithLogin = '$baseUrl/loginwithpassword';
}
