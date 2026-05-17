import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'log_symptoms_page.dart';
import 'diet_recommendation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final Set<DateTime> periodDays = {};

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void togglePeriod(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);

    setState(() {
      if (periodDays.any((d) => isSameDate(d, normalized))) {
        periodDays.removeWhere((d) => isSameDate(d, normalized));
      } else {
        periodDays.add(normalized);
      }
    });
  }

  bool isPeriodDay(DateTime day) {
    return periodDays.any((d) => isSameDate(d, day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFFF008A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Stats",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Calendar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TableCalendar(
                  focusedDay: focusedDay,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),

                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDay, day);
                  },

                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                      focusedDay = focused;
                    });
                  },

                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),

                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFFF008A),
                      shape: BoxShape.circle,
                    ),

                    markerDecoration: const BoxDecoration(
                      color: Color(0xFFFF008A),
                      shape: BoxShape.circle,
                    ),

                    outsideDaysVisible: false,
                  ),

                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      if (isPeriodDay(day)) {
                        return Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF008A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }

                      return null;
                    },
                  ),

                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Button
              GestureDetector(
                onTap: () {
                  if (selectedDay != null) {
                    togglePeriod(selectedDay!);
                  }
                },
                child: Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF008A),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      selectedDay == null
                          ? "Select a Date"
                          : isPeriodDay(selectedDay!)
                          ? "Remove Period Log"
                          : "Log Period",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "My daily insights · Today",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LogSymptomsPage(),
                        ),
                      );
                    },

                    child: card(
                      title: "Log your\nsymptoms",
                      icon: Icons.add,
                      color: Colors.white,
                      border: true,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DietRecommendationPage(),
                        ),
                      );
                    },

                    child: card(
                      title: "Diet\nRecommendation",
                      icon: Icons.apple,
                      color: const Color(0xFF08C25E),
                      textColor: Colors.white,
                      button: true,
                    ),
                  ),

                  card(
                    title: "PMS or\npregnancy?",
                    icon: Icons.favorite,
                    color: const Color(0xFFF7DDED),
                  ),

                  card(
                    title: "Emotional\nwellness",
                    icon: Icons.psychology,
                    color: const Color(0xFFF7E8CF),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card({
    required String title,
    required IconData icon,
    required Color color,
    bool border = false,
    bool button = false,
    Color textColor = Colors.black,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        border: border ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(icon, color: textColor, size: 30),
          ),

          const Spacer(),

          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),

          if (button) ...[
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "GET STARTED",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
