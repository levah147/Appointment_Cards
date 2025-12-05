import 'package:flutter/material.dart';

import '../helpers/time_utils.dart';
import '../theme/app_theme.dart';

class TimeColumn extends StatelessWidget {
  const TimeColumn({super.key, required this.topPadding});

  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final hours = List.generate(24, (index) => index);
    return Container(
      width: 80,
      color: AppColors.pageBackground,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final hour in hours)
              Container(
                alignment: Alignment.topLeft,
                height: slotHeight * 4,
                padding: const EdgeInsets.only(left: 12, top: 2),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Text(
                  formatTimeDisplay('${hour.toString().padLeft(2, '0')}:00'),
                  style: AppTextStyles.timeLabel,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
