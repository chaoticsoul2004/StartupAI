import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class SymptomTrackerScreen extends StatefulWidget {
  const SymptomTrackerScreen({super.key});

  @override
  State<SymptomTrackerScreen> createState() => _SymptomTrackerScreenState();
}

class _SymptomTrackerScreenState extends State<SymptomTrackerScreen> {
  DateTime _currentDate = DateTime.now();
  final Set<String> _selected = {};
  final TextEditingController _searchCtrl = TextEditingController();

  static const _sections = [
    {
      'title': 'Symptoms',
      'items': [
        {'label': 'Everything is fine', 'emoji': '🙂'},
        {'label': 'Cramps', 'emoji': '😣'},
        {'label': 'Tender breasts', 'emoji': '🌸'},
        {'label': 'Headache', 'emoji': '🤕'},
        {'label': 'Acne', 'emoji': '✨'},
        {'label': 'Backache', 'emoji': '💆'},
        {'label': 'Fatigue', 'emoji': '😴'},
        {'label': 'Cravings', 'emoji': '🍩'},
        {'label': 'Insomnia', 'emoji': '🌙'},
        {'label': 'Abdominal pain', 'emoji': '😖'},
      ],
    },
    {
      'title': 'Vaginal discharge',
      'items': [
        {'label': 'No discharge', 'emoji': '✅'},
        {'label': 'Creamy', 'emoji': '🥛'},
        {'label': 'Watery', 'emoji': '💧'},
        {'label': 'Sticky', 'emoji': '🍯'},
        {'label': 'Egg white', 'emoji': '🥚'},
        {'label': 'Spotting', 'emoji': '🩸'},
        {'label': 'Unusual', 'emoji': '❓'},
      ],
    },
    {
      'title': 'Mood',
      'items': [
        {'label': 'Happy', 'emoji': '😊'},
        {'label': 'Sensitive', 'emoji': '🥺'},
        {'label': 'Sad', 'emoji': '😢'},
        {'label': 'Anxious', 'emoji': '😰'},
        {'label': 'Irritable', 'emoji': '😤'},
        {'label': 'Calm', 'emoji': '😌'},
        {'label': 'Stressed', 'emoji': '😩'},
        {'label': 'Energetic', 'emoji': '⚡'},
      ],
    },
    {
      'title': 'Energy & sleep',
      'items': [
        {'label': 'High energy', 'emoji': '🚀'},
        {'label': 'Low energy', 'emoji': '🔋'},
        {'label': 'Slept well', 'emoji': '😴'},
        {'label': 'Poor sleep', 'emoji': '😵'},
        {'label': 'Napped', 'emoji': '🛌'},
        {'label': 'Well rested', 'emoji': '✨'},
      ],
    },
  ];

  bool _isToday(DateTime d) {
    final t = DateTime.now();
    return d.year == t.year && d.month == t.month && d.day == t.day;
  }

  @override
  Widget build(BuildContext context) {
    final search = _searchCtrl.text.toLowerCase();
    final filteredSections = _sections.map((s) {
      final items = (s['items'] as List).where((item) =>
        search.isEmpty || (item['label'] as String).toLowerCase().contains(search)
      ).toList();
      return {'title': s['title'], 'items': items};
    }).where((s) => (s['items'] as List).isNotEmpty).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                children: [
                  // Date navigator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () => setState(() => _currentDate = _currentDate.subtract(const Duration(days: 1))),
                      ),
                      Column(
                        children: [
                          Text(
                            _isToday(_currentDate) ? 'Today' : DateFormat('MMMM d').format(_currentDate),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => setState(() => _currentDate = _currentDate.add(const Duration(days: 1))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 16, color: Color(0xFF9CA3AF)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchCtrl,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Sections list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: filteredSections.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, si) {
                  final section = filteredSections[si];
                  final items = section['items'] as List;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF5F3FF)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 3.2,
                          ),
                          itemCount: items.length,
                          itemBuilder: (_, i) {
                            final item = items[i] as Map;
                            final sel = _selected.contains(item['label']);
                            return GestureDetector(
                              onTap: () => setState(() {
                                if (sel) _selected.remove(item['label']);
                                else _selected.add(item['label'] as String);
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: sel ? const Color(0xFFF5F3FF) : const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: sel ? const Color(0xFFD8B4FE) : Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30, height: 30,
                                      decoration: BoxDecoration(
                                        color: sel ? const Color(0xFFEDE9FE) : Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(child: Text(item['emoji'] as String, style: const TextStyle(fontSize: 14))),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item['label'] as String,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: sel ? const Color(0xFF6D28D9) : const Color(0xFF374151),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Save button (shows when items selected)
            if (_selected.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _selected.clear());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.violet,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Save ${_selected.length} symptom${_selected.length > 1 ? 's' : ''}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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