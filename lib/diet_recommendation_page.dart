import 'package:flutter/material.dart';

class DietRecommendationPage extends StatefulWidget {
  const DietRecommendationPage({super.key});

  @override
  State<DietRecommendationPage> createState() =>
      _DietRecommendationPageState();
}

class _DietRecommendationPageState
    extends State<DietRecommendationPage> {

  String? selectedGoal;

  final Set<String> selectedRestrictions = {};
  final Set<String> selectedSymptoms = {};

  final List<String> goals = [
    "Reduce cramps",
    "Boost energy",
    "Reduce bloating",
    "Improve mood",
    "Better sleep",
    "Reduce inflammation",
  ];

  final List<String> restrictions = [
    "Vegetarian",
    "Vegan",
    "Gluten-free",
    "Dairy-free",
    "Nut-free",
    "No restrictions",
  ];

  final List<String> symptoms = [
    "Heavy flow",
    "Fatigue",
    "Mood swings",
    "Headaches",
    "Breast tenderness",
    "Acne",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Diet Recommendation",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// GOALS
            const Text(
              "What's your main goal?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: goals.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {

                final goal = goals[index];

                bool selected = selectedGoal == goal;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGoal = goal;
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      gradient: selected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF00C97B),
                                Color(0xFF00A86B),
                              ],
                            )
                          : null,
                      color: selected
                          ? null
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        goal,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.blueGrey.shade900,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 35),

            /// RESTRICTIONS
            const Text(
              "Dietary restrictions (select all that apply)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 12,
              runSpacing: 14,
              children: restrictions.map((item) {

                bool selected =
                    selectedRestrictions.contains(item);

                return selectableChip(
                  text: item,
                  selected: selected,
                  activeColor: Colors.green,
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedRestrictions.remove(item);
                      } else {
                        selectedRestrictions.add(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            /// SYMPTOMS
            const Text(
              "Current symptoms (optional)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 12,
              runSpacing: 14,
              children: symptoms.map((item) {

                bool selected =
                    selectedSymptoms.contains(item);

                return selectableChip(
                  text: item,
                  selected: selected,
                  activeColor: Colors.pink,
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedSymptoms.remove(item);
                      } else {
                        selectedSymptoms.add(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            /// BUTTON
            Container(
              width: double.infinity,
              height: 65,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00C97B),
                    Color(0xFF00A86B),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Get Recommendations",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget selectableChip({
    required String text,
    required bool selected,
    required VoidCallback onTap,
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected
              ? activeColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: activeColor.withOpacity(0.35),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: activeColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}