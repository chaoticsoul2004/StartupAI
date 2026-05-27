import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'profile_screen.dart';
import 'doctor_notes_screen.dart';
import 'history_analysis_screen.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.person_outline, 'label': 'Profile', 'bg': const Color(0xFFF5F3FF), 'iconColor': AppColors.violet, 'screen': const ProfileScreen()},
      {'icon': Icons.description_outlined, 'label': "Doctor's Note", 'bg': const Color(0xFFFDF2F8), 'iconColor': const Color(0xFFDB2777), 'screen': const DoctorNotesScreen()},
      {'icon': Icons.bar_chart, 'label': 'History Analysis', 'bg': const Color(0xFFFFF7ED), 'iconColor': const Color(0xFFD97706), 'screen': const HistoryAnalysisScreen()},
    ];

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFC4B5F4), Color(0xFFDDD6FE), Color(0xFFEDE9FE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('🌸', style: TextStyle(fontSize: 28))),
                ),
                const SizedBox(height: 12),
                const Text('Hello!', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF4C1D95))),
                const Text('Manage your health', style: TextStyle(fontSize: 12, color: Color(0xFF7C3AED), fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                ...items.map((item) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  leading: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: item['bg'] as Color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item['icon'] as IconData, color: item['iconColor'] as Color, size: 18),
                  ),
                  title: Text(item['label'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  trailing: const Icon(Icons.chevron_right, color: Color(0xFFD1D5DB), size: 18),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => item['screen'] as Widget));
                  },
                )),

                const Divider(indent: 24, endIndent: 24),

                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  leading: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.logout, color: Color(0xFFF87171), size: 18),
                  ),
                  title: const Text('Logout', style: TextStyle(color: Color(0xFFF87171), fontWeight: FontWeight.bold, fontSize: 14)),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text('GlowHealth · v1.0', style: TextStyle(color: Color(0xFFDDD6FE), fontSize: 10, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}