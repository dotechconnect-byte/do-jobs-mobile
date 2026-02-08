class SignUpModel {
  final bool? success;
  final User? user;
  final Session? session;
  final String? message;
  final int? statusCode;

  SignUpModel({
    this.success,
    this.user,
    this.session,
    this.message,
    this.statusCode,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      success: json['success'] as bool?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      session: json['session'] != null
          ? Session.fromJson(json['session'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (success != null) 'success': success,
      if (user != null) 'user': user!.toJson(),
      if (session != null) 'session': session!.toJson(),
      if (message != null) 'message': message,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }
}

class Session {
  final String? accessToken;
  final String? refreshToken;

  Session({
    this.accessToken,
    this.refreshToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
    };
  }
}

class User {
  final String? id;
  final String? email;
  final String? fullName;
  final String? phone;
  final String? accountType;
  final String? companyName;
  final String? industry;

  User({
    this.id,
    this.email,
    this.fullName,
    this.phone,
    this.accountType,
    this.companyName,
    this.industry,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      accountType: json['account_type'] as String?,
      companyName: json['company_name'] as String?,
      industry: json['industry'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (accountType != null) 'account_type': accountType,
      if (companyName != null) 'company_name': companyName,
      if (industry != null) 'industry': industry,
    };
  }
}
