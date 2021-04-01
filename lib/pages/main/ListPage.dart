part of '../pages.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TabController _tabController;

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Color(0xFF5E5454),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     'List',
      //     style: Theme.of(context).textTheme.headline2,
      //   ),
      //   centerTitle: true,
      // ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [],
      ),
    );
  }

  Widget _buildTabBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Color(0xFF624D9E),
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
        Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 30,
          ),
          child: [
            _listClassTab(),
            _listTaskTab(),
            _listEventTab(),
          ][_tabIndex],
        ),
      ],
    );
  }

  Widget _listClassTab() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 3,
              decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Constants.kPrimaryColor,
                      width: 3,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(6)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _listTaskTab() {
    return Column();
  }

  Widget _listEventTab() {
    return Column();
  }
}
