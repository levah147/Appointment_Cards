import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/sample_loader.dart';
import '../helpers/time_utils.dart';
import '../models/calendar_models.dart';

class CalendarState extends ChangeNotifier {
  CalendarState() {
    _timeSlots = generateTimeSlots();
  }

  CalendarData? _data;
  late final List<String> _timeSlots;
  DateTime _selectedDate = DateTime.now();
  bool _loading = false;

  List<String> get timeSlots => _timeSlots;
  DateTime get selectedDate => _selectedDate;
  bool get isLoading => _loading;
  List<StaffSchedule> get staffSchedules => _data?.staffBookings ?? [];

  Future<void> initialize() async {
    _loading = true;
    notifyListeners();
    _data = await SampleLoader.load();
    _selectedDate = _data?.date ?? _selectedDate;
    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await initialize();
  }

  void goToToday() {
    _selectedDate = DateTime.now();
    notifyListeners();
  }

  void nextDay() {
    _selectedDate = addDays(_selectedDate, 1);
    notifyListeners();
  }

  void previousDay() {
    _selectedDate = addDays(_selectedDate, -1);
    notifyListeners();
  }

  bool isDayOffFor(StaffSchedule schedule) {
    return schedule.unavailability.any((u) {
      if (u.date == null) return false;
      return u.type.toLowerCase() == 'day_off' &&
          isSameDay(_selectedDate, DateTime.parse(u.date!));
    });
  }

  List<Booking> bookingsFor(StaffSchedule schedule) {
    if (_data == null) return [];
    if (!isSameDay(_selectedDate, _data!.date)) return [];
    return schedule.bookings;
  }

  double calculateBoardWidth(double viewportWidth) {
    final columnsWidth = (staffSchedules.length * 300) + 80;
    return max(viewportWidth, columnsWidth.toDouble());
  }
}
