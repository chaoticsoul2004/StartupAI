import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  String _name = 'Sarah';
  String _age = '27';
  String _cycleLength = '28';
  String _periodLength = '5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC4B5F4), Color(0xFFDDD6FE), Color(0xFFEDE9FE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back, size: 18, color: Color(0xFF374151)),
                    ),
                  ),
                  // Edit button
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => setState(() => _editing = !_editing),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                        child: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4B5563)),
                      ),
                    ),
                  ),
                  // Avatar
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Container(
                          width: 76, height: 76,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
                          child: const Center(child: Text('🌸', style: TextStyle(fontSize: 36))),
                        ),
                        const SizedBox(height: 10),
                        Text(_name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                        Text('Age $_age', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stats grid
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.0,
                children: [
                  _StatCard(icon: Icons.calendar_today, label: 'Avg cycle', value: '$_cycleLength days', bg: const Color(0xFFCCFBF1), iconColor: const Color(0xFF0D9488)),
                  _StatCard(icon: Icons.water_drop_outlined, label: 'Period length', value: '$_periodLength days', bg: const Color(0xFFFCE7F3), iconColor: AppColors.pink),
                  _StatCard(icon: Icons.notifications_outlined, label: 'Reminders', value: 'On', bg: const Color(0xFFF5F3FF), iconColor: AppColors.violet),
                  _StatCard(icon: Icons.shield_outlined, label: 'Privacy', value: 'Protected', bg: const Color(0xFFD1FAE5), iconColor: const Color(0xFF059669)),
                ],
              ),
            ),

            // Personal info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF374151))),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        _InfoRow(label: 'Name', value: _name, editing: _editing, onChanged: (v) => setState(() => _name = v)),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        _InfoRow(label: 'Age', value: _age, editing: _editing, onChanged: (v) => setState(() => _age = v)),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        _InfoRow(label: 'Avg cycle length', value: '$_cycleLength days', editing: _editing, onChanged: (v) => setState(() => _cycleLength = v.replaceAll(' days', ''))),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        _InfoRow(label: 'Period duration', value: '$_periodLength days', editing: _editing, onChanged: (v) => setState(() => _periodLength = v.replaceAll(' days', ''))),
                      ],
                    ),
                  ),
                  if (_editing) ...[
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _editing = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.violet,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color bg, iconColor;
  const _StatCard({required this.icon, required this.label, required this.value, required this.bg, required this.iconColor});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF3F4F6))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 16)),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
    ]),
  );
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  final bool editing;
  final ValueChanged<String> onChanged;
  const _InfoRow({required this.label, required this.value, required this.editing, required this.onChanged});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      editing
          ? SizedBox(width: 120, child: TextFormField(
              initialValue: value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD8B4FE))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.violet))),
              onChanged: onChanged,
            ))
          : Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}