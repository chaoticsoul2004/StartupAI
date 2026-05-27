import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../state/app_state.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final weekStart = today.subtract(Duration(days: today.weekday % 7));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final day = weekStart.add(Duration(days: i));
        final isToday = day.day == today.day && day.month == today.month && day.year == today.year;
        final hasPeriod = AppState().isPeriodDay(day);

        Color bgColor = Colors.transparent;
        Color textColor = AppColors.violetText;
        Border? border;

        if (isToday && hasPeriod) {
          bgColor = AppColors.pink;
          textColor = Colors.white;
        } else if (hasPeriod) {
          bgColor = const Color(0xFFF9A8D4); // pink-300
          textColor = Colors.white;
        } else if (isToday) {
          bgColor = Colors.white;
          textColor = AppColors.violet;
          border = Border.all(color: const Color(0xFFA78BFA), width: 2, style: BorderStyle.solid);
        }

        return Column(
          children: [
            Text(
              DateFormat('EEEEE').format(day),
              style: TextStyle(
                color: AppColors.violetText.withOpacity(0.6),
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
                border: border,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}