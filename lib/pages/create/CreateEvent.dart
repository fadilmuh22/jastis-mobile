part of '../pages.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final CreateController _createc = CreateController.to;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCancel() {
    _createc.clearFieldController();
    Navigator.pop(context);
  }

  Future _createEvent() async {
    if (_formKey.currentState.validate()) {
      ResponseModel response = await _createc.createEvent(context);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success creating event',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => Navigator.pop(context));
      }
    }
  }

  void _onDate(String value) {
    _createc.eventForm.value.selectedDate = DateTime.parse(value);
    _createc.eventForm.value.date.text = value;
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
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: _createc.eventForm.value.date.text,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                onChanged: (val) => _onDate(val),
                onSaved: (val) => _onDate(val),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Date can\'t be empty';
                  }
                },
              ),
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
