class PeriodLog {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String flow; // 'light', 'medium', 'heavy'
  final List<String> symptoms;
  final List<String> mood;
  final String notes;

  PeriodLog({
    required this.id,
    required this.startDate,
    this.endDate,
    this.flow = 'medium',
    this.symptoms = const [],
    this.mood = const [],
    this.notes = '',
  });
}