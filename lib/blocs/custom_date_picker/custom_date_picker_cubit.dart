import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_track/utils/date_util.dart';
part 'custom_date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  final DateTime? minDate;

  DatePickerCubit({
    DateTime? initialDate,
    this.minDate,
  }) : super(DatePickerState(
    selectedDate: initialDate,
    displayedMonth: DateTime(
      initialDate?.year ?? DateTime.now().year,
      initialDate?.month ?? DateTime.now().month,
    ),
  ));

  void selectDate(DateTime? date) {
    // Don't select dates before minDate
    if (minDate != null && date != null && DateUtil.isDateBefore(date, minDate!)) {
      return;
    }
    emit(state.copyWith(selectedDate: date));
  }

  void clearDate() {
    emit(state.clearSelectedDate());
  }

  void selectToday() {
    final today = DateUtil.today();
    // Don't select today if it's before minDate
    if (minDate != null && DateUtil.isDateBefore(today, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: today,
      displayedMonth: DateTime(today.year, today.month),
    ));
  }

  void selectNextMonday() {
    final nextMonday = DateUtil.getNextWeekday(DateTime.monday);
    // Don't select if it's before minDate
    if (minDate != null && DateUtil.isDateBefore(nextMonday, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: nextMonday,
      displayedMonth: DateTime(nextMonday.year, nextMonday.month),
    ));
  }

  void selectNextTuesday() {
    final nextTuesday = DateUtil.getNextWeekday(DateTime.tuesday);
    // Don't select if it's before minDate
    if (minDate != null && DateUtil.isDateBefore(nextTuesday, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: nextTuesday,
      displayedMonth: DateTime(nextTuesday.year, nextTuesday.month),
    ));
  }

  void selectNextWeek() {
    final nextWeek = DateUtil.nextWeek();
    // Don't select if it's before minDate
    if (minDate != null && DateUtil.isDateBefore(nextWeek, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: nextWeek,
      displayedMonth: DateTime(nextWeek.year, nextWeek.month),
    ));
  }

  void previousMonth() {
    final previousMonth = DateTime(
      state.displayedMonth.year,
      state.displayedMonth.month - 1,
    );
    emit(state.copyWith(displayedMonth: previousMonth));
  }

  void nextMonth() {
    final nextMonth = DateTime(
      state.displayedMonth.year,
      state.displayedMonth.month + 1,
    );
    emit(state.copyWith(displayedMonth: nextMonth));
  }

  bool isDateEqual(DateTime a, DateTime b) {
    return DateUtil.isDateEqual(a, b);
  }

  bool isDateBefore(DateTime a, DateTime b) {
    return DateUtil.isDateBefore(a, b);
  }

  bool isToday(DateTime date) {
    return DateUtil.isDateEqual(date, DateTime.now());
  }

  bool isNextMonday(DateTime date) {
    final nextMonday = DateUtil.getNextWeekday(DateTime.monday);
    return DateUtil.isDateEqual(date, nextMonday);
  }

  bool isNextTuesday(DateTime date) {
    final nextTuesday = DateUtil.getNextWeekday(DateTime.tuesday);
    return DateUtil.isDateEqual(date, nextTuesday);
  }

  bool isNextWeek(DateTime date) {
    final nextWeek = DateUtil.nextWeek();
    return DateUtil.isDateEqual(date, nextWeek);
  }

  List<int> getDaysInMonthGrid() {
    final daysInMonth = DateTime(state.displayedMonth.year, state.displayedMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(state.displayedMonth.year, state.displayedMonth.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7; // Convert to 0-indexed where 0 is Sunday

    final result = List<int>.filled(42, 0); // 6 rows × 7 columns

    for (int i = 0; i < daysInMonth; i++) {
      result[firstWeekdayOfMonth + i] = i + 1;
    }

    return result;
  }
}