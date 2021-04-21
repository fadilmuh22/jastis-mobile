part of 'controllers.dart';

class KelasController extends GetxController {
  final store = GetStorage();
  static KelasController to = Get.find();
  final AuthController _auth = AuthController.to;

  var codeController = TextEditingController();
  var tugasController = TextEditingController();
  var scoreController = TextEditingController();

  var listKelas = <KelasModel>[].obs;
  var teachingKelas = <KelasModel>[].obs;
  var joinedKelas = <KelasModel>[].obs;

  var listTask = <TaskModel>[].obs;
  var listTaskKelas = <TaskModel>[].obs;

  var listSentTask = <TaskUserModel>[].obs;
  var listSentTaskTeach = <TaskUserModel>[].obs;
  var sentTask = TaskUserModel().obs;
  var listLink = [].obs;

  var isLoadingKelas = false.obs;
  var isLoadingTask = false.obs;

  var isLoadingSentTask = false.obs;
  var isLoadingSentTaskTeach = false.obs;

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addLink() {
    listLink.add(tugasController.text.trim());
  }

  Future<ResponseModel<List<KelasModel>>> getKelas(BuildContext context) async {
    ResponseModel<List<KelasModel>> response =
        ResponseModel<List<KelasModel>>();
    isLoadingKelas.value = true;
    try {
      response = await KelasApi.getKelas(_auth.user.value);

      if (response.success) {
        listKelas.value = response.data;

        teachingKelas.value = List<KelasModel>.from(
            response.data.where((e) => e.role == 'guru' || e.role == 'owner'));
        joinedKelas.value = List<KelasModel>.from(
            response.data.where((e) => e.role == 'murid'));
      }
    } catch (error) {
      isLoadingKelas.value = false;
      Get.snackbar(
        'Error',
        'Error on getKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoadingKelas.value = false;
    }

    return response;
  }

  Future<ResponseModel<List<TaskModel>>> getTask(BuildContext context) async {
    ResponseModel<List<TaskModel>> response = ResponseModel<List<TaskModel>>();
    isLoadingTask.value = true;
    try {
      response = await KelasApi.getTask(_auth.user.value);

      if (response.success) {
        // ignore: invalid_use_of_protected_member
        listTask.value = response.data;
      }
    } catch (error) {
      isLoadingTask.value = false;
      Get.snackbar(
        'Error',
        'Error on getTask',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoadingTask.value = false;
    }

    return response;
  }

  Future<ResponseModel> deleteKelas(
      BuildContext context, KelasModel kelas) async {
    ResponseModel response = ResponseModel();

    bool delete = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              content: Text(
                'Semua record di kelas ini akan dihapus secara permanen',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.red),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (delete) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.deleteKelas(kelas);

        if (response.success) {
          getKelas(context);
          Get.snackbar(
            'Success',
            'Success on deleteKelas',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on deleteKelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel> joinKelas(BuildContext context) async {
    ResponseModel response = ResponseModel();
    OverlayScreen().show(context);
    try {
      KelasModel join = KelasModel(
        code: codeController.text.trim(),
        userId: _auth.user.value.id,
      );
      response = await KelasApi.joinKelas(join);

      if (response.success) {
        getKelas(context);
      } else {}
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on joinKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  Future<ResponseModel> leaveKelas(
      BuildContext context, KelasModel kelas, String userId) async {
    ResponseModel response = ResponseModel();

    bool leave = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              content: Text(
                'Anda tidak akan terhubung lagi dengan kelas ini',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.red),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (leave) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.leaveKelas(kelas, userId);

        if (response.success) {
          getKelas(context);
          Get.snackbar(
            'Success',
            'Success on leaveKelas',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on leaveKelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel> deleteTask(BuildContext context, TaskModel task) async {
    ResponseModel response = ResponseModel();

    bool delete = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              content: Text(
                'Semua record di task ini akan dihapus secara permanen',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.red),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (delete) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.deleteTask(task);

        if (response.success) {
          getTask(context);
          Get.snackbar(
            'Success',
            'Success on deleteTask',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on deleteTask',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel<List<TaskModel>>> kelasTask(
      BuildContext context, KelasModel kelas) async {
    ResponseModel<List<TaskModel>> response = ResponseModel();

    isLoadingTask.value = true;

    try {
      response = await KelasApi.kelasTask(kelas);

      if (response.success && response.data != null) {
        listTaskKelas.value = response.data;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on kelasTask',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      isLoadingTask.value = false;
    }

    return response;
  }

  Future<ResponseModel> sendTask(BuildContext context, TaskModel task) async {
    ResponseModel response = ResponseModel();

    bool send = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (send) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.sendTask(task, _auth.user.value.id);

        if (response.success) {
          getTask(context);
          Get.snackbar(
            'Success',
            'Success on sendTask',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on sendTask',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel> updateSentTask(
      BuildContext context, TaskModel task) async {
    ResponseModel response = ResponseModel();

    bool send = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (send) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.updateSentTask(task, sentTask.value.id);

        if (response.success) {
          getTask(context);
          Get.snackbar(
            'Success',
            'Success on updateSentTask',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on updateSentTask',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel> updateSentTaskScore(
      BuildContext context, String sentTaskId) async {
    ResponseModel response = ResponseModel();

    bool send = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah anda yakin?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (send) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.updateSentTaskScore(
            int.parse(scoreController.text.trim()), sentTaskId);

        if (response.success) {
          getTask(context);
          Get.snackbar(
            'Success',
            'Success on updateSentTaskScore',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {}
      } catch (error) {
        Get.snackbar(
          'Error',
          'Error on updateSentTaskScore',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        await Future.delayed(Duration(seconds: 2))
            .then((value) => OverlayScreen().pop());
      }
    }

    return response;
  }

  Future<ResponseModel<List<TaskUserModel>>> getSentTask(
    BuildContext context,
  ) async {
    ResponseModel<List<TaskUserModel>> response = ResponseModel();

    isLoadingSentTask.value = true;

    try {
      response = await KelasApi.getSentTask(_auth.user.value.id);

      if (response.success) {
        listSentTask.value = response.data;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on getSentTaskUser',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      isLoadingSentTask.value = false;
    }

    return response;
  }

  Future<ResponseModel<List<TaskUserModel>>> getSentTaskTeach(
      BuildContext context, String taskId) async {
    ResponseModel<List<TaskUserModel>> response = ResponseModel();

    isLoadingSentTaskTeach.value = true;

    try {
      response = await KelasApi.getSentTaskTeach(taskId);

      if (response.success) {
        listSentTaskTeach.value = response.data;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on getSentTaskKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      isLoadingSentTaskTeach.value = false;
    }

    return response;
  }

  Future<ResponseModel<TaskUserModel>> findSentTask(
      BuildContext context, TaskModel task) async {
    ResponseModel<TaskUserModel> response = ResponseModel();

    isLoadingSentTask.value = true;

    try {
      response = await KelasApi.findSentTask(_auth.user.value.id, task);

      if (response.data != null) {
        sentTask.value = response.data;
        if (sentTask.value.data != null) {
          listLink.value = sentTask.value.data;
        }
      } else {
        listLink.value = [];
        sentTask.value = TaskUserModel();
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on findSentTaskUser',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      isLoadingSentTask.value = false;
    }

    return response;
  }
}
