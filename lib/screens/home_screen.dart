import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../state/app_state.dart';
import '../widgets/week_calendar.dart';
import 'log_period_screen.dart';
import 'symptom_tracker_screen.dart';
import 'diet_recommendation_screen.dart';
import 'sidebar_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final daysToNext = AppState().getDaysToNextPeriod();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SidebarDrawer(),
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: 320,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.headerGradient,
              ),
            ),
          ),

          // Decorative orb top-right
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ── Header ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Sidebar button (🌸)
                            Builder(builder: (ctx) => GestureDetector(
                              onTap: () => Scaffold.of(ctx).openDrawer(),
                              child: Builder(
  builder: (ctx) => GestureDetector(
    onTap: () => Scaffold.of(ctx).openDrawer(),
    child: Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Center(
        child: Text(
          '🌸',
          style: TextStyle(fontSize: 22),
        ),
      ),
    ),
  ),
),
                            )),

                            // Date label
                            Text(
                              DateFormat('MMMM d').format(DateTime.now()),
                              style: TextStyle(
                                color: AppColors.violetDark.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            // Calendar button
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.white.withOpacity(0.6)),
                              ),
                              child: const Column(
                                children: [
                                  Icon(Icons.calendar_month, size: 16, color: AppColors.violet),
                                  SizedBox(height: 2),
                                  Text('TODAY', style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.violet,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),
                        const WeekCalendar(),
                      ],
                    ),
                  ),

                  // ── White card overlapping gradient ──
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 18),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x147C3AED),
                          blurRadius: 24,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Prediction label
                          const Text(
                            'PREDICTION',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.violet,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Period in',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF111827),
                            ),
                          ),
                          Text(
                            '$daysToNext days',
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'See why fertility chances may be elevated',
                                style: TextStyle(fontSize: 11, color: AppColors.grey, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.chevron_right, size: 14, color: AppColors.grey),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ── 3 Action buttons ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _ActionButton(
                                emoji: null,
                                icon: Icons.water_drop,
                                label: 'Log period',
                                filled: true,
                                onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LogPeriodScreen()),
      ),
                              ),
                              _ActionButton(
                                emoji: '✨',
                                icon: null,
                                label: 'Symptoms',
                                filled: false,
                                onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SymptomTrackerScreen()),
      ),
                              ),
                              _ActionButton(
                                emoji: '🍎',
                                icon: null,
                                label: 'Diet',
                                filled: false,
                                onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const DietRecommendationPage()),
      ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // ── Daily Insights ──
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'My daily insights · Today',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          SizedBox(
                            height: 130,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                _InsightCard(
                                  emoji: '😊',
                                  title: 'Track your mood today',
                                  subtitle: 'Tap to log',
                                  gradient: [Color(0xFF4C1D95), Color(0xFF5B21B6)],
                                ),
                                SizedBox(width: 12),
                                _InsightCard(
                                  emoji: '🌙',
                                  title: 'Your cycle this week',
                                  subtitle: 'Follicular phase',
                                  gradient: [Color(0xFFDB2777), Color(0xFFEC4899)],
                                ),
                                SizedBox(width: 12),
                                _InsightCard(
                                  emoji: '🥗',
                                  title: 'Diet Recommendation',
                                  subtitle: 'Tap to get yours',
                                  gradient: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
                                ),
                                SizedBox(width: 12),
                                _InsightCard(
                                  emoji: '💧',
                                  title: 'Stay hydrated',
                                  subtitle: '8 glasses/day',
                                  gradient: [Color(0xFFEDE9FE), Color(0xFFDDD6FE)],
                                  darkText: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action Button Widget ──
class _ActionButton extends StatelessWidget {
  final String? emoji;
  final IconData? icon;
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    this.emoji,
    this.icon,
    required this.label,
    required this.filled,
    required this.onTap,
  });

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: filled
                  ? const LinearGradient(
                      colors: [Color(0xFFF472B6), Color(0xFFEC4899)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: filled ? null : Colors.white,
              border: filled
                  ? null
                  : Border.all(color: const Color(0xFFE9D5FF), width: 2),
              boxShadow: [
                BoxShadow(
                  color: filled
                      ? const Color(0xFFF472B6).withOpacity(0.35)
                      : const Color(0xFFA78BFA).withOpacity(0.2),
                  blurRadius: filled ? 20 : 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: emoji != null
                  ? Text(emoji!, style: const TextStyle(fontSize: 24))
                  : Icon(icon, color: filled ? Colors.white : AppColors.violet, size: 22),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Insight Card Widget ──
class _InsightCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final bool darkText;

  const _InsightCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    this.darkText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: darkText ? AppColors.violetDark : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: darkText
                  ? AppColors.violet.withOpacity(0.7)
                  : Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}