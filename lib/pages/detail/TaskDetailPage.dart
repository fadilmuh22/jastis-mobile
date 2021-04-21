part of '../pages.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({
    Key key,
    @required this.task,
  }) : super(key: key);

  TaskModel task;

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final AuthController _auth = AuthController.to;
  final KelasController _kelasc = KelasController.to;

  final _formSubmitKey = GlobalKey<FormState>();
  final _formScoreKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _kelasc.listLink.clear();
      _kelasc.sentTask.value = null;
      _findSentTask();
      _getSentTaskTeach();
    });
  }

  Future _findSentTask() async {
    await _kelasc.findSentTask(context, widget.task);
  }

  Future _getSentTaskTeach() async {
    await _kelasc.getSentTaskTeach(context, widget.task.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onAppBarActions(String action) async {
    switch (action) {
      case 'Edit':
        bool back = await Get.to(() => CreateTask(task: widget.task)) ?? false;

        if (back) {
          Get.back();
        }
        break;
      case 'Selesai':
        var task = widget.task;
        task.data = _kelasc.listLink.value;
        if (_kelasc.sentTask.value.id == null) {
          var response = await _kelasc.sendTask(context, task);
        } else {
          var response = await _kelasc.updateSentTask(context, task);
        }
        break;
      case 'Delete':
        var response = await _kelasc.deleteTask(context, widget.task);
        if (response.success) {
          Get.back();
          Get.back();
        }
        break;
      default:
    }
  }

  Set<String> _getTaskAction(TaskModel task) {
    if (task.userId != _auth.user.value.id) {
      return {'Selesai'};
    } else {
      return {'Edit', 'Delete'};
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _submitTugasMBS(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (builder) {
        return Container(
          height: 300,
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
              key: _formSubmitKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tambah file tugas',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 41),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Link file',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextFormField(
                        controller: _kelasc.tugasController,
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Link tidak boleh kosong';
                          }
                        },
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
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
                          if (_formSubmitKey.currentState.validate()) {
                            _kelasc.addLink();
                            _kelasc.tugasController.clear();
                            Get.back();
                          }
                        },
                        child: Text(
                          'Submit',
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

  Future _updateScoreMBS(BuildContext context, TaskUserModel tu) {
    _kelasc.scoreController.text = tu.score == null ? "" : tu.score.toString();
    return showModalBottomSheet(
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
              key: _formScoreKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update Score ${tu.users.name}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 21),
                  tu.data.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada file tugas yang dikirimkan',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: tu.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                onTap: () {
                                  _launchInBrowser(tu.data[index]);
                                },
                                leading: Icon(Icons.link),
                                title: Text('${tu.data[index]}'),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextFormField(
                        controller: _kelasc.scoreController,
                        keyboardType: TextInputType.number,
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
                            return 'Score tidak boleh kosong';
                          }
                        },
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Color(0xFF7E7D7D),
                                fontSize: 12,
                              ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formScoreKey.currentState.validate()) {
                            _kelasc
                                .updateSentTaskScore(context, tu.id)
                                .then((value) {
                              _kelasc.scoreController.clear();
                              Navigator.of(context).pop(true);
                            });
                          }
                        },
                        child: Text(
                          'Submit',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF5E5454),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detail Task',
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _onAppBarActions,
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (BuildContext context) {
              return _getTaskAction(widget.task).map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }).toList();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: _taskDetailListView(context),
    );
  }

  ListView _taskDetailListView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Image.asset(
          'assets/img/join_img.png',
          width: 343,
          height: 256,
        ),
        SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.task.title} (${widget.task.kelas.name})',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 4),
            Text(
              '${widget.task.desc}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        SizedBox(height: 31),
        _submitTask(context),
        SizedBox(height: 31),
        if (widget.task.userId == _auth.user.value.id) _studentTasks(context),
      ],
    );
  }

  Widget _submitTask(BuildContext context) {
    return Obx(() {
      if (_kelasc.isLoadingSentTask.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kelasc.listLink.value == null || _kelasc.listLink.value.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: 14.0),
                  child: Center(
                    child: Text(
                      'Belum ada file tugas',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              : Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _kelasc.listLink.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 6),
                          onTap: () {
                            _launchInBrowser(_kelasc.listLink[index]);
                          },
                          leading: Icon(Icons.link),
                          title: Text('${_kelasc.listLink[index]}'),
                          trailing: IconButton(
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // ignore: invalid_use_of_protected_member
                              _kelasc.listLink.removeAt(index);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${_kelasc.sentTask.value.score ?? 0}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Constants.kPrimaryColor,
                      ),
                ),
                Text(
                  'Your Score',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _submitTugasMBS(context);
              },
              child: Text(
                'Tambah file tugas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Constants.kPrimaryColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: Constants.kDefaultPadding),
                primary: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 31),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                var task = widget.task;
                task.data = _kelasc.listLink.value;
                if (_kelasc.sentTask.value.id == null) {
                  var response = await _kelasc.sendTask(context, task);
                } else {
                  var response = await _kelasc.updateSentTask(context, task);
                }
              },
              child: Text(
                '${_kelasc.sentTask.value.id == null ? 'Kumpulkan' : 'Kumpulkan ulang'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: Constants.kDefaultPadding),
                primary: Constants.kPrimaryColor,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _studentTasks(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tugas yang sudah dikumpulkan',
          style: Theme.of(context).textTheme.caption,
        ),
        Obx(() {
          if (_kelasc.isLoadingSentTaskTeach.value) {
            return Center(child: CircularProgressIndicator());
          }
          return _kelasc.listSentTaskTeach.value == null ||
                  _kelasc.listSentTaskTeach.isEmpty
              ? Container(
                  height: 36,
                  child: Center(
                    child: Text(
                      'Belum ada yang mengumpulkan tugas',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _kelasc.listSentTaskTeach.length,
                  itemBuilder: (context, index) {
                    return listTileSentTask(
                        context, _kelasc.listSentTaskTeach[index]);
                  },
                );
        }),
      ],
    );
  }

  Widget listTileSentTask(BuildContext context, TaskUserModel tu) {
    return GestureDetector(
      onTap: () async {
        bool refresh = await _updateScoreMBS(context, tu) ?? false;
        if (refresh) {
          Future.delayed(Duration(seconds: 1), () async {
            _findSentTask();
            _getSentTaskTeach();
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 3,
          child: Container(
            width: 3,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${tu.users.name}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${tu.updatedAt}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${tu.score ?? '0'}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
