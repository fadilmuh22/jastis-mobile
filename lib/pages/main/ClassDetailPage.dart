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

  @override
  void initState() {
    super.initState();

    _createc.selectedKelas.value = widget.kelas;
  }

  @override
  void dispose() {
    super.dispose();

    _createc.selectedKelas.value = null;
  }

  void _onAppBarActions(String choice) async {
    switch (choice) {
      case 'Edit':
        Get.to(() => CreateKelas(kelas: widget.kelas));
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
          _kelasc.getKelas(context);
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          OverlayScreen().show(context, identifier: 'modal-create');
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
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
                    Icons.ondemand_video,
                    color: Constants.kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
              title: Text(
                '1 Hour Video',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 11,
                    ),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            ListTile(
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
                    Icons.article,
                    color: Constants.kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
              title: Text(
                '3 Article',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 11,
                    ),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            ListTile(
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
                    Icons.arrow_circle_down,
                    color: Constants.kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
              title: Text(
                '5 Download Resource',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 11,
                    ),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
