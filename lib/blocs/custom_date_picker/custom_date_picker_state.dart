part of 'custom_date_picker_cubit.dart';

class DatePickerState extends Equatable {
  final DateTime? selectedDate;
  final DateTime displayedMonth;

  const DatePickerState({
    this.selectedDate,
    required this.displayedMonth,
  });

  DatePickerState copyWith({
    DateTime? selectedDate,
    DateTime? displayedMonth,
  }) {
    return DatePickerState(
      selectedDate: selectedDate ?? this.selectedDate,
      displayedMonth: displayedMonth ?? this.displayedMonth,
    );
  }

  DatePickerState clearSelectedDate() {
    return DatePickerState(
      selectedDate: null,
      displayedMonth: displayedMonth,
    );
  }

  @override
  List<Object?> get props => [selectedDate, displayedMonth];
}


