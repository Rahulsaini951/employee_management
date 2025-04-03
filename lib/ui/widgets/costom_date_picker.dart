import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talent_track/blocs/custom_date_picker/custom_date_picker_cubit.dart';
import 'package:talent_track/ui/common/app_colors.dart';
import 'package:talent_track/ui/common/app_theme.dart';
import 'package:talent_track/ui/widgets/custom_app_button.dart';
import 'package:talent_track/utils/string_util.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime?) onDateSelected;
  final bool isFromDate;
  final DateTime? minDate;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    required this.onDateSelected,
    required this.isFromDate,
    this.minDate,
  });

  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    required bool isFromDate,
    DateTime? minDate,
  }) async {
    return await showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: BlocProvider(
            create: (_) => DatePickerCubit(
              initialDate: initialDate,
              minDate: minDate,
            ),
            child: CustomDatePicker(
              initialDate: initialDate,
              isFromDate: isFromDate,
              minDate: minDate,
              onDateSelected: (date) {
                Navigator.of(context).pop(date);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerCubit, DatePickerState>(
      builder: (context, state) {
        final cubit = context.read<DatePickerCubit>();

        return Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 8.0),
                  child: Row(
                    children: [
                      if (!isFromDate) ...[
                        // Only show No Date option when isFromDate is false
                        Expanded(
                          child: CustomButton(
                            text: StringUtil.noDate,
                            onPressed: () => cubit.clearDate(),
                            isSelected: state.selectedDate == null,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: CustomButton(
                          text: StringUtil.today,
                          onPressed: () => cubit.selectToday(),
                          isSelected: state.selectedDate != null &&
                              cubit.isToday(state.selectedDate!),
                          // Disable if today is before minDate
                          isEnabled: minDate == null ||
                              !cubit.isDateBefore(DateTime.now(), minDate!),
                        ),
                      ),
                      if (isFromDate) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: StringUtil.nextMonday,
                            onPressed: () => cubit.selectNextMonday(),
                            isSelected: state.selectedDate != null &&
                                cubit.isNextMonday(state.selectedDate!),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                if (isFromDate) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: StringUtil.nextTuesday,
                            onPressed: () => cubit.selectNextTuesday(),
                            isSelected: state.selectedDate != null &&
                                cubit.isNextTuesday(state.selectedDate!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: StringUtil.afterOneWeek,
                            onPressed: () => cubit.selectNextWeek(),
                            isSelected: state.selectedDate != null &&
                                cubit.isNextWeek(state.selectedDate!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // Month navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => cubit.previousMonth(),
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(state.displayedMonth),
                      style: AppTextStyles.dividerTitle(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => cubit.nextMonth(),
                    ),
                  ],
                ),

                // Weekday headers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: StringUtil.weekdays
                        .map((day) => SizedBox(
                      width: 30,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cardSubtitle(context).copyWith(
                          color: day == StringUtil.sunday || day == StringUtil.saturday
                              ? AppColors.lightText
                              : AppColors.text,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: cubit.getDaysInMonthGrid().length,
                    itemBuilder: (context, index) {
                      final day = cubit.getDaysInMonthGrid()[index];

                      if (day == 0) {
                        return const SizedBox.shrink();
                      }

                      final date = DateTime(state.displayedMonth.year, state.displayedMonth.month, day);
                      final isToday = cubit.isDateEqual(date, DateTime.now());
                      final isSelected = state.selectedDate != null &&
                          cubit.isDateEqual(date, state.selectedDate!);

                      final isDisabled = minDate != null && cubit.isDateBefore(date, minDate!);

                      return GestureDetector(
                        onTap: isDisabled ? null : () => cubit.selectDate(date),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$day',
                              style: AppTextStyles.cardSubtitle(context).copyWith(
                                color: isDisabled
                                    ? AppColors.lightText
                                    : isSelected
                                    ? Colors.white
                                    : isToday
                                    ? AppColors.primary
                                    : AppColors.text,
                                fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.primary),
                      const SizedBox(width: 8),
                      state.selectedDate != null
                          ? Text(
                        DateFormat('d MMM yyyy').format(state.selectedDate!),
                        style: AppTextStyles.cardEmployeeName(context),
                      )
                          : Text(
                        StringUtil.noDate,
                        style: AppTextStyles.cardEmployeeName(context),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: StringUtil.cancel,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        isSelected: false,
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        text: StringUtil.save,
                        onPressed: () {
                          onDateSelected(state.selectedDate);
                        },
                        isSelected: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}