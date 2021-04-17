part of '../pages.dart';

class MainTabPage extends StatefulWidget {
  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ScreenController _screenc = ScreenController.to;
  final KelasController _kelasc = KelasController.to;

  final _formKey = GlobalKey<FormState>();

  Future _join(context) async {
    if (_formKey.currentState.validate()) {
      ResponseModel response = await _kelasc.joinKelas(context);
      if (response.success) {
        Navigator.pop(context);

        Get.snackbar(
          'Success',
          'Success on joinKelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
        );
      }
    }
  }

  Widget _widgetOptions(BuildContext context) {
    return Obx(() {
      switch (_screenc.tabIndex.value) {
        case 0:
          return HomePage();
        case 1:
          return ListPage();
      }
      return Container();
    });
  }

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getKelas().whenComplete(() => {});
    _getTask().whenComplete(() => {});
  }

  Future _getKelas() async {
    await _kelasc.getKelas(context);
  }

  Future _getTask() async {
    await _kelasc.getTask(context);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("MMM yyyy");
    String currentDateString = dateFormat.format(DateTime.now());

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF5E5454),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: openDrawer,
          color: Colors.blue,
        ),
        title: Text(
          '$currentDateString',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _joinMBS(context);
            },
            color: Color(0xFF5E5454),
          ),
        ],
      ),
      drawer: CustomDrawer(
        context: context,
        moreClassOnTap: () {
          _screenc.onTabTapped(1);
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'main-tab',
        tooltip: 'Create kelas',
        child: Icon(Icons.add),
        onPressed: () async {
          Get.to(CreateKelas());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _widgetOptions(context),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Task',
            ),
          ],
          currentIndex: _screenc.tabIndex.value,
          selectedItemColor: Constants.kPrimaryColor,
          unselectedItemColor: Colors.black,
          onTap: (index) => _screenc.onTabTapped(index),
        );
      }),
    );
  }

  void _joinMBS(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (builder) {
        return Container(
          height: 500,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Class',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 41),
                  Center(
                    child: Image.asset(
                      'assets/img/join_img.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Class Code',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextFormField(
                        controller: _kelasc.codeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xFFE5E5E5),
                        ),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Color(0xFF7E7D7D),
                                fontSize: 12,
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _join(context);
                        },
                        child: Text(
                          'Join',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Constants.kPrimaryColor,
                                fontSize: 12,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _eventDetailMBS(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (builder) {
        return Container(
          height: 600,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: Constants.kPrimaryColor,
                      width: 59,
                      height: 59,
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created By',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          'Fadil Muh',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Event Name',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      color: Constants.kPrimaryColor,
                      width: 59,
                      height: 59,
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thu, 18 May 2020',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '10 AM to 12 PM',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      color: Constants.kPrimaryColor,
                      width: 59,
                      height: 59,
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Zoom',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet.',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Event Detail',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Convallis quis ac id blandit nibh rhoncus platea. Amet tellus, blandit viverra tincidunt ipsum ut. Tincidunt ipsum arcu aliquam eget ultricies a.',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Join Event',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 39,
                        ),
                        primary: Constants.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
