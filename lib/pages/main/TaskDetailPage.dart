part of '../pages.dart';

class TaskDetailPage extends StatefulWidget {
  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
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
          'Detail',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: ListView(
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
                'Basis Data',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 4),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut feugiat gravida mi.',
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
      ),
    );
  }
}
