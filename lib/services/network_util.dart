import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkUtil {

  static NetworkUtil _instance = NetworkUtil._internal();

  NetworkUtil._internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {
//      final String res = response.body;
//      final int statusCode = response.statusCode;

//      if (statusCode < 200 || statusCode > 400 || json == null) {
//        throw Exception("Error while fetching data");
//      }
//      if (statusCode == 200) {
//        return _decoder.convert(res);
//      }
        return response;
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return _decoder.convert(res);
      }
      if (statusCode == 404) {
        return _decoder.convert(res);
      }
//      if (statusCode < 200 || statusCode > 400 || json == null) {
//        throw Exception("Error while submitting data");
//      }
//      return _decoder.convert(res);
    });
  }
}