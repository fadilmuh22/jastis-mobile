part of '../pages.dart';

class ClassDetailPage extends StatefulWidget {
  ClassDetailPage({
    Key key,
    @required this.kelas,
  }) : super(key: key);

  KelasModel kelas;

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  final AuthController _auth = AuthController.to;
  final CreateController _createc = CreateController.to;
  final KelasController _kelasc = KelasController.to;
  final ScreenController _screenc = ScreenController.to;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _kelasTask();
    });
  }

  Future _kelasTask() async {
    await _kelasc.kelasTask(context, widget.kelas);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onAppBarActions(String choice) async {
    switch (choice) {
      case 'Edit':
        bool back =
            await Get.to(() => CreateKelas(kelas: widget.kelas)) ?? false;

        if (back) {
          Get.back();
        }
        break;
      case 'Leave':
        var response = await _kelasc.leaveKelas(
            context, widget.kelas, _auth.user.value.id);
        if (response.success) {
          Get.back();
        }
        break;
      case 'Delete':
        var response = await _kelasc.deleteKelas(context, widget.kelas);
        if (response.success) {
          Get.back();
          Get.back();
        }
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
          'Detail Kelas',
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
              return _getKelasAction(widget.kelas).map((String choice) {
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
      floatingActionButton: widget.kelas.role == 'murid'
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(() => CreateTask(kelas: widget.kelas));
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _classDetailListView(context),
    );
  }

  ListView _classDetailListView(BuildContext context) {
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
              '${widget.kelas.name} (${widget.kelas.subject})',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 4),
            Text(
              '${widget.kelas.desc}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                            new ClipboardData(text: "${widget.kelas.code}"))
                        .then((value) {
                      Get.snackbar(
                        'Berhasil',
                        'Kode telah di salin',
                      );
                    });
                  },
                  child: Text(
                    'Kode untuk join : ${widget.kelas.code}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Constants.kDefaultPadding,
        ),
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.group,
              ),
              iconSize: 15,
              color: Constants.kPrimaryColor,
              onPressed: () {},
            ),
            SizedBox(width: 21),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.chat_bubble,
              ),
              iconSize: 15,
              color: Constants.kPrimaryColor,
              onPressed: () {},
            ),
            SizedBox(width: 21),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.exit_to_app,
              ),
              iconSize: 15,
              color: Constants.kPrimaryColor,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 31),
        _listKelasTask(context),
      ],
    );
  }

  Widget _listKelasTask(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (_kelasc.isLoadingTask.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return _kelasc.listTaskKelas.value == null
              ? Container(
                  height: 36,
                  child: Center(
                    child: Text(
                      'Masih belum ada tugas di kelas ini',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              : ListTile(
                  onTap: () {
                    var lt = _kelasc.listTaskKelas.value.map((data) {
                      data.kelas = widget.kelas;
                      return data;
                    }).toList();

                    _screenc.mainTabIndex.value = 1;
                    _screenc.listPageTabIndex.value = 1;
                    _kelasc.listTask.value = lt;

                    Get.back();
                    Get.back();
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Card(
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.assignment,
                        color: Constants.kPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    '${_kelasc.listTaskKelas.value.length} total tugas',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 11,
                        ),
                  ),
                  subtitle: Text(
                    'Klik untuk lebih lengkap',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                );
        }),
      ],
    );
  }
}
