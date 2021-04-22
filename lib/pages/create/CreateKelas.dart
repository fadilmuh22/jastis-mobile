part of '../pages.dart';

class CreateKelas extends StatefulWidget {
  CreateKelas({
    Key key,
    this.kelas,
  }) : super(key: key);

  final KelasModel kelas;

  @override
  _CreateKelasState createState() => _CreateKelasState();
}

class _CreateKelasState extends State<CreateKelas> {
  final CreateController _createc = CreateController.to;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.kelas != null) {
      _createc.kelasForm.value.name.text = widget.kelas.name;
      _createc.kelasForm.value.subject.text = widget.kelas.subject;
      _createc.kelasForm.value.desc.text = widget.kelas.desc;
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

  Future _createKelas() async {
    if (_formKey.currentState.validate()) {
      ResponseModel response = await _createc.createKelas(context);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success creating kelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        await Future.delayed(Duration(seconds: 2))
            .then((value) => Navigator.pop(context));
      }
    }
  }

  Future _updateKelas() async {
    if (_formKey.currentState.validate()) {
      ResponseModel response =
          await _createc.updateKelas(context, widget.kelas.id);
      if (response.success) {
        Get.snackbar(
          'Success',
          'Success updating kelas',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        await Future.delayed(Duration(seconds: 2)).then((value) {
          Navigator.of(context).pop(true);
        });
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
                '${widget.kelas == null ? 'Create' : 'Update'} Kelas',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 40),
              _createClassTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createClassTab() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Kelas',
                style: Theme.of(context).textTheme.caption,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _createc.kelasForm.value.name,
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
                    return 'Nama can\'t be empty';
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
                'Subject',
                style: Theme.of(context).textTheme.caption,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _createc.kelasForm.value.subject,
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
                    return 'Subject can\'t be empty';
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
                'Description',
                style: Theme.of(context).textTheme.caption,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                maxLines: 8,
                controller: _createc.kelasForm.value.desc,
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
                  if (widget.kelas == null) {
                    _createKelas();
                  } else {
                    _updateKelas();
                    Get.back();
                  }
                },
                child: Text('${widget.kelas == null ? 'Create' : 'Update'}'),
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
