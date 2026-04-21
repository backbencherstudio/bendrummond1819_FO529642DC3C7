import 'package:flutter/material.dart';

class AddBillScreen extends StatefulWidget {
  const AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  // Color Palette
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color inputBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  bool _isRecurring = false;
  int _selectedFrequency = 0; // 0: Beginning, 1: Middle, 2: End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Top Bar: Back Button + Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBE5D8),
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
                    'Add bill',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: fontSerif,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _buildLabel("Bill Name"),
              const SizedBox(height: 8),
              _buildTextField(hint: "Electricity bill"),

              const SizedBox(height: 20),

              _buildLabel("Amount"),
              const SizedBox(height: 8),
              _buildTextField(hint: "100", isAmount: true),

              const SizedBox(height: 15),

              // Checkbox Row
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _isRecurring,
                      activeColor: darkBrown,
                      side: BorderSide(color: mutedBrown, width: 1.5),
                      onChanged: (val) => setState(() => _isRecurring = val!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Set as Weekly/Monthly Payment",
                    style: TextStyle(
                      fontFamily: fontSerif,
                      color: darkBrown,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildLabel("Frequency"),
              const SizedBox(height: 10),

              // Frequency Selection Cards
              _buildFrequencyCard(0, "Beginning of month", "1st – 10th"),
              const SizedBox(height: 12),
              _buildFrequencyCard(1, "Middle of month", "11th – 20th"),
              const SizedBox(height: 12),
              _buildFrequencyCard(2, "End of month", "21st – 31st"),

              const SizedBox(height: 12),

              // Custom Date Dropdown
              _buildCustomDateDropdown(),

              const SizedBox(height: 20),
              _buildLabel("Due day"),
              const SizedBox(height: 8),
              _buildTextField(hint: "4"),

              const SizedBox(height: 40),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(child: _buildButton("Delete", isSecondary: true)),
                  const SizedBox(width: 15),
                  Expanded(child: _buildButton("Add bill")),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: mutedBrown, fontSize: 16, fontFamily: fontSerif),
    );
  }

  Widget _buildTextField({required String hint, bool isAmount = false}) {
    return Container(
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: TextField(
        style: TextStyle(fontFamily: fontSerif, color: darkBrown, fontSize: 18),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: InputBorder.none,
          prefixIcon: isAmount
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  child: Text(
                    '\$',
                    style: TextStyle(
                      color: darkBrown,
                      fontSize: 18,
                      fontFamily: fontSerif,
                    ),
                  ),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildFrequencyCard(int index, String title, String subtitle) {
    bool isSelected = _selectedFrequency == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? darkBrown : Colors.black.withOpacity(0.08),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: fontSerif,
                    fontSize: 18,
                    color: darkBrown,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: fontSerif,
                    fontSize: 14,
                    color: mutedBrown,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: darkBrown, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDateDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, color: darkBrown, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              "Custom date",
              style: TextStyle(
                fontFamily: fontSerif,
                fontSize: 18,
                color: darkBrown,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: mutedBrown),
        ],
      ),
    );
  }

  Widget _buildButton(String label, {bool isSecondary = false}) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? inputBg : darkBrown,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSecondary
                ? BorderSide(color: Colors.black.withOpacity(0.08))
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSecondary ? darkBrown : Colors.white,
            fontSize: 18,
            fontFamily: fontSerif,
          ),
        ),
      ),
    );
  }
}
