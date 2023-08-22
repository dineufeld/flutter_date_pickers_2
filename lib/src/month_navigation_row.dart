import 'package:flutter/material.dart';
import 'day_picker.dart' as day_picker;
import 'icon_btn.dart';
import 'range_picker.dart';
import 'semantic_sorting.dart';
import 'week_picker.dart';

/// Month navigation widget for day based date pickers like
/// [day_picker.DayPicker],
/// [WeekPicker],
/// [RangePicker].
///
/// It is row with [monthTitle] of showing month in the center and icons to selects
/// previous and next month around it.
class MonthNavigationRow extends StatelessWidget {
  /// Key for previous page icon.
  ///
  /// Can be useful in integration tests to find icon.
  final Key? previousPageIconKey;

  /// Key for next page icon.
  ///
  /// Can be useful in integration tests to find icon.
  final Key? nextPageIconKey;

  /// Function called when [nextIcon] is tapped.
  final VoidCallback? onNextMonthTapped;

  /// Function called when [prevIcon] is tapped.
  final VoidCallback? onPreviousMonthTapped;

  /// Function called when [nextIcon] is tapped.
  final VoidCallback? onNextYearTapped;

  /// Function called when [prevIcon] is tapped.
  final VoidCallback? onPreviousYearTapped;

  /// Tooltip for the [nextIcon].
  final String? nextMonthTooltip;

  /// Tooltip for the [prevIcon].
  final String? previousMonthTooltip;

  /// Widget to use at the end of this row (after title).
  final Widget nextIcon;

  /// Widget to use at the beginning of this row (before title).
  final Widget prevIcon;

  /// Usually [Text] widget.
  final Widget? monthTitle;

  /// Usually [Text] widget.
  final Widget? yearTitle;

  /// Perdiod BoxDecoration
  final BoxDecoration? displayedPeriodDecoration;

  /// Creates month navigation row.
  const MonthNavigationRow({
    Key? key,
    this.previousPageIconKey,
    this.nextPageIconKey,
    this.onNextMonthTapped,
    this.onPreviousMonthTapped,
    this.onNextYearTapped,
    this.onPreviousYearTapped,
    this.nextMonthTooltip,
    this.previousMonthTooltip,
    this.monthTitle,
    this.yearTitle,
    this.displayedPeriodDecoration,
    required this.nextIcon,
    required this.prevIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
            child: Container(
              decoration: displayedPeriodDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Semantics(
                    sortKey: MonthPickerSortKey.previousMonth,
                    child: IconBtn(
                      key: previousPageIconKey,
                      icon: prevIcon,
                      tooltip: previousMonthTooltip,
                      onTap: onPreviousMonthTapped,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: ExcludeSemantics(
                          child: monthTitle,
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    sortKey: MonthPickerSortKey.nextMonth,
                    child: IconBtn(
                      key: nextPageIconKey,
                      icon: nextIcon,
                      tooltip: nextMonthTooltip,
                      onTap: onNextMonthTapped,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 14.0),
          Flexible(
            child: Container(
              decoration: displayedPeriodDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Semantics(
                    sortKey: MonthPickerSortKey.previousMonth,
                    child: IconBtn(
                      key: previousPageIconKey,
                      icon: prevIcon,
                      tooltip: previousMonthTooltip,
                      onTap: onPreviousYearTapped,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: ExcludeSemantics(
                          child: yearTitle,
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    sortKey: MonthPickerSortKey.nextMonth,
                    child: IconBtn(
                      key: nextPageIconKey,
                      icon: nextIcon,
                      tooltip: nextMonthTooltip,
                      onTap: onNextYearTapped,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
