import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup5/view/set_up5_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetUp4Screen extends ConsumerStatefulWidget {
  const SetUp4Screen({super.key});

  @override
  ConsumerState<SetUp4Screen> createState() => _SetUp4ScreenState();
}

class _SetUp4ScreenState extends ConsumerState<SetUp4Screen> {
  bool isChecked = false;

  // --- Exact Colors from the Image ---
  final Color bgColor = const Color(0xFFF9F6F1); // Light cream background
  final Color darkText = const Color(0xFF514139); // Dark chocolate brown
  final Color lightText = const Color(0xFF7A7067); // Muted brown/grey
  final Color infoBoxBg = const Color(0xFFEBE3D5); // Tan info box
  final Color inputBg = const Color(0xFFFDFCF9); // Very light input background
  final Color progressTrack = const Color(0xFFE8E4D8); // Progress bar track

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(setupStepProvider);
    final notifier = ref.read(setupStepProvider.notifier);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // --- Header: Back Button and Progress ---
              Row(
                children: [
                  // Back Button Circle
                  GestureDetector(
                    onTap: () {
                      notifier.previousStep();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEFE6D8),
                        border: Border.all(
                          color: Colors.brown.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: darkText,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Progress Text and Bar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$currentStep of $totalSteps",
                          style: TextStyle(
                            color: lightText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: currentStep / totalSteps,
                            minHeight: 6,
                            backgroundColor: progressTrack,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- Heading ---
              Text(
                "What's your rent or\nmortgage?",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  fontFamily: 'serif', // Use a Serif font if you have one
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 15),

              // --- Subtext ---
              Text(
                "Monthly amount. Include whatever you pay\neach month.",
                style: TextStyle(fontSize: 18, color: lightText, height: 1.3),
              ),

              const SizedBox(height: 35),

              // --- Input Field ---
              Container(
                decoration: BoxDecoration(
                  color: inputBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 22, color: lightText),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Text(
                        "\$",
                        style: TextStyle(fontSize: 22, color: lightText),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    hintText: "500",
                    hintStyle: TextStyle(
                      color: lightText.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Checkbox Row ---
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: darkText,
                      side: BorderSide(color: lightText, width: 1.5),
                      onChanged: (val) => setState(() => isChecked = val!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Set as Weekly/Monthly Payment",
                    style: TextStyle(color: darkText, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // --- Info Box ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: infoBoxBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "Your biggest bill first. Everything else\ngets smaller from here.",
                  style: TextStyle(
                    color: darkText.withValues(alpha: 0.8),
                    fontSize: 17,
                    height: 1.3,
                  ),
                ),
              ),

              const Spacer(),

              // --- Action Buttons ---
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.nextStep();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetUp5Screen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkText,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 65,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "No rent right now",
                    style: TextStyle(
                      color: darkText,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
