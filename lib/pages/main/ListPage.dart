part of '../pages.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final AuthController _auth = AuthController.to;
  final KelasController _kelasc = KelasController.to;
  final ScreenController _screenc = ScreenController.to;

  UserModel _user;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
      _screenc.listPageTabIndex.value = _tabController.index;
    }
  }

  // Future<bool> _onWillPop(BuildContext context) {
  //   return showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Are you sure?'),
  //             content: Text('Unsaved data will be lost.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () => Navigator.of(context).pop(false),
  //                 child: Text('No'),
  //               ),
  //               TextButton(
  //                 onPressed: () => Navigator.of(context).pop(true),
  //                 child: new Text('Yes'),
  //               ),
  //             ],
  //           );
  //         },
  //       ) ??
  //       false;
  // }

  void _onKelasAction(String action, KelasModel kelas) async {
    switch (action) {
      case 'Edit':
        Get.to(() => CreateKelas(kelas: kelas));
        break;
      case 'Leave':
        var response =
            await _kelasc.leaveKelas(context, kelas, _auth.user.value.id);
        break;
      case 'Delete':
        var response = await _kelasc.deleteKelas(context, kelas);
        break;
      default:
    }
  }

  Set<String> _getKelasAction(KelasModel kelas) {
    if (kelas.role == 'murid') {
      return {'Leave'};
    } else {
      return {'Edit', 'Leave', 'Delete'};
    }
  }

  void _onTaskAction(String action, TaskModel task) async {
    switch (action) {
      case 'Edit':
        Get.to(() => CreateTask(task: task));
        break;
      case 'Delete':
        var response = await _kelasc.deleteTask(context, task);
        break;
      default:
    }
  }

  Set<String> _getTaskAction(TaskModel task) {
    if (task.userId == _auth.user.value.id) {
      return {'Edit', 'Delete'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: 'list-page',
        tooltip: 'Refresh ${[
          'kelas',
          'tugas',
          'event'
        ][_screenc.listPageTabIndex.value]}',
        child: Icon(Icons.refresh),
        onPressed: () async {
          switch (_screenc.listPageTabIndex.value) {
            case 0:
              _kelasc.getKelas(context);
              break;
            case 1:
              _kelasc.getTask(context);
              break;
            case 2:
              _kelasc.getKelas(context);
              break;
            default:
          }
        },
      ),
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
              ],
            ),
          ),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: [
              _listClassTab(context),
              _listTaskTab(context),
            ][_screenc.listPageTabIndex.value],
          );
        }),
      ],
    );
  }

  Widget _listClassTab(BuildContext context) {
    return Obx(() {
      if (_kelasc.isLoadingKelas.value) {
        return Center(child: CircularProgressIndicator());
      }
      return _kelasc.listKelas.value == null || _kelasc.listKelas.value.isEmpty
          ? Container(
              height: 36,
              child: Center(
                child: Text(
                  'You haven\'t join any class yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _kelasc.listKelas.value.length,
              itemBuilder: (context, index) {
                return listTileKelas(context, _kelasc.listKelas.value[index]);
              },
            );
    });
  }

  Widget _listTaskTab(BuildContext context) {
    return Obx(() {
      if (_kelasc.isLoadingTask.value) {
        return Center(child: CircularProgressIndicator());
      }
      return _kelasc.listTask.value == null || _kelasc.listTask.value.isEmpty
          ? Container(
              height: 36,
              child: Center(
                child: Text(
                  'You don\'t have any tasks yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _kelasc.listTask.value.length,
              itemBuilder: (context, index) {
                return listTileTask(context, _kelasc.listTask.value[index]);
              },
            );
    });
  }

  Widget _listEventTab(BuildContext context) {
    return Obx(() {
      if (_kelasc.isLoadingKelas.value) {
        return Center(child: CircularProgressIndicator());
      }
      return _kelasc.listKelas.value == null || _kelasc.listKelas.value.isEmpty
          ? Container(
              height: 36,
              child: Center(
                child: Text(
                  'You don\'t have any events yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _kelasc.listKelas.value.length,
              itemBuilder: (context, index) {
                return listTileKelas(context, _kelasc.listKelas.value[index]);
              },
            );
    });
  }

  Widget listTileKelas(BuildContext context, KelasModel kelas) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ClassDetailPage(kelas: kelas));
      },
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
                  color: Color(int.parse('0xFF${kelas.color}')),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${kelas.users.name}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  onSelected: (String action) {
                    _onKelasAction(action, kelas);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return _getKelasAction(kelas).map((String choice) {
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
            ),
          ),
        ),
      ),
    );
  }

  Widget listTileTask(BuildContext context, TaskModel task) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TaskDetailPage(task: task));
      },
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
                  color: Color(int.parse('0xFF${task.kelas.color}')),
                  width: 3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${task.title}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${task.dateEnd}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                // PopupMenuButton<String>(
                //   padding: EdgeInsets.zero,
                //   onSelected: (String action) {
                //     _onTaskAction(action, task);
                //   },
                //   icon: Icon(
                //     Icons.more_vert,
                //     color: Colors.black,
                //   ),
                //   itemBuilder: (BuildContext context) {
                //     return _getTaskAction(task).map((String choice) {
                //       return PopupMenuItem<String>(
                //         value: choice,
                //         child: Text(
                //           choice,
                //           style: Theme.of(context).textTheme.caption,
                //         ),
                //       );
                //     }).toList();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
