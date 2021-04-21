part of 'data.dart';

class JastisApi {
  static Dio dio = Dio(BaseOptions(
    // baseUrl: 'https://jastid.herokuapp.com/api',
    baseUrl: 'http://192.168.1.8:8000/api',
    connectTimeout: Duration(minutes: 1).inMilliseconds,
    receiveTimeout: Duration(minutes: 1).inMilliseconds,
  ));

  static String token;

  static setAuthToken(String token) {
    JastisApi.token = token;
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}
