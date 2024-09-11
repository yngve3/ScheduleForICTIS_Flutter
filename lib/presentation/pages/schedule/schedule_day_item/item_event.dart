import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/context_ext.dart';

import '../../../../domain/models/schedule/day_schedule_item.dart';
import '../../../route/routes.dart';
import '../../../widgets/card_with_time_on_left.dart';

class ItemEvent extends StatelessWidget {
  const ItemEvent({
    super.key,
    required this.event,
    this.showIndicator = false,
    this.onIndicatorEnd
  });

  final Event event;
  final bool showIndicator;
  final VoidCallback? onIndicatorEnd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.eventInfo.path({"event_id": event.id})),
      child: CardWithTimeOnLeft(
        indicatorDuration: event.duration,
        indicatorInitPercentage: event.percent,
        onIndicatorEnd: onIndicatorEnd,
        showIndicator: showIndicator,
        indicatorColor: Colors.black,
        timeStart: TimeOfDay.fromDateTime(event.dateTimeStart),
        timeEnd: TimeOfDay.fromDateTime(event.dateTimeEnd),
        color: context.colorScheme.primary,
        timePanelTopPadding: 5,
        dividerColor: Colors.white,
        timeStartTextStyle: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
        timeEndTextStyle: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onPrimary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary)),
            const SizedBox(height: 5),
            Text(event.location ?? "", style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary))
          ],
        ),
      ),
    );
  }
}
