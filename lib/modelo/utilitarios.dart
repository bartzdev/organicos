import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? formatDate(DateTime? dateTime, {mask = "dd/MM/yyyy"}) {
  if (dateTime != null) return DateFormat(mask).format(dateTime);
  return null;
}

String? formatTime(TimeOfDay? time, [bool withSeconds = false]) {
  if (time != null)
    return formatInt(time.hour) +
        ":" +
        formatInt(int.tryParse(time.minute.toString()));
  return null;
}

String? formatDouble(double? n) {
  if (n != null)
    return n
        .toStringAsFixed(n.truncateToDouble() == n ? 0 : 2)
        .replaceAll(".", ",");
  return null;
}

String formatInt(int? n, {int digits = 2}) {
  if (n != null) {
    String mask = "";
    for (int i = 1; i <= digits; i++) mask += "0";
    return NumberFormat(mask).format(n);
  }
  return "";
}
