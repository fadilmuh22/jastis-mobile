part of 'controllers.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
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

    valMsg.value = '';
    showLoadingIndicator(context);
    try {
      response = await ApiJastis.login({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      if (response.success) {
        emailController.clear();
        passwordController.clear();

        user.update((val) {
          val = response.data;
        });
      } else {
        valMsg.value = response.message;
      }
      hideLoadingIndicator();
      return response;
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'Error',
        'Error on signin',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
      );
    }

    return response;
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator(context);
    try {
      // await _auth
      //     .createUserWithEmailAndPassword(
      //         email: emailController.text, password: passwordController.text)
      //     .then((result) async {
      //   print('uID: ' + result.user.uid);
      //   print('email: ' + result.user.email);
      //   UserModel _newUser = UserModel(
      //       uid: result.user.uid,
      //       email: result.user.email,
      //       name: nameController.text,
      //       photoUrl: gravatarUrl);
      //   //create the user in firestore
      //   _createUserFirestore(_newUser, result.user);
      //   emailController.clear();
      //   passwordController.clear();
      //   hideLoadingIndicator();
      // });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'Error',
        'Error on register',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
      );
    }
  }

  //handles updating the user when updating profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    try {
      showLoadingIndicator(context);
      // await _auth
      //     .signInWithEmailAndPassword(email: oldEmail, password: password)
      //     .then((_firebaseUser) {
      //   _firebaseUser.user
      //       .updateEmail(user.email)
      //       .then((value) => _updateUserFirestore(user, _firebaseUser.user));
      // });
      hideLoadingIndicator();
      Get.snackbar(
        'Success',
        'Error on update user',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      hideLoadingIndicator();
      Get.snackbar(
        'Error',
        'Error on update user',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
      );
    }
  }

  // Sign out
  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    // return _auth.signOut();
  }
}
