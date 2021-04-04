part of 'data.dart';

class ApiJastis {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://jastid.herokuapp.com/api',
    connectTimeout: Duration(minutes: 1).inMilliseconds,
    receiveTimeout: Duration(minutes: 1).inMilliseconds,
  ));

  static Future<ResponseModel<UserModel>> login(Map loginInfo) async {
    ResponseModel<UserModel> response;
    try {
      var result = await dio.post('/login', data: {
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['user']);
        ApiJastis.setAuthToken(response.token);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    }
    return response;
  }

  static Future<ResponseModel<UserModel>> register(Map loginInfo) async {
    ResponseModel<UserModel> response;
    try {
      var result = await dio.post('/register', data: {
        'name': loginInfo['name'],
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['user']);
        ApiJastis.setAuthToken(response.token);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    }
    return response;
  }

  static Future<ResponseModel> googleLogin(String token) async {
    ResponseModel<UserModel> response;
    try {
      var result = await dio.post('/google', data: {
        'token': token,
      });
      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      response = ResponseModel.fromJson(e.response.data);
    }
    return response;
  }

  static Future<ResponseModel> logout(String token) async {
    ResponseModel<UserModel> response;
    try {
      var result = await dio.post('/logout', data: {
        'token': token,
      });
      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      response = ResponseModel.fromJson(e.response.data);
    }
    return response;
  }

  static setAuthToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}
