// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../range_picker.dart';
import '../week_picker.dart';

/// 0 points to Sunday, and 6 points to Saturday.
typedef DayHeaderStyleBuilder = DayHeaderStyle? Function(int dayOfTheWeek);

/// 0 points to Sunday, and 6 points to Saturday.
typedef DayHeaderTitleBuilder = String Function(
    int dayOfTheWeek, List<String> localizedWeekdayHeaders);

/// Common styles for date pickers.
///
/// To define more styles for date pickers which allow select some range
/// (e.g. [RangePicker], [WeekPicker]) use [DatePickerRangeStyles].
@immutable
class DatePickerStyles {
  /// Styles for title of displayed period
  /// (e.g. month for day picker and year for month picker).
  final TextStyle? displayedPeriodTitle;

  /// Decoration for title of displayed period
  /// (e.g. month for day picker and year for month picker).
  final BoxDecoration? displayedPeriodDecoration;

  /// Style for the number of current date.
  final TextStyle? currentDateStyle;

  /// Style for the numbers of disabled dates.
  final TextStyle? disabledDateStyle;

  /// Style for the number of selected date.
  final TextStyle? selectedDateStyle;

  /// Used for date which is neither current nor disabled nor selected.
  final TextStyle? defaultDateTextStyle;

  /// Day cell decoration for selected date in case only one date is selected.
  final BoxDecoration? selectedSingleDateDecoration;

  /// Style for the day header.
  ///
  /// If you need to customize day header's style depends on day of the week
  /// use [dayHeaderStyleBuilder] instead.
  final DayHeaderStyle? dayHeaderStyle;

  /// Builder to customize styles for day headers depends on day of the week.
  /// Where 0 points to Sunday and 6 points to Saturday.
  ///
  /// Builder must return not null value for every weekday from 0 to 6.
  ///
  /// If styles should be the same for any day of the week
  /// use [dayHeaderStyle] instead.
  final DayHeaderStyleBuilder? dayHeaderStyleBuilder;

  /// Builder to customize titles for day headers depends on day of the week.
  /// Where 0 points to Sunday and 6 points to Saturday.
  final DayHeaderTitleBuilder? dayHeaderTitleBuilder;

  /// Widget which will be shown left side of the shown page title.
  /// User goes to previous data period by click on it.
  final Widget prevIcon;

  /// Widget which will be shown right side of the shown page title.
  /// User goes to next data period by click on it.
  final Widget nextIcon;

  /// Index of the first day of week, where 0 points to Sunday, and 6 points to
  /// Saturday. Must not be less 0 or more then 6.
  ///
  /// Can be null. In this case value from current locale will be used.
  final int? firstDayOfeWeekIndex;

  final TextStyle? previousMonthDayStyle;
  final TextStyle? nextMonthDayStyle;

  /// Styles for date picker.
  DatePickerStyles({
    this.previousMonthDayStyle,
    this.nextMonthDayStyle,
    this.displayedPeriodTitle,
    this.displayedPeriodDecoration,
    this.currentDateStyle,
    this.disabledDateStyle,
    this.selectedDateStyle,
    this.selectedSingleDateDecoration,
    this.defaultDateTextStyle,
    this.dayHeaderStyle,
    this.dayHeaderStyleBuilder,
    this.dayHeaderTitleBuilder,
    this.firstDayOfeWeekIndex,
    this.prevIcon = const Icon(Icons.chevron_left),
    this.nextIcon = const Icon(Icons.chevron_right),
  })  : assert(!(dayHeaderStyle != null && dayHeaderStyleBuilder != null),
            "Should be only one from: dayHeaderStyleBuilder, dayHeaderStyle."),
        assert(
            dayHeaderStyleBuilder == null ||
                _validateDayHeaderStyleBuilder(dayHeaderStyleBuilder),
            "dayHeaderStyleBuilder must return not null value "
            "from every weekday "
            "(from 0 to 6)."),
        assert(
            _validateFirstDayOfWeek(firstDayOfeWeekIndex),
            "firstDayOfeWeekIndex must be null or in correct "
            "range (from 0 to 6).");

