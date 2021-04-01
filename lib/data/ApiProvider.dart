part of 'data.dart';

class ApiJastis {
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://jastid.herokuapp.com/api',
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
      return response;
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        var response = ResponseModel<UserModel>.fromJson(e.response.data);
        return response;
      }
    }
    return response;
  }

  static setAuthToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}
