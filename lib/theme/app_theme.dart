import 'package:flutter/material.dart';

class AppColors {
  static const Color pageBackground = Color(0xFF0F0F10); // dark base
  static const Color card = Color(0xFF121212);
  static const Color border = Color(0xFF1F1F20);
  static const Color divider = Color(0xFF1A1A1B);
  static const Color headerText = Color(0xFFF7F7F7);
  static const Color subText = Color(0xFF9CA3AF);
  static const Color workingHours = Color(0xFF111217);
  static const Color breakBackground = Color(0xFF1E1A0F);
  static const Color breakIcon = Color(0xFFF59E0B);
  static const Color gridLine = Color(0xFF1E1E20);
  static const Color cardShadow = Color(0x33000000);
  static const Color primary = Color(0xFF7A3FFE); // purple accent
  static const Color currentLine = Color(0xFFEB3C46);
  static const Color bookingFill = Color(0xFF72B8E8);
  static const Color bookingBorder = Color(0xFF7A7BCE);
}

class AppTextStyles {
  static const TextStyle headerTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.headerText,
  );

  static const TextStyle headerDate = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.headerText,
  );

  static const TextStyle timeLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.subText,
  );

  static const TextStyle staffName = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.headerText,
  );

  static const TextStyle bookingTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: Color(0xFF0E0E0F),
  );

  static const TextStyle bookingSub = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(0xFF0E0E0F),
  );

  static const TextStyle bookingNote = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.subText,
  );
}

