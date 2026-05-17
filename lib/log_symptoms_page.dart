import 'package:flutter/material.dart';

class LogSymptomsPage extends StatefulWidget {
  const LogSymptomsPage({super.key});

  @override
  State<LogSymptomsPage> createState() => _LogSymptomsPageState();
}

class _LogSymptomsPageState extends State<LogSymptomsPage> {

  String selectedFlow = "Medium";

  final List<String> symptoms = [
    "Cramps",
    "Headache",
    "Bloating",
    "Fatigue",
    "Back pain",
    "Breast tenderness",
    "Nausea",
    "Acne",
  ];

  final List<String> moods = [
    "Happy",
    "Anxious",
    "Irritable",
    "Sad",
    "Energetic",
    "Calm",
    "Stressed",
    "Emotional",
  ];

  final Set<String> selectedSymptoms = {};
  final Set<String> selectedMoods = {};

  final TextEditingController notesController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickDate(bool isStart) async {
    DateTime initial = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return "dd-mm-yyyy";

    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Log Symptoms",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            /// DATE SECTION
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Start Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 14),

                  dateField(
                    text: formatDate(startDate),
                    onTap: () => pickDate(true),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "End Date (Optional)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 14),

                  dateField(
                    text: formatDate(endDate),
                    onTap: () => pickDate(false),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// FLOW INTENSITY
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Flow Intensity",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      flowButton("Light"),
                      const SizedBox(width: 12),
                      flowButton("Medium"),
                      const SizedBox(width: 12),
                      flowButton("Heavy"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// SYMPTOMS
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Symptoms",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: symptoms.map((symptom) {

                      bool selected =
                          selectedSymptoms.contains(symptom);

                      return selectableChip(
                        text: symptom,
                        selected: selected,
                        activeColor: Colors.purple,
                        onTap: () {
                          setState(() {
                            if (selected) {
                              selectedSymptoms.remove(symptom);
                            } else {
                              selectedSymptoms.add(symptom);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// MOOD
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Mood",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: moods.map((mood) {

                      bool selected =
                          selectedMoods.contains(mood);

                      return selectableChip(
                        text: mood,
                        selected: selected,
                        activeColor: Colors.blue,
                        onTap: () {
                          setState(() {
                            if (selected) {
                              selectedMoods.remove(mood);
                            } else {
                              selectedMoods.add(mood);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// NOTES
            sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Notes (Optional)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Any additional notes...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(18),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Colors.pink.shade100,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Colors.pink.shade100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// BUTTON
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF2D95),
                    Color(0xFFFF008A),
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 7),
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  "Log Period",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget flowButton(String text) {

    bool selected = selectedFlow == text;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFlow = text;
          });
        },
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [
                      Color(0xFFFF4FA3),
                      Color(0xFF9C4DFF),
                    ],
                  )
                : null,
            color: selected ? null : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.pink.shade100,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.blueGrey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
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
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected
              ? activeColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: activeColor.withOpacity(0.3),
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

  Widget sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget dateField({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.pink.shade100,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: text == "dd-mm-yyyy"
                ? Colors.grey
                : Colors.black,
          ),
        ),
      ),
    );
  }
}