  /// Return new [DatePickerStyles] object where fields
  /// with null values set with defaults from theme.
  DatePickerStyles fulfillWithTheme(ThemeData theme) {
    Color accentColor = theme.colorScheme.secondary;

    TextStyle? _displayedPeriodTitle =
        displayedPeriodTitle ?? theme.textTheme.titleMedium;
    TextStyle? _currentDateStyle = currentDateStyle ??
        theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.secondary);
    TextStyle? _disabledDateStyle = disabledDateStyle ??
        theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor);
    TextStyle? _selectedDateStyle = selectedDateStyle ??
        theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSecondary,
        );

    TextStyle? _defaultDateTextStyle =
        defaultDateTextStyle ?? theme.textTheme.bodyMedium;

    TextStyle? _defaultPreviousMonthDayStyle =
        previousMonthDayStyle ?? theme.textTheme.bodyMedium;

    TextStyle? _defaultNextMonthDayStyle =
        nextMonthDayStyle ?? theme.textTheme.bodyMedium;

    BoxDecoration _selectedSingleDateDecoration =
        selectedSingleDateDecoration ??
            BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)));

    DayHeaderStyle? _dayHeaderStyle = dayHeaderStyle;
    if (dayHeaderStyleBuilder == null && _dayHeaderStyle == null) {
      _dayHeaderStyle = DayHeaderStyle(textStyle: theme.textTheme.bodySmall);
    }

    BoxDecoration _defaultDisplayedPeriodDecoration =
        displayedPeriodDecoration ??
            BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(4.0),
            );

    return DatePickerStyles(
      previousMonthDayStyle: _defaultPreviousMonthDayStyle,
      nextMonthDayStyle: _defaultNextMonthDayStyle,
      disabledDateStyle: _disabledDateStyle,
      currentDateStyle: _currentDateStyle,
      displayedPeriodTitle: _displayedPeriodTitle,
      displayedPeriodDecoration: _defaultDisplayedPeriodDecoration,
      selectedDateStyle: _selectedDateStyle,
      selectedSingleDateDecoration: _selectedSingleDateDecoration,
      defaultDateTextStyle: _defaultDateTextStyle,
      dayHeaderStyle: _dayHeaderStyle,
      dayHeaderStyleBuilder: dayHeaderStyleBuilder,
      dayHeaderTitleBuilder: dayHeaderTitleBuilder,
      nextIcon: nextIcon,
      prevIcon: prevIcon,
    );
  }

  static bool _validateDayHeaderStyleBuilder(DayHeaderStyleBuilder builder) {
    List<int> weekdays = const [0, 1, 2, 3, 4, 5, 6];

    // ignore: avoid_types_on_closure_parameters
    bool valid = weekdays.every((int weekday) => builder(weekday) != null);

    return valid;
  }

  static bool _validateFirstDayOfWeek(int? index) {
    if (index == null) return true;

    bool valid = index >= 0 && index <= 6;

    return valid;
  }

  @override
  bool operator ==(covariant DatePickerStyles other) {
    if (identical(this, other)) return true;

    return other.displayedPeriodTitle == displayedPeriodTitle &&
        other.displayedPeriodDecoration == displayedPeriodDecoration &&
        other.currentDateStyle == currentDateStyle &&
        other.disabledDateStyle == disabledDateStyle &&
        other.selectedDateStyle == selectedDateStyle &&
        other.defaultDateTextStyle == defaultDateTextStyle &&
        other.selectedSingleDateDecoration == selectedSingleDateDecoration &&
        other.dayHeaderStyle == dayHeaderStyle &&
        other.dayHeaderStyleBuilder == dayHeaderStyleBuilder &&
        other.dayHeaderTitleBuilder == dayHeaderTitleBuilder &&
        other.prevIcon == prevIcon &&
        other.nextIcon == nextIcon &&
        other.firstDayOfeWeekIndex == firstDayOfeWeekIndex &&
        other.previousMonthDayStyle == previousMonthDayStyle &&
        other.nextMonthDayStyle == nextMonthDayStyle;
  }

  @override
  int get hashCode =>
      displayedPeriodTitle.hashCode ^
      displayedPeriodDecoration.hashCode ^
      currentDateStyle.hashCode ^
      disabledDateStyle.hashCode ^
      selectedDateStyle.hashCode ^
      defaultDateTextStyle.hashCode ^
      selectedSingleDateDecoration.hashCode ^
      dayHeaderStyle.hashCode ^
      dayHeaderStyleBuilder.hashCode ^
      dayHeaderTitleBuilder.hashCode ^
      prevIcon.hashCode ^
      nextIcon.hashCode ^
      firstDayOfeWeekIndex.hashCode ^
      previousMonthDayStyle.hashCode ^
      nextMonthDayStyle.hashCode;
}

