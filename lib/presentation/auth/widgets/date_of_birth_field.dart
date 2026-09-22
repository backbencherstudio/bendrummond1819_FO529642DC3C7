import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'labeled_form_field.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 2 && nonZeroIndex != text.length) {
        buffer.write('/');
      } else if (nonZeroIndex == 4 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class DateOfBirthField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const DateOfBirthField({
    super.key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.hintText = "DD/MM/YYYY",
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.onChanged,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(2000),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
      onChanged?.call(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledFormField(
      label: label,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      readOnly: false,
      keyboardType: TextInputType.number,
      inputFormatters: [DateInputFormatter()],
      trailing: GestureDetector(
        onTap: () => _selectDate(context),
        child: const Icon(Icons.calendar_today, size: 20),
      ),
      validator:
          validator ??
          (value) => (value == null || value.isEmpty)
              ? "Please enter your date of birth"
              : null,
      onChanged: onChanged,
    );
  }
}
