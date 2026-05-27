import '../models/period_log.dart';

class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  List<PeriodLog> periods = [];

  void addPeriod(PeriodLog period) {
    periods.add(period);
  }

  int getDaysToNextPeriod() {
    if (periods.length < 2) return 14;
    final sorted = [...periods]..sort((a, b) => a.startDate.compareTo(b.startDate));
    final cycles = <int>[];
    for (int i = 1; i < sorted.length; i++) {
      cycles.add(sorted[i].startDate.difference(sorted[i - 1].startDate).inDays);
    }
    final avg = (cycles.reduce((a, b) => a + b) / cycles.length).round();
    final next = sorted.last.startDate.add(Duration(days: avg));
    final diff = next.difference(DateTime.now()).inDays;
    return diff < 1 ? 1 : diff;
  }

  bool isPeriodDay(DateTime date) {
    return periods.any((p) {
      if (_isSameDay(p.startDate, date)) return true;
      if (p.endDate != null) {
        return date.isAfter(p.startDate.subtract(const Duration(days: 1))) &&
               date.isBefore(p.endDate!.add(const Duration(days: 1)));
      }
      return false;
    });
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}