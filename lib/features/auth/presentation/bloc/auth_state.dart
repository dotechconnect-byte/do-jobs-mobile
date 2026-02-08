import 'package:equatable/equatable.dart';
import 'package:do_jobs_application/features/auth/data/model/sign_in_model.dart';
import 'package:do_jobs_application/features/auth/data/model/sign_up_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignInSuccess extends AuthState {
  final SignInModel signInModel;

  const SignInSuccess(this.signInModel);

  @override
  List<Object?> get props => [signInModel];
}

class SignUpSuccess extends AuthState {
  final SignUpModel signUpModel;

  const SignUpSuccess(this.signUpModel);

  @override
  List<Object?> get props => [signUpModel];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}
