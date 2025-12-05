import 'package:flutter/material.dart';

import '../models/calendar_models.dart';
import '../theme/app_theme.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final background = AppColors.bookingFill;
    return Container(
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: AppColors.bookingBorder, width: 2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${booking.startTime} - ${booking.customer.name}',
            style: AppTextStyles.bookingTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            booking.service.name,
            style: AppTextStyles.bookingSub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (booking.notes != null && booking.notes!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              booking.notes!,
              style: AppTextStyles.bookingNote,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
