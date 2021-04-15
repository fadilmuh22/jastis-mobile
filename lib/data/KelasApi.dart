part of 'data.dart';

class KelasApi {
  static Future<ResponseModel> createKelas(KelasModel kelas) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.post(
        '/kelas',
        data: {
          'name': kelas.name,
          'user_id': kelas.userId,
        },
      );
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
}
