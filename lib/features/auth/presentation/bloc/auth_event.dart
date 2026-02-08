import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignUpPersonalEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phone;

  const SignUpPersonalEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, password, fullName, phone];
}

class SignUpServiceEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String companyName;
  final String industry;

  const SignUpServiceEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.companyName,
    required this.industry,
  });

  @override
  List<Object?> get props =>
      [email, password, fullName, phone, companyName, industry];
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
