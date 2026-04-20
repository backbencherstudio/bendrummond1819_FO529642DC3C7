import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  // Color Palette
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color inputBg = const Color(0xFFFAF8F3);
  final Color chipBg = const Color(
    0xFFF7F9FB,
  ); // Very light greyish-white for chips
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // ======== Back Button & Title =========
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBE5D8), // Slightly darker beige
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: darkBrown,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Add goal',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: fontSerif,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // ========== Saving for Section ================
              _buildLabel("What are you saving for?"),
              const SizedBox(height: 10),
              CustomFromField(hintText: 'Buy a Iphone 17 Pro'),

              const SizedBox(height: 15),

              // Suggestion Chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSuggestionChip("Emergency fund"),
                  _buildSuggestionChip("Vacation"),
                  _buildSuggestionChip("New car"),
                  _buildSuggestionChip("Down payment"),
                  _buildSuggestionChip("Holiday gifts"),
                ],
              ),

              const SizedBox(height: 25),

              // ===================== Amount ========================
              _buildLabel("Amount"),
              const SizedBox(height: 10),
              CustomFromField(hintText: '\$ 60'),

              const SizedBox(height: 25),

              // ================ Frequency Section ===================
              _buildLabel("Frequency"),
              const SizedBox(height: 10),
              _buildDropdownField("Per month"),
              const SizedBox(height: 40),
              // ================ Add Goal Button =====================
              PrimaryButton(title: 'Add Goal', onTap: () {}),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========== Section Labels ===========
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: mutedBrown, fontSize: 16, fontFamily: fontSerif),
    );
  }

  // ======= Suggestion Chip ==========
  Widget _buildSuggestionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: mutedBrown,
          fontSize: 15,
          fontFamily: fontSerif,
        ),
      ),
    );
  }

  // ======== Dropdown Field ==============
  Widget _buildDropdownField(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.keyboard_arrow_down, color: darkBrown),
          isExpanded: true,
          style: TextStyle(
            color: darkBrown,
            fontSize: 18,
            fontFamily: fontSerif,
          ),
          items: [value].map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}
