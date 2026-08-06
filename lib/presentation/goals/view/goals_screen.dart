import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/utils.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/setup_data_api_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/stagger_delay_for.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/utils/staggered_fade_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/goal_card.dart';
import 'widgets/section_header_add_button.dart';
import 'widgets/titled_list_section.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    Future.microtask(() async {
      await ref.read(savingGoalsProvider.notifier).fetchGoals();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(savingGoalsProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals',
                style: getSemiBoldStyle22(color: ColorManager.textPrimary),
              ),
              SizedBox(height: 24.h),
              SectionHeaderAddButton(
                label: 'Your future goals',
                onAddTap: () =>
                    Navigator.pushNamed(context, RoutesName.addGoalScreen),
              ),
              SizedBox(height: 16.h),
              TitledListSection(
                items: goals,
                emptyText: 'No goals yet',
                itemBuilder: (goal, index) => StaggeredFadeSlide(
                  controller: _controller,
                  delay: staggerDelayFor(index, goals.length),
                  child: GoalCard(
                    title: goal.goalName,
                    subtitle:
                        "\$${goal.contribution.toStringAsFixed(0)}/${goal.frequency.toLowerCase()}",
                    onDelete: () => _deleteGoal(goal.id),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteGoal(String? id) async {
    if (id == null) return;
    final success = await ref.read(savingGoalsProvider.notifier).deleteGoal(id);
    if (context.mounted) {
      Utils.showToast(
        message: success ? "Goal deleted" : "Failed to delete goal",
        backgroundColor: success
            ? ColorManager.successColor
            : ColorManager.errorColor,
        textColor: ColorManager.whiteColor,
      );
    }
  }
}
