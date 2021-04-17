part of 'data.dart';

class KelasApi {
  static Future<ResponseModel> createKelas(KelasModel kelas) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.post(
        '/kelas',
        data: {
          'name': kelas.name,
          'subject': kelas.subject,
          'desc': kelas.desc,
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

  static Future<ResponseModel> updateKelas(KelasModel kelas) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.put(
        '/kelas/${kelas.id}',
        data: {
          'name': kelas.name,
          'subject': kelas.subject,
          'desc': kelas.desc,
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

  static Future<ResponseModel> deleteKelas(KelasModel kelas) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.delete(
        '/kelas/${kelas.id}',
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

  static Future<ResponseModel> joinKelas(KelasModel kelas) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.post(
        '/user/${kelas.userId}/kelas',
        data: {
          'code': kelas.code,
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

  static Future<ResponseModel> createTask(TaskModel task) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.post(
        '/task',
        data: {
          'title': task.title,
          'desc': task.desc,
          'date_end': task.dateEnd,
          'kelas_id': task.kelasId,
          'user_id': task.userId,
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

  static Future<ResponseModel<List<KelasModel>>> getKelas(
      UserModel user) async {
    ResponseModel<List<KelasModel>> response;
    try {
      var result = await JastisApi.dio.get(
        '/user/${user.id}/kelas',
      );
      response = ResponseModel.fromJson(result.data);
      if (response.success && result.data['data'] != null) {
        response.data = result.data['data']
            .map<KelasModel>((data) => KelasModel.fromJson(data))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel<List<TaskModel>>> getTask(UserModel user) async {
    ResponseModel<List<TaskModel>> response;
    try {
      var result = await JastisApi.dio.get(
        '/task',
        queryParameters: {
          'user_id': user.id,
        },
      );
      response = ResponseModel.fromJson(result.data);
      if (response.success && result.data['data'] != null) {
        response.data = result.data['data']
            .map<TaskModel>((data) => TaskModel.fromJson(data))
            .toList();
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        response = ResponseModel.fromJson(e.response.data);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<ResponseModel> deleteTask(TaskModel task) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.delete(
        '/task/${task.id}',
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

  static Future<ResponseModel> deleteEvent(KelasModel event) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.delete(
        '/event/${event.id}',
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
