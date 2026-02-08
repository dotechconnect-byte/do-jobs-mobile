sealed class AppAPI {
  static const String baseUrl = 'https://api.dojobs.dev/api';

  // Auth endpoints
  static const String signIn = '$baseUrl/core/signin/';
  static const String signUpPersonal = '$baseUrl/core/signup/personal/';
  static const String signUpService = '$baseUrl/core/signup/service/';
}
