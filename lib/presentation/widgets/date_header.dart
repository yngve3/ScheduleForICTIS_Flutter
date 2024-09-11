import 'package:flutter/material.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/context_ext.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/date_text.dart';

import '../../gen/assets.gen.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({
    super.key,
    required this.date,
    required this.buttonIsVisible,
    this.onButtonToCurrentDateTapped,
    this.studyWeek
  });

  final DateTime date;
  final int? studyWeek;
  final VoidCallback? onButtonToCurrentDateTapped;
  final bool buttonIsVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      backgroundColor: context.colorScheme.surface,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              DateText(date: date, style: context.textTheme.headlineLarge),
              Text(_getSubtitle(), style: context.textTheme.bodyMedium),
            ],
          ),
          _getButton(context.colorScheme.onSurface)
        ],
      ),
    );
  }

  String _getSubtitle() {
    if (studyWeek != null) {
      return "Учебная неделя №$studyWeek";
    } else {
      return "Учебная группа не выбрана";
    }
  }

  Widget _getButton(Color? color) {
    return buttonIsVisible ? IconButton(
      icon: Assets.icons.icEvent.image(color: color, height: 30, width: 30),
      onPressed: onButtonToCurrentDateTapped,
    ) : const SizedBox.shrink();
  }
}