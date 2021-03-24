part of 'pages.dart';

class ClassPage extends StatefulWidget {
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final classes = watch(classProvider);
      return ListView(
        padding: EdgeInsets.all(Constants.kDefaultPadding),
        children: [
          classItem(classes.classes[0]),
        ],
      );
    });
  }
}
