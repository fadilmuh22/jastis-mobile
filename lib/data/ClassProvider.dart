part of 'data.dart';

class ClassNotifier extends ChangeNotifier {
  List<ClassModel> _classes = [
    ClassModel(
      title: "Title",
      subtitle: "Desc",
      day: "Monday",
      owner: "Fadil",
    ),
    ClassModel(
      title: "Title",
      subtitle: "Desc",
      day: "Tuesday",
      owner: "Today",
    ),
    ClassModel(
      title: "Title",
      subtitle: "Desc",
      day: "Wednesday",
      owner: "Torow",
    ),
  ];

  List<ClassModel> get classes => _classes;
}

final classProvider = ChangeNotifierProvider((_) => ClassNotifier());
