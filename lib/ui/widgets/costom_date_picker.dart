import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talent_track/blocs/custom_date_picker/custom_date_picker_cubit.dart';
import 'package:talent_track/ui/common/app_colors.dart';
import 'package:talent_track/ui/common/app_theme.dart';
import 'package:talent_track/ui/widgets/custom_app_button.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime?) onDateSelected;
  final bool isFromDate;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    required this.onDateSelected,
    required this.isFromDate,
  });

  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    required bool isFromDate,
  }) async {
    return await showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: BlocProvider(
            create: (_) => DatePickerCubit(initialDate: initialDate),
            child: CustomDatePicker(
              initialDate: initialDate,
              isFromDate: isFromDate,
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
                            text: 'No date',
                            onPressed: () => cubit.clearDate(),
                            isSelected: state.selectedDate == null,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: CustomButton(
                          text: 'Today',
                          onPressed: () => cubit.selectToday(),
                          isSelected: state.selectedDate != null &&
                              cubit.isToday(state.selectedDate!),
                        ),
                      ),
                      if (isFromDate) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: 'Next Monday',
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
                            text: 'Next Tuesday',
                            onPressed: () => cubit.selectNextTuesday(),
                            isSelected: state.selectedDate != null &&
                                cubit.isNextTuesday(state.selectedDate!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: 'After 1 week',
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
                    children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                        .map((day) => SizedBox(
                      width: 30,
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.cardSubtitle(context).copyWith(
                          color: day == 'Sun' || day == 'Sat'
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

                      return GestureDetector(
                        onTap: () => cubit.selectDate(date),
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
                                color: isSelected
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

                // Date selection and buttons
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
                        'No date',
                        style: AppTextStyles.cardEmployeeName(context),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        isSelected: false,
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        text: 'Save',
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
