part of 'controllers.dart';

class KelasController extends GetxController {
  final store = GetStorage();
  static KelasController to = Get.find();
  final AuthController _auth = AuthController.to;

  TextEditingController codeController = TextEditingController();

  RxList<KelasModel> listKelas = <KelasModel>[].obs;
  RxList<KelasModel> teachingKelas = <KelasModel>[].obs;
  RxList<KelasModel> joinedKelas = <KelasModel>[].obs;

  RxList<TaskModel> listTask = <TaskModel>[].obs;

  var isLoadingKelas = false.obs;
  var isLoadingTask = false.obs;

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
        duration: Duration(seconds: 7),
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
        duration: Duration(seconds: 7),
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
          Get.snackbar(
            'Success',
            'Success on deleteKelas',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 7),
          );
        } else {}
      } catch (error) {
        OverlayScreen().pop();
        Get.snackbar(
          'Error',
          'Error on deleteKelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        OverlayScreen().pop();
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
      } else {}
    } catch (error) {
      OverlayScreen().pop();
      Get.snackbar(
        'Error',
        'Error on joinKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
      );
    } finally {
      OverlayScreen().pop();
    }

    return response;
  }

  Future<ResponseModel> leaveKelas(
      BuildContext context, KelasModel kelas, String userId) async {
    ResponseModel response = ResponseModel();

    bool delete = await showDialog(
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

    if (delete) {
      OverlayScreen().show(context);
      try {
        response = await KelasApi.leaveKelas(kelas, userId);

        if (response.success) {
          Get.snackbar(
            'Success',
            'Success on leaveKelas',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 7),
          );
        } else {}
      } catch (error) {
        OverlayScreen().pop();
        Get.snackbar(
          'Error',
          'Error on leaveKelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.red.withOpacity(.6),
          colorText: Colors.white,
        );
      } finally {
        OverlayScreen().pop();
      }
    }

    return response;
  }
}
