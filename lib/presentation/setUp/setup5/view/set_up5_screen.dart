import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup6/view/set_up6_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetUp5Screen extends ConsumerStatefulWidget {
  const SetUp5Screen({super.key});

  @override
  ConsumerState<SetUp5Screen> createState() => _SetUp5ScreenState();
}

class _SetUp5ScreenState extends ConsumerState<SetUp5Screen> {
  bool isChecked = false;

  // --- Theme Colors ---
  final Color bgColor = const Color(0xFFF9F6F1); // Cream background
  final Color darkBrown = const Color(0xFF514239); // Main dark brown
  final Color mutedBrown = const Color(0xFF8B7A70); // Subtext/Prefix color
  final Color progressTrack = const Color(0xFFE8E4D8); // Light progress track
  final Color inputBg = const Color(0xFFFDFCF9); // Very light input fill

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

              // --- Header: Back Button & Progress ---
              Row(
                children: [
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
                          color: darkBrown,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$currentStep of $totalSteps",
                          style: TextStyle(
                            color: mutedBrown,
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
                            color: darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- Title ---
              Text(
                "Any car payment?",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: darkBrown,
                  fontFamily: 'serif', // Serif look
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 15),

              // --- Subtitle ---
              Text(
                "Monthly car loan or lease amount.",
                style: TextStyle(fontSize: 18, color: mutedBrown, height: 1.3),
              ),

              const SizedBox(height: 35),

              // --- Custom Text Input ---
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
                  style: TextStyle(fontSize: 22, color: mutedBrown),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Text(
                        "\$",
                        style: TextStyle(fontSize: 22, color: mutedBrown),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    hintText: "500",
                    hintStyle: TextStyle(
                      color: mutedBrown.withValues(alpha: 0.5),
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
                      activeColor: darkBrown,
                      side: BorderSide(color: mutedBrown, width: 1.5),
                      onChanged: (val) => setState(() => isChecked = val!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Set as Weekly/Monthly Payment",
                    style: TextStyle(color: darkBrown, fontSize: 16),
                  ),
                ],
              ),

              const Spacer(), // Pushes buttons to bottom
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
                        builder: (context) => const SetUp6Screen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBrown,
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
                      fontFamily: 'serif',
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
                    backgroundColor: inputBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "No car payment right now",
                    style: TextStyle(
                      color: darkBrown,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'serif',
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
