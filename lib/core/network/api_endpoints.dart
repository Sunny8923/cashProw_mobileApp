class ApiEndpoints {
  // static const String baseUrl = "http://localhost:5000";
  // static const String baseUrl = "http://10.0.2.2:5000"; // Android emulator
  static const String baseUrl =
      "http://88.222.244.233/uat-cashprow-api/"; // real device

  // -------- AUTH --------
  static const String login = "/api/auth/login";
  static const String me = "/api/auth/me";
  static const String logout = "/api/auth/logout";

  // -------- LEADS --------
  static const String leads = "/api/leads";

  // -------- USER PROFILE --------
  static const String uploadProfilePic = "/api/users/profile-picture";
  static const String updateProfile = "/api/users/profile";

  // -------- EMAIL CHANGE (OTP FLOW) --------
  static const String requestChangeEmail = "/api/users/change-email/request";
  static const String verifyChangeEmail = "/api/users/change-email/verify";
}
