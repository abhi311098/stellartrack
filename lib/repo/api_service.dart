import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/const/api_collection.dart';
import 'api_status.dart';

class ApiService {

  static Future<Object?> apiCall({String? apiUrl}) async {
    try {
      var url = Uri.parse(apiUrl!);
      var response = await http.get(url).timeout(const Duration(seconds: 15));
      if (response.statusCode == successCode) {
        return Success(response: response.body);
      }
    } on HttpException {
      return Failure(code: httpException, errorResponse: httpExceptionMsg);
    } on SocketException {
      return Failure(code: noInternet, errorResponse: noInternetMsg);
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: invalidFormatMsg);
    } on TimeoutException {
      return Failure(code: timeout, errorResponse: timeoutMsg);
    } catch (e) {
      return Failure(code: unknownError, errorResponse: unknownErrorMsg);
    }
  }
}
