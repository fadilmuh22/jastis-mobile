part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final store = GetStorage();
  final _formKey = GlobalKey<FormState>();
  final AuthController _auth = AuthController.to;

  Future _login(context) async {
    ResponseModel<UserModel> response = await _auth.login(context);
    if (response.success) {
      store.write('user', json.encode(response.data));
      store.write('token', response.token);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainTabPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 38),
        children: [
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/school_logo.png',
                width: 173,
                height: 173,
              ),
            ],
          ),
          SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextFormField(
                      controller: _auth.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE5E5E5),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
                SizedBox(height: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextFormField(
                      controller: _auth.passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE5E5E5),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Obx(() {
                      return Text(
                        '${_auth.valMsg.value}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                      );
                    }),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Color(0xFF624D9E),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Constants.kDefaultPadding),
          ElevatedButton(
            onPressed: () {
              _login(context);
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding:
                  EdgeInsets.symmetric(vertical: Constants.kDefaultPadding),
              primary: Color(0xFF624D9E),
            ),
          ),
          SizedBox(height: 31),
          Column(
            children: [
              Text(
                'Or login with',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.41),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Constants.kDefaultPadding),
              IconButton(
                constraints: BoxConstraints(),
                icon: Image.asset(
                  'assets/img/google_logo.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainTabPage()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
