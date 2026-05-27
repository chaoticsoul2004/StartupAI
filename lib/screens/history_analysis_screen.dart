import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/app_state.dart';

class HistoryAnalysisScreen extends StatelessWidget {
  const HistoryAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final periods = AppState().periods;
    final sorted = [...periods]..sort((a, b) => a.startDate.compareTo(b.startDate));

    final avgCycle = sorted.length >= 2
        ? () {
            int total = 0;
            for (int i = 1; i < sorted.length; i++) total += sorted[i].startDate.difference(sorted[i - 1].startDate).inDays;
            return (total / (sorted.length - 1)).round();
          }()
        : 28;

    final avgDuration = sorted.isNotEmpty
        ? () {
            int total = 0;
            for (final p in sorted) total += p.endDate != null ? p.endDate!.difference(p.startDate).inDays + 1 : 1;
            return (total / sorted.length).round();
          }()
        : 5;

    final stats = [
      {'icon': Icons.calendar_today, 'label': 'Avg Cycle', 'value': '${avgCycle}d', 'bg': const Color(0xFFCCFBF1), 'iconColor': const Color(0xFF0D9488)},
      {'icon': Icons.water_drop_outlined, 'label': 'Avg Period', 'value': '${avgDuration}d', 'bg': const Color(0xFFFCE7F3), 'iconColor': AppColors.pink},
      {'icon': Icons.track_changes, 'label': 'Cycles Tracked', 'value': '${sorted.length}', 'bg': const Color(0xFFF5F3FF), 'iconColor': AppColors.violet},
      {'icon': Icons.trending_up, 'label': 'Regularity', 'value': sorted.length > 1 ? 'Regular' : 'N/A', 'bg': const Color(0xFFD1FAE5), 'iconColor': const Color(0xFF059669)},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFC4B5F4), Color(0xFFDDD6FE), Color(0xFFEDE9FE)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    GestureDetector(onTap: () => Navigator.of(context).pop(),
                      child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, size: 18))),
                    const Text('History Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 36),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.trending_up, color: AppColors.violet, size: 22)),
                    const SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Cycle insights', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('Based on ${sorted.length} logged period${sorted.length != 1 ? 's' : ''}', style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    ]),
                  ]),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Stat cards grid
                  GridView.count(
                    crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6,
                    children: stats.map((s) => Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF3F4F6))),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(width: 32, height: 32, decoration: BoxDecoration(color: s['bg'] as Color, borderRadius: BorderRadius.circular(10)), child: Icon(s['icon'] as IconData, color: s['iconColor'] as Color, size: 16)),
                        const SizedBox(height: 6),
                        Text(s['value'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                        Text(s['label'] as String, style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                      ]),
                    )).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Empty or period history
                  if (sorted.isEmpty)
                    Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(16)),
                      child: const Center(child: Text('Log at least 2 periods to see cycle trends', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)), textAlign: TextAlign.center)))
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF3F4F6))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Period History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(height: 12),
                          ...sorted.reversed.map((p) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(children: [
                              Text('${p.startDate.day}/${p.startDate.month}/${p.startDate.year}', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                              const Spacer(),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFFCE7F3), borderRadius: BorderRadius.circular(20)),
                                child: Text(p.flow, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.pink))),
                              const SizedBox(width: 8),
                              Text('${p.endDate != null ? p.endDate!.difference(p.startDate).inDays + 1 : 1}d', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            ]),
                          )),
                        ],
                      ),
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