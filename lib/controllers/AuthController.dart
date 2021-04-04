part of 'controllers.dart';

class AuthController extends GetxController {
  final store = GetStorage();
  static AuthController to = Get.find();
  GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var user = UserModel().obs;
  var valMsg = ''.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    super.onReady();
  }

  @override
  void onClose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();

    super.onClose();
  }

  //Method to handle user sign in using email and password
  Future<ResponseModel<UserModel>> login(BuildContext context) async {
    ResponseModel<UserModel> response;

    OverlayScreen().show(context);
    try {
      response = await ApiJastis.login({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      if (response.success) {
        emailController.clear();
        passwordController.clear();

        await store.write('token', response.token);
        await store.write('user', jsonEncode(response.data));

        user.value = response.data;

        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on signin',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
      );
    }

    OverlayScreen().pop();

    return response;
  }

  Future<ResponseModel<UserModel>> register(BuildContext context) async {
    ResponseModel<UserModel> response;

    OverlayScreen().show(context);
    try {
      response = await ApiJastis.register({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      if (response.success) {
        await store.write('token', response.token);
        await store.write('user', jsonEncode(response.data));

        user.value = response.data;

        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on signin',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
      );
    }

    OverlayScreen().pop();

    return response;
  }

  Future<ResponseModel> logout(BuildContext context) async {
    ResponseModel response;
    clearFieldController();
    OverlayScreen().show(context);
    try {
      String token = await store.read('token');
      response = await ApiJastis.logout(token);

      if (response.success) {
        await store.remove('token');
        await store.remove('user');
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
    }

    OverlayScreen().pop();

    return response;
  }

  Future<ResponseModel<UserModel>> googleLogin(BuildContext context) async {
    ResponseModel<UserModel> response;

    OverlayScreen().show(context);
    try {
      final result = await _googleSignIn.signIn();
      final ggAuth = await result.authentication;
      response = await ApiJastis.googleLogin(ggAuth.accessToken);
      if (response.success) {
        await store.write('token', response.token);
        await store.write('user', jsonEncode(response.data));

        user.value = response.data;

        clearFieldController();
      } else {
        valMsg.value = response.message;
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error on signin',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
      );
    }
    OverlayScreen().pop();

    return response;
  }

  // Sign out
  void clearFieldController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    valMsg.value = '';
  }
}
