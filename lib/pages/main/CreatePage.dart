part of '../pages.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>
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

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Text(
              'Create',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 40),
            _buildTabBar(),
          ],
        ),
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
        Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 30,
          ),
          child: [
            _createClassTab(),
            _createTaskTab(),
            _createEventTab(),
          ][_tabIndex],
        ),
      ],
    );
  }

  Widget _createClassTab() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ClassName',
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject',
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.caption,
            ),
            TextField(
              maxLines: 8,
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
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFBA68C8),
              ),
            ),
            SizedBox(width: 11),
            ElevatedButton(
              onPressed: () {},
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                primary: Constants.kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createTaskTab() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Name',
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Due',
              style: Theme.of(context).textTheme.caption,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E5E5),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.caption,
            ),
            TextField(
              maxLines: 8,
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
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFBA68C8),
              ),
            ),
            SizedBox(width: 11),
            ElevatedButton(
              onPressed: () {},
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                primary: Constants.kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createEventTab() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Name',
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
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Due',
              style: Theme.of(context).textTheme.caption,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E5E5),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.caption,
            ),
            TextField(
              maxLines: 8,
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
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFBA68C8),
              ),
            ),
            SizedBox(width: 11),
            ElevatedButton(
              onPressed: () {},
              child: Text('Create'),
              style: ElevatedButton.styleFrom(
                primary: Constants.kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
