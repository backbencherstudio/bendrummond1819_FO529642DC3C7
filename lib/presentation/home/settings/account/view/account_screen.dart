import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Color Palette matching your UI design
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color inputBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

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
                    'Account',
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

              // Profile Image with Edit Icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://pbs.twimg.com/profile_images/1564398871996174336/M-N6gu7M_400x400.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: darkBrown,
                          shape: BoxShape.circle,
                          border: Border.all(color: bgColor, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Form Fields
              _buildLabel("Your full name"),
              const SizedBox(height: 8),
              _buildTextField(hint: "Yasir Abed Rabbu"),

              const SizedBox(height: 20),
              _buildLabel("Email address"),
              const SizedBox(height: 8),
              _buildTextField(hint: "yasir@gmail.com"),

              const SizedBox(height: 20),
              _buildLabel("Password"),
              const SizedBox(height: 8),
              _buildTextField(hint: "Your password", isPassword: true),

              const SizedBox(height: 20),
              _buildLabel("Confirm Password"),
              const SizedBox(height: 8),
              _buildTextField(hint: "Confirm your password", isPassword: true),

              const SizedBox(height: 20),
              _buildLabel("Phone number"),
              const SizedBox(height: 8),
              _buildTextField(hint: "(123) 456-7890"),

              const SizedBox(height: 20),
              _buildLabel("Date of birth"),
              const SizedBox(height: 8),
              _buildTextField(hint: "MM/DD/YYYY"),

              const SizedBox(height: 40),

              // Action Buttons
              Row(
                children: [
                  Expanded(child: _buildButton("Cancel", isSecondary: true)),
                  const SizedBox(width: 15),
                  Expanded(child: _buildButton("Save")),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: Section Labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: mutedBrown, fontSize: 15, fontFamily: fontSerif),
    );
  }

  // Helper: Custom Text Field
  Widget _buildTextField({required String hint, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(fontFamily: fontSerif, color: darkBrown, fontSize: 17),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: darkBrown.withOpacity(0.5)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? Icon(
                  Icons.visibility_outlined,
                  color: darkBrown.withOpacity(0.6),
                  size: 22,
                )
              : null,
        ),
      ),
    );
  }

  // Helper: Bottom Buttons
  Widget _buildButton(String label, {bool isSecondary = false}) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : darkBrown,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSecondary
                ? BorderSide(color: Colors.black.withOpacity(0.1))
                : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSecondary ? darkBrown : Colors.white,
            fontSize: 17,
            fontFamily: fontSerif,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
