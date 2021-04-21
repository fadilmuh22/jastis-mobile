import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jastis/Constants.dart';
import 'package:jastis/controllers/controllers.dart';
import 'package:jastis/models/models.dart';
import 'package:jastis/pages/pages.dart';

part 'drawer.dart';
part 'overlays.dart';

void selectDate(BuildContext context, var form) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: form.selectedDate, // Refer step 1
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );
  if (picked != null && picked != form.selectedDate) {
    form.selectedDate = picked;
    form.date.text = picked;
  }
}
