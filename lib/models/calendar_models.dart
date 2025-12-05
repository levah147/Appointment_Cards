import 'package:flutter/material.dart';

enum BookingStatus {
  confirmed,
  pending,
  inProgress,
  completed,
  cancelled,
}

BookingStatus bookingStatusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'confirmed':
      return BookingStatus.confirmed;
    case 'in_progress':
      return BookingStatus.inProgress;
    case 'completed':
      return BookingStatus.completed;
    case 'cancelled':
      return BookingStatus.cancelled;
    case 'pending':
    default:
      return BookingStatus.pending;
  }
}

class TimeRange {
  const TimeRange({required this.start, required this.end});

  final String start;
  final String end;

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }
}

class WorkingHours {
  const WorkingHours({required this.start, required this.end});
  final String start;
  final String end;

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }
}

class BreakPeriod {
  const BreakPeriod({required this.start, required this.end});
  final String start;
  final String end;

  factory BreakPeriod.fromJson(Map<String, dynamic> json) {
    return BreakPeriod(
      start: json['start'] as String,
      end: json['end'] as String,
    );
  }
}

class Unavailability {
  const Unavailability({required this.type, this.reason, this.date});
  final String type;
  final String? reason;
  final String? date;

  factory Unavailability.fromJson(Map<String, dynamic> json) {
    return Unavailability(
      type: json['type'] as String,
      reason: json['reason'] as String?,
      date: json['date'] as String?,
    );
  }
}

class Customer {
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.avatar,
  });

  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? avatar;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
    );
  }
}

class Service {
  const Service({
    required this.id,
    required this.name,
    this.color,
    this.duration,
  });

  final String id;
  final String name;
  final String? color;
  final int? duration;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      duration: json['duration'] as int?,
    );
  }
}

class Booking {
  const Booking({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.customer,
    required this.service,
    this.notes,
  });

  final String id;
  final String startTime;
  final String endTime;
  final BookingStatus status;
  final Customer customer;
  final Service service;
  final String? notes;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: bookingStatusFromString(json['status'] as String),
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
    );
  }
}

class StaffMember {
  const StaffMember({
    required this.id,
    required this.name,
    this.color,
    this.avatar,
  });

  final String id;
  final String name;
  final String? color;
  final String? avatar;

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      avatar: json['avatar'] as String?,
    );
  }
}

class StaffSchedule {
  const StaffSchedule({
    required this.staff,
    required this.bookings,
    this.workingHours,
    this.breaks = const [],
    this.unavailability = const [],
  });

  final StaffMember staff;
  final WorkingHours? workingHours;
  final List<BreakPeriod> breaks;
  final List<Unavailability> unavailability;
  final List<Booking> bookings;

  StaffSchedule copyWith({
    List<Booking>? bookings,
    WorkingHours? workingHours,
    List<BreakPeriod>? breaks,
    List<Unavailability>? unavailability,
  }) {
    return StaffSchedule(
      staff: staff,
      bookings: bookings ?? this.bookings,
      workingHours: workingHours ?? this.workingHours,
      breaks: breaks ?? this.breaks,
      unavailability: unavailability ?? this.unavailability,
    );
  }

  factory StaffSchedule.fromJson(Map<String, dynamic> json) {
    return StaffSchedule(
      staff: StaffMember.fromJson(json['staff'] as Map<String, dynamic>),
      bookings: (json['bookings'] as List<dynamic>? ?? [])
          .map((item) => Booking.fromJson(item as Map<String, dynamic>))
          .toList(),
      workingHours: json['workingHours'] == null
          ? null
          : WorkingHours.fromJson(json['workingHours'] as Map<String, dynamic>),
      breaks: (json['breaks'] as List<dynamic>? ?? [])
          .map((item) => BreakPeriod.fromJson(item as Map<String, dynamic>))
          .toList(),
      unavailability: (json['unavailability'] as List<dynamic>? ?? [])
          .map((item) => Unavailability.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CalendarData {
  const CalendarData({
    required this.date,
    required this.timezone,
    required this.staffBookings,
    this.timeRange,
  });

  final DateTime date;
  final String timezone;
  final TimeRange? timeRange;
  final List<StaffSchedule> staffBookings;

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return CalendarData(
      date: DateTime.parse(data['date'] as String),
      timezone: data['timezone'] as String,
      timeRange: data['timeRange'] == null
          ? null
          : TimeRange.fromJson(data['timeRange'] as Map<String, dynamic>),
      staffBookings: (data['staffBookings'] as List<dynamic>? ?? [])
          .map((item) => StaffSchedule.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

Color? parseColor(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  final value = int.tryParse(buffer.toString(), radix: 16);
  if (value == null) return null;
  return Color(value);
}

