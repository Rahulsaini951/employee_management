import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'custom_date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  final DateTime? minDate; // Add minDate field

  DatePickerCubit({
    DateTime? initialDate,
    this.minDate, // Add minDate parameter
  }) : super(DatePickerState(
    selectedDate: initialDate,
    displayedMonth: DateTime(
      initialDate?.year ?? DateTime.now().year,
      initialDate?.month ?? DateTime.now().month,
    ),
  ));

  void selectDate(DateTime? date) {
    // Don't select dates before minDate
    if (minDate != null && date != null && isDateBefore(date, minDate!)) {
      return;
    }
    emit(state.copyWith(selectedDate: date));
  }

  void clearDate() {
    emit(state.clearSelectedDate());
  }

  void selectToday() {
    final today = DateTime.now();
    // Don't select today if it's before minDate
    if (minDate != null && isDateBefore(today, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: today,
      displayedMonth: DateTime(today.year, today.month),
    ));
  }

  void selectNextMonday() {
    final nextMonday = _getNextWeekday(DateTime.monday);
    // Don't select if it's before minDate
    if (minDate != null && isDateBefore(nextMonday, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: nextMonday,
      displayedMonth: DateTime(nextMonday.year, nextMonday.month),
    ));
  }

  void selectNextTuesday() {
    final nextTuesday = _getNextWeekday(DateTime.tuesday);
    // Don't select if it's before minDate
    if (minDate != null && isDateBefore(nextTuesday, minDate!)) {
      return;
    }
    emit(state.copyWith(
      selectedDate: nextTuesday,
      displayedMonth: DateTime(nextTuesday.year, nextTuesday.month),
    ));
  }

  void selectNextWeek() {
    final nextWeek = DateTime.now().add(const Duration(days: 7));
    // Don't select if it's before minDate
    if (minDate != null && isDateBefore(nextWeek, minDate!)) {
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

  DateTime _getNextWeekday(int weekday) {
    final now = DateTime.now();
    final daysUntilWeekday = weekday - now.weekday;
    return now.add(Duration(days: daysUntilWeekday > 0 ? daysUntilWeekday : daysUntilWeekday + 7));
  }

  bool isDateEqual(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Add method to check if a date is before another date
  bool isDateBefore(DateTime a, DateTime b) {
    return DateTime(a.year, a.month, a.day).isBefore(DateTime(b.year, b.month, b.day));
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return isDateEqual(date, now);
  }

  bool isNextMonday(DateTime date) {
    final nextMonday = _getNextWeekday(DateTime.monday);
    return isDateEqual(date, nextMonday);
  }

  bool isNextTuesday(DateTime date) {
    final nextTuesday = _getNextWeekday(DateTime.tuesday);
    return isDateEqual(date, nextTuesday);
  }

  bool isNextWeek(DateTime date) {
    final nextWeek = DateTime.now().add(const Duration(days: 7));
    return isDateEqual(date, nextWeek);
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