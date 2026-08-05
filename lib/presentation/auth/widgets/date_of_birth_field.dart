import 'package:flutter/material.dart';

import 'labeled_form_field.dart';

class DateOfBirthField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;

  const DateOfBirthField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.hintText = "MM/DD/YYYY",
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(2000),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledFormField(
      label: label,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      readOnly: true,
      onTap: () => _selectDate(context),
      validator:
          validator ??
          (value) => (value == null || value.isEmpty)
              ? "Please select your date of birth"
              : null,
    );
  }
}
