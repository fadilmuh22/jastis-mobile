part of '../pages.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TabController _tabController;

  final AuthController _auth = AuthController.to;
  UserModel _user;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    _user = _auth.user.value;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  Future<bool> _onWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Unsaved data will be lost.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(
            bottom: 30,
            left: 30,
            right: 30,
          ),
          children: [
            _buildTabBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Center(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Constants.kPrimaryColor,
              unselectedLabelColor: Color(0xFFCDCDCD),
              labelStyle: Theme.of(context).textTheme.headline2,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: 'Class'),
                Tab(text: 'Task'),
                Tab(text: 'Event'),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: [
            _listClassTab(context),
            _listTaskTab(context),
            _listEventTab(context),
          ][_tabIndex],
        ),
      ],
    );
  }

  Widget _listClassTab(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _user.kelas.length,
      itemBuilder: (context, index) {
        return listTileTask(_user.kelas[index], context);
      },
    );
  }

  Widget listTileTask(KelasModel kelas, BuildContext context) {
    return GestureDetector(
      onTap: () => OverlayScreen().show(context),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 3,
          child: Container(
            width: 3,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Constants.kPrimaryColor,
                  width: 3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${kelas.name}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 12),
                    ),
                    Text(
                      '${kelas.userId}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTaskTab(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _user.kelas.length,
      itemBuilder: (context, index) {
        return listTileTask(_user.kelas[index], context);
      },
    );
  }

  Widget _listEventTab(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _user.kelas.length,
      itemBuilder: (context, index) {
        return listTileTask(_user.kelas[index], context);
      },
    );
  }
}
