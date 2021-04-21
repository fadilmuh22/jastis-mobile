import 'dart:async';
import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:jastis/Constants.dart';
import 'package:jastis/components/components.dart';
import 'package:jastis/controllers/controllers.dart';
import 'package:jastis/data/data.dart';
import 'package:jastis/models/models.dart';

part 'auth/SplashPage.dart';
part 'auth/IntroPage.dart';
part 'auth/LoginPage.dart';
part 'auth/RegisterPage.dart';

part './main/MainTabPage.dart';
part './main/HomePage.dart';
part './main/ListPage.dart';
part 'main/NotificationsPage.dart';

part 'detail/ClassDetailPage.dart';
part 'detail/TaskDetailPage.dart';

part 'create/CreateKelas.dart';
part 'create/CreateTask.dart';
part 'create/CreateEvent.dart';
