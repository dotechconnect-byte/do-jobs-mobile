class SignInRequest {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) {
    return SignInRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignUpPersonalRequest {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String? referralSource;

  SignUpPersonalRequest({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    this.referralSource,
  });

  factory SignUpPersonalRequest.fromJson(Map<String, dynamic> json) {
    return SignUpPersonalRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      referralSource: json['referral_source'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'full_name': fullName,
      'phone': phone,
      if (referralSource != null) 'referral_source': referralSource,
    };
  }
}

class SignUpServiceRequest {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String companyName;
  final String industry;

  SignUpServiceRequest({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.companyName,
    required this.industry,
  });

  factory SignUpServiceRequest.fromJson(Map<String, dynamic> json) {
    return SignUpServiceRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      companyName: json['company_name'] as String,
      industry: json['industry'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'full_name': fullName,
      'phone': phone,
      'company_name': companyName,
      'industry': industry,
    };
  }
}
