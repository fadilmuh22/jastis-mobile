part of 'controllers.dart';

class CreateController extends GetxController {
  final store = GetStorage();
  static CreateController to = Get.find();
  final AuthController _auth = AuthController.to;
  final KelasController _kelasc = KelasController.to;

  var kelasForm = KelasFormModel().obs;
  var taskForm = TaskFormModel().obs;
  var eventForm = EventFormModel().obs;

  var valMsg = ''.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    super.onReady();
    kelasForm.value = KelasFormModel();
    taskForm.value = TaskFormModel();
    eventForm.value = EventFormModel();
  }

  @override
  void onClose() {
    kelasForm.value.clear();
    taskForm.value.clear();
    eventForm.value.clear();

    super.onClose();
  }

  Future<ResponseModel> createKelas(BuildContext context) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      KelasModel kelas = KelasModel(
        name: kelasForm.value.name.text.trim(),
        subject: kelasForm.value.subject.text.trim(),
        desc: kelasForm.value.desc.text.trim(),
        userId: _auth.user.value.id,
      );

      response = await KelasApi.createKelas(kelas);

      if (response.success) {
        clearFieldController();
        _kelasc.getKelas(context);
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on createKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  Future<ResponseModel> updateKelas(BuildContext context, String id) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      KelasModel kelas = KelasModel(
        id: id,
        name: kelasForm.value.name.text.trim(),
        subject: kelasForm.value.subject.text.trim(),
        desc: kelasForm.value.desc.text.trim(),
        userId: _auth.user.value.id,
      );

      response = await KelasApi.updateKelas(kelas);

      if (response.success) {
        clearFieldController();
        _kelasc.getKelas(context);
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on updateKelas',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  Future<ResponseModel> createTask(
      BuildContext context, KelasModel kelas) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      TaskModel task = TaskModel(
        title: taskForm.value.title.text.trim(),
        desc: taskForm.value.desc.text.trim(),
        dateEnd: taskForm.value.selectedDate,
        kelasId: kelas.id,
        userId: _auth.user.value.id,
      );

      response = await KelasApi.createTask(task);

      if (response.success) {
        clearFieldController();
        _kelasc.getTask(context);
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on createTask',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  Future<ResponseModel> updateTask(
      BuildContext context, String id, String kelasId) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      TaskModel task = TaskModel(
        id: id,
        title: taskForm.value.title.text.trim(),
        desc: taskForm.value.desc.text.trim(),
        dateEnd: taskForm.value.selectedDate,
        kelasId: kelasId,
        userId: _auth.user.value.id,
      );

      response = await KelasApi.updateTask(task);

      if (response.success) {
        clearFieldController();
        _kelasc.getTask(context);
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on updateTask',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  Future<ResponseModel> createEvent(BuildContext context) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      KelasModel kelas = KelasModel(
        name: eventForm.value.name.text.trim(),
        userId: _auth.user.value.id,
      );

      response = await KelasApi.createKelas(kelas);

      if (response.success) {
        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on createEvent',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } finally {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => OverlayScreen().pop());
    }

    return response;
  }

  void clearFieldController() {
    kelasForm.value.clear();
    taskForm.value.clear();
    eventForm.value.clear();

    valMsg.value = '';
  }
}

class KelasFormModel {
  TextEditingController name = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController desc = TextEditingController();

  void clear() {
    name.clear();
    subject.clear();
    desc.clear();
  }
}

class TaskFormModel {
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController desc = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void clear() {
    title.clear();
    date.clear();
    subject.clear();
    desc.clear();

    selectedDate = DateTime.now();
  }
}

class EventFormModel {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController desc = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void clear() {
    name.clear();
    date.clear();
    subject.clear();
    desc.clear();

    selectedDate = DateTime.now();
  }
}