/// Styles for date pickers which allow select some range
/// (e.g. RangePicker, WeekPicker).
@immutable
class DatePickerRangeStyles extends DatePickerStyles {
  /// Decoration for the first date of the selected range.
  final BoxDecoration? selectedPeriodStartDecoration;

  /// Text style for the first date of the selected range.
  ///
  /// If null - default [DatePickerStyles.selectedDateStyle] will be used.
  final TextStyle? selectedPeriodStartTextStyle;

  /// Decoration for the last date of the selected range.
  final BoxDecoration? selectedPeriodLastDecoration;

  /// Text style for the last date of the selected range.
  ///
  /// If null - default [DatePickerStyles.selectedDateStyle] will be used.
  final TextStyle? selectedPeriodEndTextStyle;

  /// Decoration for the date of the selected range
  /// which is not first date and not end date of this range.
  ///
  /// If there is only one date selected
  /// [DatePickerStyles.selectedSingleDateDecoration] will be used.
  final BoxDecoration? selectedPeriodMiddleDecoration;

  /// Text style for the middle date of the selected range.
  ///
  /// If null - default [DatePickerStyles.selectedDateStyle] will be used.
  final TextStyle? selectedPeriodMiddleTextStyle;

  /// Return new [DatePickerRangeStyles] object
  /// where fields with null values set with defaults from given theme.
  @override
  DatePickerRangeStyles fulfillWithTheme(ThemeData theme) {
    Color accentColor = theme.colorScheme.secondary;

    DatePickerStyles commonStyles = super.fulfillWithTheme(theme);

    final BoxDecoration _selectedPeriodStartDecoration =
        selectedPeriodStartDecoration ??
            BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10.0),
                  bottomStart: Radius.circular(10.0)),
            );

    final BoxDecoration _selectedPeriodLastDecoration =
        selectedPeriodLastDecoration ??
            BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  bottomEnd: Radius.circular(10.0)),
            );

    final BoxDecoration _selectedPeriodMiddleDecoration =
        selectedPeriodMiddleDecoration ??
            BoxDecoration(
              color: accentColor,
              shape: BoxShape.rectangle,
            );

    final TextStyle? _selectedPeriodStartTextStyle =
        selectedPeriodStartTextStyle ?? commonStyles.selectedDateStyle;

    final TextStyle? _selectedPeriodMiddleTextStyle =
        selectedPeriodMiddleTextStyle ?? commonStyles.selectedDateStyle;

    final TextStyle? _selectedPeriodEndTextStyle =
        selectedPeriodEndTextStyle ?? commonStyles.selectedDateStyle;

    return DatePickerRangeStyles(
      disabledDateStyle: commonStyles.disabledDateStyle,
      currentDateStyle: commonStyles.currentDateStyle,
      displayedPeriodTitle: commonStyles.displayedPeriodTitle,
      displayedPeriodDecoration: commonStyles.displayedPeriodDecoration,
      selectedDateStyle: commonStyles.selectedDateStyle,
      selectedSingleDateDecoration: commonStyles.selectedSingleDateDecoration,
      defaultDateTextStyle: commonStyles.defaultDateTextStyle,
      dayHeaderStyle: commonStyles.dayHeaderStyle,
      dayHeaderStyleBuilder: commonStyles.dayHeaderStyleBuilder,
      dayHeaderTitleBuilder: commonStyles.dayHeaderTitleBuilder,
      firstDayOfWeekIndex: firstDayOfeWeekIndex,
      selectedPeriodStartDecoration: _selectedPeriodStartDecoration,
      selectedPeriodMiddleDecoration: _selectedPeriodMiddleDecoration,
      selectedPeriodLastDecoration: _selectedPeriodLastDecoration,
      selectedPeriodStartTextStyle: _selectedPeriodStartTextStyle,
      selectedPeriodMiddleTextStyle: _selectedPeriodMiddleTextStyle,
      selectedPeriodEndTextStyle: _selectedPeriodEndTextStyle,
      previousMonthDayStyle: commonStyles.previousMonthDayStyle,
      nextMonthDayStyle: commonStyles.nextMonthDayStyle,
    );
  }

  /// Styles for the pickers that allows to select range ([RangePicker],
  /// [WeekPicker]).
  DatePickerRangeStyles({
    TextStyle? previousMonthDayStyle,
    TextStyle? nextMonthDayStyle,
    TextStyle? displayedPeriodTitle,
    BoxDecoration? displayedPeriodDecoration,
    TextStyle? currentDateStyle,
    TextStyle? disabledDateStyle,
    TextStyle? selectedDateStyle,
    BoxDecoration? selectedSingleDateDecoration,
    TextStyle? defaultDateTextStyle,
    DayHeaderStyle? dayHeaderStyle,
    DayHeaderStyleBuilder? dayHeaderStyleBuilder,
    DayHeaderTitleBuilder? dayHeaderTitleBuilder,
    Widget nextIcon = const Icon(Icons.chevron_right),
    Widget prevIcon = const Icon(Icons.chevron_left),
    int? firstDayOfWeekIndex,
    this.selectedPeriodLastDecoration,
    this.selectedPeriodMiddleDecoration,
    this.selectedPeriodStartDecoration,
    this.selectedPeriodStartTextStyle,
    this.selectedPeriodMiddleTextStyle,
    this.selectedPeriodEndTextStyle,
  }) : super(
          previousMonthDayStyle: previousMonthDayStyle,
          nextMonthDayStyle: nextMonthDayStyle,
          displayedPeriodTitle: displayedPeriodTitle,
          displayedPeriodDecoration: displayedPeriodDecoration,
          currentDateStyle: currentDateStyle,
          disabledDateStyle: disabledDateStyle,
          selectedDateStyle: selectedDateStyle,
          selectedSingleDateDecoration: selectedSingleDateDecoration,
          defaultDateTextStyle: defaultDateTextStyle,
          dayHeaderStyle: dayHeaderStyle,
          dayHeaderStyleBuilder: dayHeaderStyleBuilder,
          dayHeaderTitleBuilder: dayHeaderTitleBuilder,
          nextIcon: nextIcon,
          prevIcon: prevIcon,
          firstDayOfeWeekIndex: firstDayOfWeekIndex,
        );

  @override
  bool operator ==(covariant DatePickerRangeStyles other) {
    if (identical(this, other)) return true;

    return other.selectedPeriodStartDecoration ==
            selectedPeriodStartDecoration &&
        other.selectedPeriodStartTextStyle == selectedPeriodStartTextStyle &&
        other.selectedPeriodLastDecoration == selectedPeriodLastDecoration &&
        other.selectedPeriodEndTextStyle == selectedPeriodEndTextStyle &&
        other.selectedPeriodMiddleDecoration ==
            selectedPeriodMiddleDecoration &&
        other.selectedPeriodMiddleTextStyle == selectedPeriodMiddleTextStyle;
  }

  @override
  int get hashCode =>
      selectedPeriodStartDecoration.hashCode ^
      selectedPeriodStartTextStyle.hashCode ^
      selectedPeriodLastDecoration.hashCode ^
      selectedPeriodEndTextStyle.hashCode ^
      selectedPeriodMiddleDecoration.hashCode ^
      selectedPeriodMiddleTextStyle.hashCode;
}

/// User styles for the day header in date picker.
@immutable
class DayHeaderStyle {
  /// If null - textTheme.caption from the Theme will be used.
  final TextStyle? textStyle;

  /// If null - no decoration will be applied for the day header;
  final BoxDecoration? decoration;

  /// Creates styles for the day headers in date pickers.
  ///
  /// See also:
  /// * [DatePickerStyles.dayHeaderStyleBuilder]
  const DayHeaderStyle({this.textStyle, this.decoration});

  @override
  bool operator ==(covariant DayHeaderStyle other) {
    if (identical(this, other)) return true;

    return other.textStyle == textStyle && other.decoration == decoration;
  }

  @override
  int get hashCode => textStyle.hashCode ^ decoration.hashCode;
}
