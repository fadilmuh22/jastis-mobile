part of 'data.dart';

class AuthApi {
  static Future<ResponseModel<UserModel>> login(Map loginInfo) async {
    ResponseModel<UserModel> response;
    try {
      var result = await JastisApi.dio.post('/login', data: {
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['data']);
        JastisApi.setAuthToken(response.token);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel<UserModel>> register(Map loginInfo) async {
    ResponseModel<UserModel> response;
    try {
      var result = await JastisApi.dio.post('/register', data: {
        'name': loginInfo['name'],
        'email': loginInfo['email'],
        'password': loginInfo['password'],
      });
      response = ResponseModel.fromJson(result.data);
      if (response.success) {
        response.data = UserModel.fromJson(result.data['data']);
        JastisApi.setAuthToken(response.token);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel> logout() async {
    ResponseModel<UserModel> response;
    try {
      var result = await JastisApi.dio.post('/logout', data: {
        'token': JastisApi.token,
      });
      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel> googleLogin(String token) async {
    ResponseModel<UserModel> response;
    try {
      var result = await JastisApi.dio.post('/google', data: {
        'token': token,
      });
      response = ResponseModel.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel<UserModel>> userInfo(String userId) async {
    ResponseModel<UserModel> response;
    try {
      var result = await JastisApi.dio.get('/user/$userId');
      response = ResponseModel.fromJson(result.data);
      response.data = UserModel.fromJson(result.data['data']);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel<UserModel>.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
