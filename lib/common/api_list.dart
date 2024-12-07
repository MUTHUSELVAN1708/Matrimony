class Api {
  // static const String baseUrl = 'http://192.168.29.223:8080/api/ahathirumanam';
  // static const String baseUrl = 'http://192.168.29.49:8080/api/ahathirumanam';
  // static const String baseUrl = 'http://192.168.1.12:8080/api/ahathirumanam';
  static const String baseUrl = 'http://192.168.213.182:8080/api/ahathirumanam';

  static const String createUser = '$baseUrl/profileCreate';
  static const String loginOtpVerify = '$baseUrl/loginotpverify';
  static const String registerOtpVerify = '$baseUrl/registerotpverify';
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
  static const String getSubcaste = '$baseUrl/getsubcaste';
  static const String getallCountry = '$baseUrl/getallcountry';
  static const String getState = '$baseUrl/getstate';
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
  static const String block = '$baseUrl/account/block';
  static const String report = '$baseUrl/account/report';
  static const String blocked = '$baseUrl/account/blocked';
  static const String myBlocked = '$baseUrl/account/';
  static const String reported = '$baseUrl/account/reported';
  static const String send = '$baseUrl/interest/send';
  static const String dontShow = '$baseUrl/interest/dont-show';
  static const String acceptOrReject = '$baseUrl/interest/';
  static const String search = '$baseUrl/search';
  static const String getReceivedList = '$baseUrl/interest/received';
  static const String getSentList = '$baseUrl/interest/sent';
  static const String unDontShow = '$baseUrl/interest/dont-show';
  static const String unblock = '$baseUrl/account/unblock';
  static const String saveHoroscope = '$baseUrl/savehoroscope';
  static const String editHoroscope = '$baseUrl/editHoroscope';
  static const String forgot = '$baseUrl/forgot';
  static const String forgototpverify = '$baseUrl/forgototpverify';
  static const String newpassword = '$baseUrl/newpassword';
  static const String changePassword = '$baseUrl/changePassword';
  static const String profilePercentage = '$baseUrl/profilePercentage';
  static const String getUserIdWithUniqueId = '$baseUrl/getuserdetailsuniqueId';
  static const String deleteAccount = '$baseUrl/deleteaccount';
  static const String fcmToken = '$baseUrl/saveToken';
  static const String getAllPlans = '$baseUrl/getallplan';
  static const String profileView = '$baseUrl/profile-view';
  static const String getProfileView = '$baseUrl/profile/view-list';
  static const String getMyProfileViews = '$baseUrl/profile/viewed-by';
  static const String shortList = '$baseUrl/favorites/add';
  static const String unShortList = '$baseUrl/favorites/remove';
  static const String getShortListedYou = '$baseUrl/favorites';
  static const String getShortListedMe = '$baseUrl/favoriteds';
  static const String successStory = '$baseUrl/successstory';
}
