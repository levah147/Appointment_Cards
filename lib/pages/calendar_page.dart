import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/time_utils.dart';
import '../state/calendar_state.dart';
import '../theme/app_theme.dart';
import '../widgets/calendar_header.dart';
import '../widgets/staff_column.dart';
import '../widgets/time_column.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const double _headerHeight = 100;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CalendarState>().initialize());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarState>();
    final staff = state.staffSchedules;
    final boardWidth = state.calculateBoardWidth(
      MediaQuery.of(context).size.width,
    );
    final isTodayView = isSameDay(state.selectedDate, DateTime.now());
    final currentOffset =
        _headerHeight + currentDayOffsetPx(DateTime.now()).clamp(0, gridHeight);
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBanner(),
            // CalendarHeader(
            //   selectedDate: state.selectedDate,
            //   isLoading: state.isLoading,
            //   onToday: state.goToToday,
            //   onPrevious: state.previousDay,
            //   onNext: state.nextDay,
            //   onRefresh: state.refresh,
            //   onAdd: () {},
            // ),
            _StaffHeaderRow(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: AppColors.card,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child:
                    state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: boardWidth,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Stack(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TimeColumn(topPadding: _headerHeight),
                                      ...staff.map((s) {
                                        final bookings = state.bookingsFor(s);
                                        final isDayOff = state.isDayOffFor(s);
                                        return StaffColumn(
                                          schedule: s,
                                          headerHeight: _headerHeight,
                                          gridHeight: gridHeight,
                                          bookings: bookings,
                                          isDayOff: isDayOff,
                                        );
                                      }),
                                    ],
                                  ),
                                  if (isTodayView)
                                    Positioned(
                                      top: currentOffset,
                                      left: 0,
                                      right: 0,
                                      child: _CurrentTimeIndicator(
                                        width: boardWidth,
                                        label: _formatNowLabel(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
              ),
            ),
            const _BottomNav(),
          ],
        ),
      ),
    );
  }

  String _formatNowLabel() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'pm' : 'am';
    final h12 = (hour % 12 == 0) ? 12 : hour % 12;
    return '$h12:$minute $period';
  }
}

class _CurrentTimeIndicator extends StatelessWidget {
  const _CurrentTimeIndicator({required this.width, required this.label});

  final double width;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: AppColors.currentLine, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.currentLine,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: 1,
                    color: AppColors.currentLine.withOpacity(0.7),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.currentLine,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBanner extends StatelessWidget {
  const _TopBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        children: const [
          Icon(Icons.rocket_launch_outlined, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Continue setup',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }
}

class _StaffHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.black54,
            child: Icon(Icons.menu, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(
            'Mon 1 Dec',
            style: AppTextStyles.headerTitle,
          ),
          const Icon(Icons.arrow_drop_down, color: AppColors.headerText),
          const Spacer(),
          const Icon(Icons.tune, color: AppColors.headerText),
          const SizedBox(width: 16),
          Stack(
            children: const [
              Icon(Icons.notifications_none, color: AppColors.headerText),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: AppColors.currentLine,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.bookingFill,
            child: Text(
              'R',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0E),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.calendar_month, color: Colors.white),
          Icon(Icons.sell_outlined, color: Colors.white),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.add, color: Colors.white),
          ),
          Icon(Icons.emoji_emotions_outlined, color: Colors.white),
          Icon(Icons.grid_view, color: Colors.white),
        ],
      ),
    );
  }
}
