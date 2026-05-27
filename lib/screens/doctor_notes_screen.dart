import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class _Note {
  final String id, title, content, tag;
  final DateTime date;
  _Note({required this.id, required this.title, required this.content, required this.tag, required this.date});
}

class DoctorNotesScreen extends StatefulWidget {
  const DoctorNotesScreen({super.key});

  @override
  State<DoctorNotesScreen> createState() => _DoctorNotesScreenState();
}

class _DoctorNotesScreenState extends State<DoctorNotesScreen> {
  bool _showForm = false;
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String _tag = 'general';

  List<_Note> _notes = [
    _Note(id: '1', title: 'Annual checkup', content: 'Dr. recommended iron supplements for heavy flow. Follow up in 3 months.', tag: 'appointment', date: DateTime.now().subtract(const Duration(days: 7))),
  ];

  static const _tagColors = {
    'appointment': Color(0xFFDBEAFE),
    'prescription': Color(0xFFF3E8FF),
    'observation': Color(0xFFFEF3C7),
    'general': Color(0xFFF3F4F6),
  };

  static const _tagTextColors = {
    'appointment': Color(0xFF1D4ED8),
    'prescription': Color(0xFF7C3AED),
    'observation': Color(0xFFB45309),
    'general': Color(0xFF374151),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFC4B5F4), Color(0xFFDDD6FE), Color(0xFFEDE9FE)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: () => Navigator.of(context).pop(),
                      child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back, size: 18))),
                    const Text("Doctor's Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    GestureDetector(onTap: () => setState(() => _showForm = !_showForm),
                      child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                        child: const Icon(Icons.add, size: 18))),
                  ],
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.description_outlined, color: AppColors.violet, size: 22)),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${_notes.length} note${_notes.length != 1 ? 's' : ''}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const Text('Keep track of your health visits', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  ]),
                ]),
              ],
            ),
          ),

          // Add note form
          if (_showForm)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF5F3FF), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEDE9FE))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 10),
                    TextField(controller: _titleCtrl, decoration: InputDecoration(hintText: 'Title', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8B4FE))), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10))),
                    const SizedBox(height: 8),
                    TextField(controller: _contentCtrl, maxLines: 3, decoration: InputDecoration(hintText: 'Notes from your doctor...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD8B4FE))), contentPadding: const EdgeInsets.all(12))),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: ['general', 'appointment', 'prescription', 'observation'].map((tag) => ChoiceChip(label: Text(tag, style: TextStyle(fontSize: 11, color: _tag == tag ? _tagTextColors[tag] : const Color(0xFF6B7280))), selected: _tag == tag, onSelected: (_) => setState(() => _tag = tag), backgroundColor: Colors.white, selectedColor: _tagColors[tag])).toList()),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: OutlinedButton(onPressed: () => setState(() => _showForm = false), child: const Text('Cancel'))),
                      const SizedBox(width: 10),
                      Expanded(child: ElevatedButton(
                        onPressed: _titleCtrl.text.trim().isEmpty ? null : () {
                          setState(() {
                            _notes.insert(0, _Note(id: DateTime.now().toString(), title: _titleCtrl.text, content: _contentCtrl.text, tag: _tag, date: DateTime.now()));
                            _titleCtrl.clear(); _contentCtrl.clear(); _showForm = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.violet),
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      )),
                    ]),
                  ],
                ),
              ),
            ),

          // Notes list
          Expanded(
            child: _notes.isEmpty
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.description_outlined, size: 40, color: Color(0xFFD1D5DB)), SizedBox(height: 12), Text('No notes yet', style: TextStyle(color: Color(0xFF9CA3AF)))]))
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: _notes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final n = _notes[i];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF3F4F6))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _tagColors[n.tag], borderRadius: BorderRadius.circular(20)),
                              child: Text(n.tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _tagTextColors[n.tag]))),
                            const Spacer(),
                            GestureDetector(onTap: () => setState(() => _notes.removeWhere((x) => x.id == n.id)),
                              child: const Icon(Icons.delete_outline, size: 16, color: Color(0xFFD1D5DB))),
                          ]),
                          const SizedBox(height: 6),
                          Text(n.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          if (n.content.isNotEmpty) ...[const SizedBox(height: 4), Text(n.content, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)))],
                          const SizedBox(height: 8),
                          Row(children: [const Icon(Icons.calendar_today, size: 11, color: Color(0xFF9CA3AF)), const SizedBox(width: 4), Text(DateFormat('MMM d, yyyy').format(n.date), style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)))]),
                        ]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}