import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/add_action_button.dart';
import 'package:flutter/material.dart';

class AddIncomeButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddIncomeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AddActionButton(label: 'Add an income', onTap: onTap);
  }
}
