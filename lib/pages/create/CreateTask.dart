part of '../pages.dart';

class CreateTask extends StatefulWidget {
  CreateTask({
    Key key,
    this.task,
    this.kelas,
  }) : super(key: key);

  final TaskModel task;
  final KelasModel kelas;

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final CreateController _createc = CreateController.to;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _createc.taskForm.value.title.text = widget.task.title;
      _createc.taskForm.value.selectedDate = widget.task.dateEnd;
      _createc.taskForm.value.date.text = widget.task.dateEnd.toIso8601String();
      _createc.taskForm.value.desc.text = widget.task.desc;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCancel() {
    _createc.clearFieldController();
    Navigator.pop(context);
  }

  Future _createTask() async {
    if (_formKey.currentState.validate() &&
        _createc.taskForm.value.date.text.isNotEmpty) {
      ResponseModel response = await _createc.createTask(context, widget.kelas);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success creating task',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        await Future.delayed(Duration(seconds: 2))
            .then((value) => Navigator.pop(context));
      }
    }
  }

  Future _updateTask() async {
    if (_formKey.currentState.validate()) {
      ResponseModel response = await _createc.updateTask(
        context,
        widget.task.id,
        widget.task.kelasId,
      );
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success updating task',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        await Future.delayed(Duration(seconds: 2))
            .then((value) => Navigator.of(context).pop(true));
      }
    }
  }

  void _onDate(String value) {
    _createc.taskForm.value.selectedDate = DateTime.parse(value);
    _createc.taskForm.value.date.text = value;
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
                '${widget.task == null ? 'Create' : 'Update'} Tugas',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 40),
              _createTaskTab(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTaskTab(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Name',
                style: Theme.of(context).textTheme.caption,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _createc.taskForm.value.title,
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
                initialValue: _createc.taskForm.value.date.text,
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
                controller: _createc.taskForm.value.desc,
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
                    return 'Description can\'t be empty';
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
                  if (widget.task == null) {
                    _createTask();
                  } else {
                    _updateTask();
                  }
                },
                child: Text('${widget.task == null ? 'Create' : 'Update'}'),
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
