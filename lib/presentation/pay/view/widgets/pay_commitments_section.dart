import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/staggered_fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_income_button.dart';
import 'commitment_card.dart';
import 'empty_section_text.dart';
import 'section_label.dart';

class PayCommitmentsSection extends StatelessWidget {
  final Animation<double> controller;
  final List<FinancialCommitmentData> commitments;
  final int totalItems;
  final int startIndex;
  final VoidCallback onAdd;

  const PayCommitmentsSection({
    super.key,
    required this.controller,
    required this.commitments,
    required this.totalItems,
    required this.startIndex,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Your pay'),
        SizedBox(height: 12.h),
        if (commitments.isEmpty)
          _item(startIndex, const EmptySectionText('No commitments yet'))
        else
          ...commitments.asMap().entries.map(
            (e) => _item(startIndex + e.key, CommitmentCard(commitment: e.value)),
          ),
        SizedBox(height: 16.h),
        _item(startIndex + (commitments.isEmpty ? 1 : commitments.length), AddIncomeButton(onTap: onAdd)),
      ],
    );
  }

  Widget _item(int index, Widget child) {
    final step = totalItems > 0 ? (0.5 / totalItems).clamp(0.0, 0.08) : 0.08;
    final delay = (index * step).clamp(0.0, 0.6);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: StaggeredFadeSlide(
        controller: controller,
        delay: delay,
        child: child,
      ),
    );
  }
}
