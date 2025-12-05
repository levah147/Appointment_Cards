// import 'package:flutter/material.dart';

// import '../helpers/time_utils.dart';
// import '../theme/app_theme.dart';

// class CalendarHeader extends StatelessWidget {
//   const CalendarHeader({
//     super.key,
//     required this.selectedDate,
//     required this.onToday,
//     required this.onPrevious,
//     required this.onNext,
//     required this.onRefresh,
//     required this.onAdd,
//     this.isLoading = false,
//   });

//   final DateTime selectedDate;
//   final VoidCallback onToday;
//   final VoidCallback onPrevious;
//   final VoidCallback onNext;
//   final VoidCallback onRefresh;
//   final VoidCallback onAdd;
//   final bool isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(bottom: BorderSide(color: AppColors.border)),
//       ),
//       child: Row(
//         children: [
//           _HeaderButton(label: 'Today', onTap: onToday),
//           const SizedBox(width: 8),
//           IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new, size: 18),
//             onPressed: onPrevious,
//           ),
//           IconButton(
//             icon: const Icon(Icons.arrow_forward_ios, size: 18),
//             onPressed: onNext,
//           ),
//           const SizedBox(width: 6),
//           Flexible(
//             child: Text(
//               formatSelectedDate(selectedDate),
//               style: AppTextStyles.headerDate,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           const SizedBox(width: 6),
//           IconButton(
//             icon:
//                 isLoading
//                     ? const SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                     : const Icon(Icons.refresh),
//             onPressed: isLoading ? null : onRefresh,
//           ),
//           const SizedBox(width: 4),
//           const _AddButton(),
//         ],
//       ),
//     );
//   }
// }

// class _HeaderButton extends StatelessWidget {
//   const _HeaderButton({required this.label, required this.onTap});

//   final String label;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.headerText,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         side: const BorderSide(color: AppColors.border),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       onPressed: onTap,
//       child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
//     );
//   }
// }

// class _AddButton extends StatelessWidget {
//   const _AddButton();

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(82, 44),
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 0,
//       ),
//       onPressed: () {},
//       icon: const Icon(Icons.add, size: 18),
//       label: const Text('Add', style: TextStyle(fontWeight: FontWeight.w700)),
//     );
//   }
// }
