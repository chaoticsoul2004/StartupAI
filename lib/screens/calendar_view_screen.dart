import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme/app_colors.dart';
import '../state/app_state.dart';

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({super.key});

  @override
  State<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isPeriodDay(DateTime day) => AppState().isPeriodDay(day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Calendar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 18),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const Divider(),

            // Calendar
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selected, focused) => setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              }),
              onPageChanged: (focused) => setState(() => _focusedDay = focused),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_isPeriodDay(day)) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle),
                      child: Center(child: Text('${day.day}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    );
                  }
                  return null;
                },
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(color: AppColors.violet, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: AppColors.pinkDark, shape: BoxShape.circle),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LegendItem(color: AppColors.pink, label: 'Period'),
                  const SizedBox(width: 24),
                  _LegendItem(color: AppColors.pinkLight, label: 'Predicted', dashed: true),
                ],
              ),
            ),

            // Selected day info
            if (_selectedDay != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isPeriodDay(_selectedDay!)
                              ? 'Period day logged'
                              : 'No period logged for this day',
                          style: TextStyle(
                            color: _isPeriodDay(_selectedDay!) ? AppColors.pink : const Color(0xFF6B7280),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool dashed;
  const _LegendItem({required this.color, required this.label, this.dashed = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(
            color: color, shape: BoxShape.circle,
            border: dashed ? Border.all(color: AppColors.pink, width: 1.5) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}