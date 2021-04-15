part of 'controllers.dart';

class CreateController extends GetxController {
  final store = GetStorage();
  static CreateController to = Get.find();
  final AuthController _auth = AuthController.to;

  TextEditingController nameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var valMsg = ''.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    super.onReady();
  }

  @override
  void onClose() {
    nameController?.dispose();
    subjectController?.dispose();
    descriptionController?.dispose();

    super.onClose();
  }

  Future<ResponseModel> createKelas(BuildContext context) async {
    ResponseModel response = ResponseModel();

    OverlayScreen().show(context);
    try {
      KelasModel kelas = KelasModel(
        name: nameController.text.trim(),
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
        'Error on logout',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
      );
    } finally {
      OverlayScreen().pop();
    }

    return response;
  }

  void clearFieldController() {
    nameController.clear();
    subjectController.clear();
    descriptionController.clear();

    valMsg.value = '';
  }
}
