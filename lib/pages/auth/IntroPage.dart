part of '../pages.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final store = GetStorage();

  List<Slide> _slides = [];
  TextStyle _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  TextStyle _descStyle = TextStyle(
    color: Colors.black,
    fontSize: 13,
  );

  @override
  void initState() {
    super.initState();

    _slides.add(
      new Slide(
        title: "Task Management",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "assets/img/intro_0.png",
        backgroundColor: Color(0xFFB19FE5).withOpacity(.6),
        styleTitle: _titleStyle,
        styleDescription: _descStyle,
      ),
    );
    _slides.add(
      new Slide(
        title: "Easy Interface",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/img/intro_1.png",
        backgroundColor: Colors.white.withOpacity(.4),
        styleTitle: _titleStyle,
        styleDescription: _descStyle,
      ),
    );
    _slides.add(
      new Slide(
        title: "Class Based",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "assets/img/intro_2.png",
        backgroundColor: Color(0xFFB19FE5).withOpacity(.6),
        styleTitle: _titleStyle,
        styleDescription: _descStyle,
      ),
    );
  }

  void onDonePress(context, Function onDone) async {
    await onDone();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this._slides,
      onDonePress: () => this
          .onDonePress(context, () async => await store.write('intro', 'seen')),
      backgroundColorAllSlides: Colors.white,
    );
  }
}
