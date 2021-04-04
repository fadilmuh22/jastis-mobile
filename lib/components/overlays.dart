part of 'components.dart';

void initOverlays(BuildContext context) {
  OverlayScreen().saveScreens({
    'modal-logout': CustomOverlayScreen(
      backgroundColor: Constants.kPrimaryColor.withOpacity(.3),
      content: Dialog(
        child: SizedBox(
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No internet connection!!',
                style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                "waiting..",
                style: TextStyle(
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    ),
  });
}
