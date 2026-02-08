class AuthResponse {
  final String? token;
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;
  final String? message;

  AuthResponse({
    this.token,
    this.accessToken,
    this.refreshToken,
    this.user,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      user: json['user'] != null
          ? UserData.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (token != null) 'token': token,
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (user != null) 'user': user!.toJson(),
      if (message != null) 'message': message,
    };
  }
}

class UserData {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String? accountType;
  final String? companyName;
  final String? industry;

  UserData({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    this.accountType,
    this.companyName,
    this.industry,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      accountType: json['account_type'] as String?,
      companyName: json['company_name'] as String?,
      industry: json['industry'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (accountType != null) 'account_type': accountType,
      if (companyName != null) 'company_name': companyName,
      if (industry != null) 'industry': industry,
    };
  }
}
