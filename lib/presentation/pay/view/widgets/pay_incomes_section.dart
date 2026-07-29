import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/stagger_delay_for.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/staggered_fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'empty_section_text.dart';
import 'income_card.dart';
import 'section_label.dart';

class PayIncomesSection extends StatelessWidget {
  final Animation<double> controller;
  final List<IncomeData> incomes;
  final int totalItems;
  final int startIndex;
  final void Function(IncomeData) onEdit;

  const PayIncomesSection({
    super.key,
    required this.controller,
    required this.incomes,
    required this.totalItems,
    required this.startIndex,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Your incomes'),
        SizedBox(height: 12.h),
        if (incomes.isEmpty)
          _item(startIndex, const EmptySectionText('No incomes yet'))
        else
          ...incomes.asMap().entries.map(
            (e) => _item(startIndex + e.key, IncomeCard(
              income: e.value,
              onTap: () => onEdit(e.value),
            )),
          ),
      ],
    );
  }

  Widget _item(int index, Widget child) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: StaggeredFadeSlide(
        controller: controller,
        delay: staggerDelayFor(index, totalItems),
        child: child,
      ),
    );
  }
}
