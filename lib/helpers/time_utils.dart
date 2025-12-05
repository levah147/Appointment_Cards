import 'package:flutter/material.dart';

import '../models/calendar_models.dart';
import '../theme/app_theme.dart';

const int _slotMinutes = 15;
const double slotHeight = 20.0;
const double gridHeight = 96 * slotHeight;
const double minuteHeight = slotHeight / _slotMinutes;

int timeToPosition(String time) {
  final parts = time.split(':');
  if (parts.length < 2) return 0;
  final hours = int.tryParse(parts[0]) ?? 0;
  final minutes = int.tryParse(parts[1]) ?? 0;
  final totalMinutes = hours * 60 + minutes;
  return ((totalMinutes ~/ _slotMinutes) * slotHeight).toInt();
}

int getDuration(String startTime, String endTime) {
  final startParts = startTime.split(':');
  final startHours = int.tryParse(startParts[0]) ?? 0;
  final startMinutes = int.tryParse(startParts.length > 1 ? startParts[1] : '0') ?? 0;
  final endParts = endTime.split(':');
  final endHours = int.tryParse(endParts[0]) ?? 0;
  final endMinutes = int.tryParse(endParts.length > 1 ? endParts[1] : '0') ?? 0;
  final startTotal = startHours * 60 + startMinutes;
  final endTotal = endHours * 60 + endMinutes;
  final diff = endTotal - startTotal;
  return ((diff ~/ _slotMinutes) * slotHeight).toInt();
}

String formatTimeDisplay(String time) {
  final parts = time.split(':');
  if (parts.length < 2) return time;
  int hours = int.tryParse(parts[0]) ?? 0;
  final minutes = parts[1].padLeft(2, '0');
  final period = hours >= 12 ? 'pm' : 'am';
  hours = hours % 12;
  if (hours == 0) hours = 12;
  return '$hours:$minutes $period';
}

List<String> generateTimeSlots() {
  final slots = <String>[];
  for (int hour = 0; hour < 24; hour++) {
    for (int minute = 0; minute < 60; minute += _slotMinutes) {
      slots.add(
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
      );
    }
  }
  return slots;
}

DateTime addDays(DateTime date, int days) => date.add(Duration(days: days));

double currentDayOffsetPx(DateTime now) {
  final minutes = now.hour * 60 + now.minute;
  return minutes * minuteHeight;
}

Color getBookingColor(BookingStatus status) {
  switch (status) {
    case BookingStatus.confirmed:
      return const Color(0xFFDBEAFE);
    case BookingStatus.pending:
      return const Color(0xFFFEF3C7);
    case BookingStatus.inProgress:
      return const Color(0xFFDCFCE7);
    case BookingStatus.completed:
      return const Color(0xFFF3F4F6);
    case BookingStatus.cancelled:
      return const Color(0xFFFEE2E2);
  }
}

String formatSelectedDate(DateTime date) {
  final monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  final weekday = weekdayNames[date.weekday - 1];
  final month = monthNames[date.month - 1];
  return '$weekday, ${date.day} $month ${date.year}';
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

TextStyle staffNameStyle(Color? color) {
  if (color == null) return AppTextStyles.staffName;
  return AppTextStyles.staffName.copyWith(color: color);
}

