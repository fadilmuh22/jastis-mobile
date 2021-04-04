part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final store = GetStorage();
  final AuthController _auth = AuthController.to;
  final splashDelay = 1;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    String intro = await store.read('intro') ?? 'none';
    if (intro == 'none') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => IntroPage()));
    } else {
      var userString = await store.read('user');
      if (userString != null) {
        UserModel user = UserModel.fromJson(jsonDecode(userString));
        _auth.user.value = user;
        ApiJastis.setAuthToken(await store.read('token'));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainTabPage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Jastis',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Text(
                          'Permudah proses belajar kapan saja, dimana saja.',
                          style: TextStyle(
                            color: Constants.kPrimaryColor.withOpacity(.55),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                Expanded(
                  flex: 5,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/img/splash_img.png',
                        height: 300,
                        width: 300,
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
