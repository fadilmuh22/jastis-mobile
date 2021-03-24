part of 'pages.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
          'Notifications',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 7),
              child: Row(
                children: [
                  SizedBox(width: 9),
                  Container(
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uh oh, the deadline is near!',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 11),
                      ),
                      Text(
                        'Hurry up do your assignment before it’s too late.',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
