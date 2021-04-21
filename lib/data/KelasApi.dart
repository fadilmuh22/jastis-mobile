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

  static Future<ResponseModel> leaveKelas(
      KelasModel kelas, String userId) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.delete(
        '/user/$userId/kelas',
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
          'date_end': task.dateEnd.toIso8601String(),
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

  static Future<ResponseModel> updateTask(TaskModel task) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.put(
        '/task/${task.id}',
        data: {
          'title': task.title,
          'desc': task.desc,
          'date_end': task.dateEnd.toIso8601String(),
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
        '/user/${user.id}/task_act',
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

  static Future<ResponseModel<List<TaskModel>>> kelasTask(
      KelasModel kelas) async {
    ResponseModel<List<TaskModel>> response;
    try {
      var result = await JastisApi.dio.get(
        '/kelas/${kelas.id}/task',
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

  static Future<ResponseModel> sendTask(TaskModel task, String userId) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.post(
        '/user/$userId/sent_task',
        data: {
          'task_id': task.id,
          'data': task.data,
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

  static Future<ResponseModel> updateSentTask(
      TaskModel task, String sentTaskId) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.put(
        '/user/$sentTaskId/sent_task',
        data: {
          'data': task.data,
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

  static Future<ResponseModel> updateSentTaskScore(
      int score, String sentTaskId) async {
    ResponseModel response;
    try {
      var result = await JastisApi.dio.put(
        '/task/$sentTaskId/score',
        data: {
          'score': score,
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

  static Future<ResponseModel<List<TaskUserModel>>> getSentTask(
      String userId) async {
    ResponseModel<List<TaskUserModel>> response;
    try {
      var result = await JastisApi.dio.get('/user/$userId/sent_task');
      response = ResponseModel<List<TaskUserModel>>.fromJson(result.data);

      if (response.success) {
        response.data = result.data['data']
            .map<TaskUserModel>((data) => TaskUserModel.fromJson(data))
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

  static Future<ResponseModel<List<TaskUserModel>>> getSentTaskTeach(
      String taskId) async {
    ResponseModel<List<TaskUserModel>> response;
    try {
      var result = await JastisApi.dio.get('/task/$taskId/sent');
      response = ResponseModel<List<TaskUserModel>>.fromJson(result.data);

      if (response.success) {
        response.data = result.data['data']
            .map<TaskUserModel>((data) => TaskUserModel.fromJson(data))
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

  static Future<ResponseModel<TaskUserModel>> findSentTask(
      String userId, TaskModel task) async {
    ResponseModel<TaskUserModel> response;
    try {
      var result = await JastisApi.dio.get(
        '/user/$userId/find_st',
        queryParameters: {
          'task_id': task.id,
        },
      );
      response = ResponseModel<TaskUserModel>.fromJson(result.data);

      if (result.data['data'] != null) {
        response.data = TaskUserModel.fromJson(result.data['data']);
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
