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

class _CreateTaskState extends State<CreateTask>
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

    if (widget.task != null) {
      _createc.taskForm.value.title.text = widget.task.title;
      _createc.taskForm.value.selectedDate = widget.task.dateEnd;
      _createc.taskForm.value.date.text = widget.task.dateEnd.toIso8601String();
      _createc.taskForm.value.desc.text = widget.task.desc;
    }
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

  Future _createTask() async {
    assert(!(_formKey.currentState.validate() &&
        _createc.taskForm.value.date.text.isEmpty));
    if (_formKey.currentState.validate() &&
        _createc.taskForm.value.date.text.isEmpty) {
      ResponseModel response = await _createc.createTask(context);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success creating task',
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
                'Create Tugas',
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
              GestureDetector(
                onTap: () {
                  selectDate(context, _createc.taskForm.value);
                },
                child: TextFormField(
                  style: Theme.of(context).textTheme.caption,
                  enabled: false,
                  controller: _createc.taskForm.value.date,
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
                if (_createc.taskForm.value.date.text.isEmpty) {
                  return Text(
                    'Due can\'t be empty',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                  );
                }
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
                  _createTask();
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
