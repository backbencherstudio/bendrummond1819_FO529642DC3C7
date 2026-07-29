import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../pay/view/widgets/empty_section_text.dart';
import '../../../pay/view/widgets/section_label.dart';

class TitledListSection<T> extends StatelessWidget {
  final String? title;
  final List<T> items;
  final String emptyText;
  final Widget Function(T item, int index) itemBuilder;
  final double itemSpacing;

  const TitledListSection({
    super.key,
    this.title,
    required this.items,
    required this.emptyText,
    required this.itemBuilder,
    this.itemSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          SectionLabel(title!),
          SizedBox(height: 12.h),
        ],
        if (items.isEmpty)
          EmptySectionText(emptyText)
        else
          ...List.generate(
            items.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: itemSpacing.h),
              child: itemBuilder(items[index], index),
            ),
          ),
      ],
    );
  }
}
