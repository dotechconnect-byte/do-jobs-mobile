import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_jobs_application/core/consts/string_manager.dart';
import 'package:do_jobs_application/core/services/cache_services.dart';
import 'package:do_jobs_application/features/auth/data/remote_repo/auth_remote_src.dart';
import 'package:do_jobs_application/features/auth/presentation/bloc/auth_event.dart';
import 'package:do_jobs_application/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRemoteSrc, required this.cacheService})
      : super(const AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpPersonalEvent>(_onSignUpPersonal);
    on<SignUpServiceEvent>(_onSignUpService);
    on<SignOutEvent>(_onSignOut);
  }

  final AuthRemoteSrc authRemoteSrc;
  final CacheService cacheService;

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final result = await authRemoteSrc.signIn(
        email: event.email,
        password: event.password,
      );

      await result.fold(
        (failure) async {
          emit(AuthError(failure.message));
        },
        (signInModel) async {
          // Verify token storage
          final storedToken = await cacheService.readCache(
            key: AppStrings.cToken,
          );
          final storedRefreshToken = await cacheService.readCache(
            key: AppStrings.cRefresh,
          );
          final storedRole = await cacheService.readCache(
            key: AppStrings.cUserRole,
          );

          if (storedToken != null && storedToken.isNotEmpty) {
            log("Access token stored successfully: $storedToken");
            log("Refresh token stored successfully: $storedRefreshToken");
            log("Role stored successfully: $storedRole");
            emit(SignInSuccess(signInModel));
          } else {
            emit(const AuthError("Failed to store tokens"));
          }
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpPersonal(
      SignUpPersonalEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final result = await authRemoteSrc.signUpPersonal(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phone: event.phone,
      );

      await result.fold(
        (failure) async {
          emit(AuthError(failure.message));
        },
        (signUpModel) async {
          // Verify token storage
          final storedToken = await cacheService.readCache(
            key: AppStrings.cToken,
          );
          final storedRefreshToken = await cacheService.readCache(
            key: AppStrings.cRefresh,
          );
          final storedRole = await cacheService.readCache(
            key: AppStrings.cUserRole,
          );

          if (storedToken != null && storedToken.isNotEmpty) {
            log("Access token stored successfully: $storedToken");
            log("Refresh token stored successfully: $storedRefreshToken");
            log("Role stored successfully: $storedRole");
            emit(SignUpSuccess(signUpModel));
          } else {
            emit(const AuthError("Failed to store tokens"));
          }
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpService(
      SignUpServiceEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final result = await authRemoteSrc.signUpService(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phone: event.phone,
        companyName: event.companyName,
        industry: event.industry,
      );

      await result.fold(
        (failure) async {
          emit(AuthError(failure.message));
        },
        (signUpModel) async {
          // Verify token storage
          final storedToken = await cacheService.readCache(
            key: AppStrings.cToken,
          );
          final storedRefreshToken = await cacheService.readCache(
            key: AppStrings.cRefresh,
          );
          final storedRole = await cacheService.readCache(
            key: AppStrings.cUserRole,
          );

          if (storedToken != null && storedToken.isNotEmpty) {
            log("Access token stored successfully: $storedToken");
            log("Refresh token stored successfully: $storedRefreshToken");
            log("Role stored successfully: $storedRole");
            emit(SignUpSuccess(signUpModel));
          } else {
            emit(const AuthError("Failed to store tokens"));
          }
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      await cacheService.deleteCache(key: AppStrings.cToken);
      await cacheService.deleteCache(key: AppStrings.cRefresh);
      await cacheService.deleteCache(key: 'user_id');
      await cacheService.deleteCache(key: AppStrings.cEmailKey);
      await cacheService.deleteCache(key: AppStrings.cFirstName);
      await cacheService.deleteCache(key: AppStrings.cUserRole);
      emit(const AuthSignedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
