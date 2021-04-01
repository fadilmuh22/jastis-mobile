part of '../pages.dart';

class MainTabPage extends StatefulWidget {
  @override
  _MainTabPageState createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int _selectedIndex = 0;
  Widget _widgetOptions() {
    switch (_selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return ListPage();
    }
    return Container();
  }

  void _onItemTapped(context, int index) {
    if (index == 2) {
      showBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Colors.grey[900],
          height: 250,
        ),
      );
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
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
          icon: Icon(Icons.person),
          onPressed: () {},
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
              _joinMBS();
            },
            color: Color(0xFF5E5454),
          ),
        ],
      ),
      drawer: CustomDrawer(
        context: context,
      ),
      body: _widgetOptions(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Constants.kPrimaryColor,
        unselectedItemColor: Colors.black,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  void _joinMBS() {
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
                      'Username',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE5E5E5),
                      ),
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
                      onPressed: () {},
                      child: Text(
                        'Join',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Color(0xFF624D9E),
                              fontSize: 12,
                            ),
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

  void _eventDetailMBS() {
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
                        primary: Color(0xFF624D9E),
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
