class Api {
  // static const String baseUrl = 'http://192.168.29.223:8080/api/ahathirumanam';
  // static const String baseUrl = 'http://192.168.29.14:8080/api/ahathirumanam';
  // static const String baseUrl = 'http://192.168.1.12:8080/api/ahathirumanam';
  static const String baseUrl = 'http://192.168.29.49:8080/api/ahathirumanam';

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
  static const String getAllMatches = '$baseUrl/automatch';
  static const String dailyRecommented = '$baseUrl/dailyRecommendation';
  static const String getReligious = '$baseUrl/getreligion';
  static const String getcaste = '$baseUrl/getcaste';
  static const String getSubcaste = '$baseUrl/getSubcaste';
  static const String getallCountry = '$baseUrl/getallcountry';
  static const String getState = '$baseUrl/getState';
  static const String getcity = '$baseUrl/getcity';
  static const String getUserImage = '$baseUrl/userDetails';
  static const String passwordWithLogin = '$baseUrl/loginwithpassword';
  static const String otpWithLogin = '$baseUrl/login';
  static const String getProfileDetails = '$baseUrl/getProfileDetails';
  static const String editBasic = '$baseUrl/editBasic';
  static const String editContact = '$baseUrl/editContact';
  static const String editReligion = '$baseUrl/editReligion';
  static const String editProfession = '$baseUrl/editProfession';
  static const String editLocation = '$baseUrl/editLocation';
  static const String editfamliyinfo = '$baseUrl/editfamliyinfo';
  static const String getAllState = '$baseUrl/getallstate';
  static const String getAllCity = '$baseUrl/getallcity';
  static const String getAllCaste = '$baseUrl/getallcaste';
  static const String getAllSubCaste = '$baseUrl/getallsubcaste';
  static const String getAllReligion = '$baseUrl/getallreligion';
  static const String editBacicPreference = '$baseUrl/editBacicPreference';
  static const String editReligiousPreference =
      '$baseUrl/editReligiousPreference';
  static const String editProfessionalPreference =
      '$baseUrl/editProfessionalPreference';
  static const String editlocationPreference =
      '$baseUrl/editlocationPreference';
  static const String edithobbiesPreference = '$baseUrl/edithobbiesPreference';
  static const String getPreference = '$baseUrl/getPreference';
  static const String block = '$baseUrl/block';
  static const String report = '$baseUrl/report';
  static const String blocked = '$baseUrl/blocked';
  static const String reports = '$baseUrl/reports';
  static const String send = '$baseUrl/send';
  static const String accept = '$baseUrl/accept';
  static const String reject = '$baseUrl/reject';
  static const String received = '$baseUrl/received';
  static const String sent = '$baseUrl/sent';
}
