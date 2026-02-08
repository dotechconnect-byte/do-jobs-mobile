
import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/exception.dart';
import '../error/failure.dart';
import '../utilities/typedef.dart';
import 'app_api.dart';

abstract class BaseApi {
  final Dio dio;

  BaseApi({required this.dio});

  // ANSI color codes for terminal
  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m';
  static const String _red = '\x1B[31m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';
  static const String _bold = '\x1B[1m';

  ResultFuture<dynamic> request({
    required String method,
    required String subUrl,
    dynamic data,
    dynamic queryData,
    bool fromRoot = false,
  }) async {
    try {
      final String uri = AppAPI.baseUrl + subUrl;

      // Log request
      developer.log('$_cyan$_bold📤 API Request: $method $uri$_reset', name: 'BaseApi');
      if (data != null) {
        developer.log('$_blue📦 Request Body: $data$_reset', name: 'BaseApi');
      }

      Response response;
      switch (method) {
        case 'GET':
          response = await dio.get(uri, queryParameters: queryData , options: Options(validateStatus: (status) => true,));
          break;
        case 'POST':
          response = await dio.post(uri, data: data, options: Options(validateStatus: (status) => true,));
          break;
        case 'PATCH':
          response = await dio.patch(uri, data: data, options: Options(validateStatus: (status) => true,));
          break;
        case 'DELETE':
          response = await dio.delete(uri, data: data, options: Options(validateStatus: (status) => true,));
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }

      final responseData = response.data;

      // Log full response
      developer.log('$_cyan📥 API Response (Status: ${response.statusCode}):$_reset', name: 'BaseApi');
      developer.log('$_blue$responseData$_reset', name: 'BaseApi');

      // Check if the response has 'success' field (new API format)
      if (responseData is Map<String, dynamic> && responseData.containsKey('success')) {
        final bool success = responseData['success'] == true;
        final int statusCode = response.statusCode ?? 200;

        if (success && (statusCode >= 200 && statusCode < 300)) {
          developer.log('$_green$_bold✅ Success Response$_reset', name: 'BaseApi');
          developer.log('$_green✓ Status Code: $statusCode$_reset', name: 'BaseApi');
          return Right(responseData);
        } else {
          final String errorMessage = responseData['message'] ?? responseData['error'] ?? 'An error occurred';
          developer.log('$_red$_bold❌ Error: $errorMessage (Code: $statusCode)$_reset', name: 'BaseApi');
          return Left(APIFailure(message: errorMessage, statusCode: statusCode));
        }
      }

      // Handle old API format with 'statusCode' field
      final message = responseData['message'];
      final statusCode = responseData['statusCode'];

      if (statusCode == 200) {
        if (fromRoot) {
          developer.log('$_green$_bold✅ Success - Returning full response$_reset', name: 'BaseApi');
          developer.log('$_green✓ Message: $message$_reset', name: 'BaseApi');
          return Right(responseData);
        } else {
          developer.log('$_green$_bold✅ Success - Returning result only$_reset', name: 'BaseApi');
          developer.log('$_green✓ Message: $message$_reset', name: 'BaseApi');
          return Right(responseData['result']);
        }
      } else {
        developer.log('$_red$_bold❌ Error: $message (Code: $statusCode)$_reset', name: 'BaseApi');
        return Left(APIFailure(message: message, statusCode: statusCode));
      }
    } on DioException catch (e) {
      developer.log('$_red$_bold❌ DioException: ${e.message}$_reset', name: 'BaseApi');
      if (e.response != null) {
        developer.log('$_red Response Data: ${e.response!.data}$_reset', name: 'BaseApi');
        final dynamic responseData = e.response!.data;
        final String errorMessage =
            responseData['message'] ?? 'An error occurred';
        final int statusCode = e.response!.statusCode ?? 400;

        return Left(APIFailure(message: errorMessage, statusCode: statusCode));
      } else {
        return Left(
            APIFailure(message: 'DioError: ${e.message}', statusCode: 502));
      }
    } on APIException catch (e) {
      developer.log('$_red$_bold❌ APIException: ${e.message}$_reset', name: 'BaseApi');
      return Left(APIFailure.fromException(e));
    } on CacheException catch (e) {
      developer.log('$_yellow$_bold⚠️ CacheException: ${e.message}$_reset', name: 'BaseApi');
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      developer.log('$_red$_bold❌ Unexpected error: $e$_reset', name: 'BaseApi');
      return Left(APIFailure(
          message: 'Unexpected error: ${e.toString()}', statusCode: 500));
    }
  }
}
