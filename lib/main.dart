import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/calendar_page.dart';
import 'state/calendar_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AppointmentCalendarApp());
}

class AppointmentCalendarApp extends StatelessWidget {
  const AppointmentCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalendarState(),
      child: MaterialApp(
        title: 'Appointment Calendar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.pageBackground,
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        home: const CalendarPage(),
      ),
    );
  }
}
