part of 'components.dart';

/// State of the [OverlayScreen].
enum Screen {
  /// Already [OverlayScreen] showing.
  showing,

  /// No [OverlayScreen] showing.
  none,
}

/// Displays and dispose a [Dialog]
/// that works like an overlay screen.
class OverlayScreen {
  OverlayScreen._internal();
  static final OverlayScreen _instance = OverlayScreen._internal();

  /// Singleton constructor.
  factory OverlayScreen() => _instance;

  Screen _state = Screen.none;
  BuildContext _overlayScreenContext;
  final Map<String, Widget> _customOverLayScreens = {
    'default-loading': WillPopScope(
      onWillPop: () async => false,
      child: CustomOverlayScreen(
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              "loading...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  };

  /// Getter to know the state of the [OverlayScreen].
  Screen get state => _state;

  /// This method saves widgets to show by [show].
  void saveScreens(Map<String, CustomOverlayScreen> widgets) =>
      _instance._customOverLayScreens.addAll(widgets);

  /// This method removes widgets to show by [show].
  void removeScreens(List<String> identifiers) => identifiers.forEach(
      (identifier) => _instance._customOverLayScreens.remove(identifier));

  /// This method displays a [OverlayScreen] by an identifier.
  void show(
    BuildContext context, {
    String identifier = 'default-loading',
  }) {
    assert(_instance._customOverLayScreens.isNotEmpty, "overlay screens empty");
    assert(_customOverLayScreens.containsKey(identifier), "widget not found");
    // assert(_instance._state == Screen.none, "already showing screen");
    _instance._state = Screen.showing;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _instance._overlayScreenContext = context;
        return _customOverLayScreens[identifier];
      },
    );
  }

  /// This method dispose the [OverlayScreen].
  void pop() {
    // assert(_instance._state == Screen.showing, "no screen displayed");
    Navigator.pop(_instance._overlayScreenContext);
    _instance._overlayScreenContext = null;
    _instance._state = Screen.none;
  }
}

/// Custom widget to display in a [OverlayScreen].
class CustomOverlayScreen extends StatelessWidget {
  /// Backgroundcolor for [OverlayScreen].
  final Color backgroundColor;

  /// Custom content for [OverlayScreen].
  final Widget content;

  /// CustomOverlayScreen constructor.
  CustomOverlayScreen({
    @required this.content,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Container(
        height: size.height,
        width: size.width,
        child: content,
      ),
    );
  }
}

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
    'modal-create': CustomOverlayScreen(
      backgroundColor: Constants.kPrimaryColor.withOpacity(.3),
      content: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 180.0,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            OverlayScreen().pop();
                            Get.to(() => CreateTask());
                          },
                          child: Text(
                            'Tugas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.kDefaultPadding),
                            primary: Constants.kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            OverlayScreen().pop();
                            Get.to(() => CreateEvent());
                          },
                          child: Text(
                            'Event',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.kDefaultPadding),
                            primary: Constants.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  });
}
