part of '../pages.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent>
    with SingleTickerProviderStateMixin {
  final CreateController _createc = CreateController.to;

  final _formKey = GlobalKey<FormState>();

  int _tabIndex = 0;
  TabController _tabController;

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

  void _onCancel() {
    _createc.clearFieldController();
    Navigator.pop(context);
  }

  Future _createEvent() async {
    if (_formKey.currentState.validate() &&
        _createc.taskForm.value.date.text.isEmpty) {
      ResponseModel response = await _createc.createEvent(context);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success creating event',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _createc.clearFieldController();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: [
              Text(
                'Create Event',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 40),
              _createEventTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createEventTab() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Name',
                style: Theme.of(context).textTheme.caption,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _createc.eventForm.value.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E5E5),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name can\'t be empty';
                  }
                },
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
                onTap: () => selectDate(context, _createc.eventForm.value),
                child: TextFormField(
                  style: Theme.of(context).textTheme.caption,
                  enabled: false,
                  controller: _createc.eventForm.value.date,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFE5E5E5),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Due can\'t be empty';
                    }
                  },
                ),
              ),
              Obx(() {
                if (_createc.eventForm.value.date.text.isEmpty)
                  return Text(
                    'Due can\'t be empty',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                  );
                return Container();
              }),
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
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                maxLines: 8,
                controller: _createc.eventForm.value.desc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E5E5),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name can\'t be empty';
                  }
                },
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _onCancel,
                child: Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFBA68C8),
                ),
              ),
              SizedBox(width: 11),
              ElevatedButton(
                onPressed: () {
                  _createEvent();
                },
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  primary: Constants.kPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
