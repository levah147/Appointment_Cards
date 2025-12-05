import 'dart:math';

import 'package:flutter/material.dart';

import '../helpers/time_utils.dart';
import '../models/calendar_models.dart';
import '../theme/app_theme.dart';
import 'booking_card.dart';

class StaffColumn extends StatelessWidget {
  const StaffColumn({
    super.key,
    required this.schedule,
    required this.headerHeight,
    required this.gridHeight,
    this.bookings = const [],
    this.isDayOff = false,
  });

  final StaffSchedule schedule;
  final double headerHeight;
  final double gridHeight;
  final List<Booking> bookings;
  final bool isDayOff;

  @override
  Widget build(BuildContext context) {
    final staffColor = parseColor(schedule.staff.color) ?? AppColors.primary;
    return Container(
      width: 300,
      color: AppColors.card,
      child: Column(
        children: [
          _StaffHeader(
            staff: schedule.staff,
            color: staffColor,
            height: headerHeight,
          ),
          SizedBox(
            height: gridHeight,
            child: Stack(
              children: [
                if (schedule.workingHours != null)
                  _WorkingHoursLayer(workingHours: schedule.workingHours!),
                _GridLinesLayer(),
                for (final brk in schedule.breaks)
                  _BreakLayer(breakPeriod: brk),
                for (final booking in bookings) _BookingLayer(booking: booking),
                if (isDayOff) _DayOffOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffHeader extends StatelessWidget {
  const _StaffHeader({
    required this.staff,
    required this.color,
    required this.height,
  });

  final StaffMember staff;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final initials =
        staff.name.isNotEmpty
            ? staff.name
                .trim()
                .split(' ')
                .map((e) => e.isNotEmpty ? e[0] : '')
                .take(2)
                .join()
            : '';
    return Container(
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border),
          right: BorderSide(color: AppColors.border),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.15),
              child: Text(
                initials,
                style: AppTextStyles.staffName.copyWith(color: color),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              staff.name,
              style: staffNameStyle(color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.subText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _GridLinesLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        96,
        (index) => Container(
          height: slotHeight,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.gridLine, width: 0.8),
              right: BorderSide(color: AppColors.border, width: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkingHoursLayer extends StatelessWidget {
  const _WorkingHoursLayer({required this.workingHours});

  final WorkingHours workingHours;

  @override
  Widget build(BuildContext context) {
    final top = timeToPosition(workingHours.start).toDouble();
    final height = max<double>(
      getDuration(workingHours.start, workingHours.end).toDouble(),
      0,
    );
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.workingHours,
        ),
      ),
    );
  }
}

class _BreakLayer extends StatelessWidget {
  const _BreakLayer({required this.breakPeriod});

  final BreakPeriod breakPeriod;

  @override
  Widget build(BuildContext context) {
    final top = timeToPosition(breakPeriod.start).toDouble();
    final height = max<double>(
      getDuration(breakPeriod.start, breakPeriod.end).toDouble(),
      0,
    );
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: AppColors.breakBackground.withOpacity(0.6),
        child: Row(
          children: const [
            Icon(Icons.free_breakfast, color: AppColors.breakIcon, size: 16),
            SizedBox(width: 6),
            Text(
              'Break',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.breakIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingLayer extends StatelessWidget {
  const _BookingLayer({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final top = timeToPosition(booking.startTime).toDouble();
    final height = max<double>(
      getDuration(booking.startTime, booking.endTime).toDouble(),
      slotHeight,
    );
    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: height,
      child: BookingCard(booking: booking),
    );
  }
}

class _DayOffOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.7),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Text('Day off', style: AppTextStyles.bookingTitle),
        ),
      ),
    );
  }
}
