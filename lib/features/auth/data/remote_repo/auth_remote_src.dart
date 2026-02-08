import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:do_jobs_application/core/api_const/base_api.dart';
import 'package:do_jobs_application/data/models/logged_in_user.dart' show LoggedInUser;
import '../../../../core/error/failure.dart';
import '../../../../core/utilities/typedef.dart';
import '../model/sign_in_model.dart';
import '../model/sign_up_model.dart';

class AuthRemoteSrc extends BaseApi {
  AuthRemoteSrc({required super.dio});

  ResultFuture<SignInModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      const String subUrl = "/core/signin/";
      final bodyData = json.encode({
        "email": email,
        "password": password,
      });

      final response = await request(
        method: 'POST',
        subUrl: subUrl,
        data: bodyData,
        fromRoot: true,
      );

      return response.fold((failure) => Left(failure), (data) {
        try {
          LoggedInUser.login(data);
          final signInModel = SignInModel.fromJson(data);
          return Right(signInModel);
        } catch (e) {
          return Left(
            APIFailure(
              message: "Invalid response format: ${e.toString()}",
              statusCode: 500,
            ),
          );
        }
      });
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 502));
    }
  }

  ResultFuture<SignUpModel> signUpPersonal({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    String? referralSource,
  }) async {
    try {
      const String subUrl = "/core/signup/personal/";
      final bodyData = json.encode({
        "email": email,
        "password": password,
        "full_name": fullName,
        "phone": phone,
        if (referralSource != null) "referral_source": referralSource,
      });

      final response = await request(
        method: 'POST',
        subUrl: subUrl,
        data: bodyData,
        fromRoot: true,
      );

      return response.fold((failure) => Left(failure), (data) {
        try {
          LoggedInUser.login(data);
          final signUpModel = SignUpModel.fromJson(data);
          return Right(signUpModel);
        } catch (e) {
          return Left(
            APIFailure(
              message: "Invalid response format: ${e.toString()}",
              statusCode: 500,
            ),
          );
        }
      });
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 502));
    }
  }

  ResultFuture<SignUpModel> signUpService({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String companyName,
    required String industry,
  }) async {
    try {
      const String subUrl = "/core/signup/service/";
      final bodyData = json.encode({
        "email": email,
        "password": password,
        "full_name": fullName,
        "phone": phone,
        "company_name": companyName,
        "industry": industry,
      });

      final response = await request(
        method: 'POST',
        subUrl: subUrl,
        data: bodyData,
        fromRoot: true,
      );

      return response.fold((failure) => Left(failure), (data) {
        try {
          LoggedInUser.login(data);
          final signUpModel = SignUpModel.fromJson(data);
          return Right(signUpModel);
        } catch (e) {
          return Left(
            APIFailure(
              message: "Invalid response format: ${e.toString()}",
              statusCode: 500,
            ),
          );
        }
      });
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 502));
    }
  }
}
