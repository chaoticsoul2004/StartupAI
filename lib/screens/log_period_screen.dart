import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../models/period_log.dart';
import '../state/app_state.dart';

class LogPeriodScreen extends StatefulWidget {
  const LogPeriodScreen({super.key});

  @override
  State<LogPeriodScreen> createState() => _LogPeriodScreenState();
}

class _LogPeriodScreenState extends State<LogPeriodScreen> {
  DateTime _viewMonth = DateTime.now();
  final Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    // Pre-select today
    _selected.add(_key(DateTime.now()));
  }

  String _key(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  void _toggle(DateTime d) {
    setState(() {
      final k = _key(d);
      if (_selected.contains(k)) _selected.remove(k);
      else _selected.add(k);
    });
  }

  bool _isSelected(DateTime d) => _selected.contains(_key(d));

  bool _isToday(DateTime d) {
    final t = DateTime.now();
    return d.year == t.year && d.month == t.month && d.day == t.day;
  }

  void _save() {
    if (_selected.isEmpty) { Navigator.of(context).pop(); return; }
    final dates = _selected.map((s) => DateTime.parse(s)).toList()..sort();
    AppState().addPeriod(PeriodLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startDate: dates.first,
      endDate: dates.last,
    ));
    Navigator.of(context).pop();
  }

  List<List<DateTime?>> _buildWeeks(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final last = DateTime(month.year, month.month + 1, 0);
    final pad = first.weekday % 7; // Sunday=0
    final cells = <DateTime?>[...List.filled(pad, null)];
    for (int d = 1; d <= last.day; d++) cells.add(DateTime(month.year, month.month, d));
    while (cells.length % 7 != 0) cells.add(null);
    return List.generate(cells.length ~/ 7, (i) => cells.sublist(i * 7, i * 7 + 7));
  }

  Widget _dayCircle(DateTime day) {
    final sel = _isSelected(day);
    final today = _isToday(day);

    if (sel) {
      return GestureDetector(
        onTap: () => _toggle(day),
        child: Container(
          width: 38, height: 38,
          decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _toggle(day),
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: today ? AppColors.pink : const Color(0xFFE5E7EB),
            width: today ? 2 : 1.5,
          ),
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: today ? AppColors.pink : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(DateTime month) {
    final weeks = _buildWeeks(month);
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Column(
      children: [
        // Month header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Color(0xFF9CA3AF)),
              onPressed: () => setState(() => _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1)),
            ),
            Text(
              DateFormat('MMMM').format(month),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
              onPressed: () => setState(() => _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1)),
            ),
          ],
        ),
        // Day headers
        Row(
          children: days.map((d) => Expanded(
            child: Center(child: Text(d, style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w600))),
          )).toList(),
        ),
        const SizedBox(height: 8),
        // Weeks
        ...weeks.map((week) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: week.map((day) => Expanded(
              child: day == null
                  ? const SizedBox(height: 38)
                  : Column(
                      children: [
                        if (_isToday(day))
                          const Text('TODAY', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Color(0xFF6B7280), letterSpacing: 1))
                        else
                          const SizedBox(height: 13),
                        _dayCircle(day),
                      ],
                    ),
            )).toList(),
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final currentWeekStart = today.subtract(Duration(days: today.weekday % 7));
    const dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top week strip
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final day = currentWeekStart.add(Duration(days: i));
                  final sel = _isSelected(day);
                  final today_ = _isToday(day);
                  return Column(
                    children: [
                      Text(dayLabels[i], style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _toggle(day),
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sel ? AppColors.pink : Colors.transparent,
                            border: Border.all(
                              color: sel ? AppColors.pink : today_ ? AppColors.pink : const Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: sel
                                ? const Icon(Icons.check, color: Colors.white, size: 14)
                                : Text('${day.day}', style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: today_ ? AppColors.pink : const Color(0xFF4B5563),
                                  )),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            // Scrollable calendar
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildCalendar(_viewMonth),
                    const Divider(color: Color(0xFFF3F4F6)),
                    _buildCalendar(DateTime(_viewMonth.year, _viewMonth.month + 1)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: _save,
                    child: const Text('Save', style: TextStyle(color: AppColors.pink, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}