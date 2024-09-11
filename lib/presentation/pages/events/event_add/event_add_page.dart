import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/context_ext.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/app_bar.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/property/properties/reminder_property.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/property/properties/date_property.dart';
import '../../../widgets/property/properties/input_property.dart';
import '../../../widgets/property/properties/time_property.dart';
import '../../../widgets/screen.dart';
import 'cubit/event_add_cubit.dart';
import 'cubit/event_add_state.dart';


class EventAddPage extends StatelessWidget {
  const EventAddPage({
    super.key,
    required this.eventID,
    this.initialDate
  });

  final DateTime? initialDate;
  final int? eventID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        title: "Мероприятие",
      ),
      body: BlocProvider(
          create: (context) => EventAddCubit(initialDate)..loadStateFromEvent(eventID),
          child: const EventAdd()
      ),
    );
  }
}

class EventAdd extends StatelessWidget {
  const EventAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = context.colorScheme.onSurface;
    final cubit = BlocProvider.of<EventAddCubit>(context);
    return BlocBuilder<EventAddCubit, EventAddState>(
      builder: (context, state) => ScrollableScreen(
        bottom: FilledButton(
          onPressed:
          state.isSaveButtonEnabled
              ? () {cubit.saveEvent(); context.pop();}
              : null,
          child: const Text("Сохранить"),
        ),
        scrollable: Column(
          children: [
            InputProperty(
                hint: "Название",
                value: state.title,
                onChanged: (value) => cubit.titleChanged(value)),
            InputProperty(
                hint: "Описание",
                value: state.description,
                isMultiLines: true,
                icon: Assets.icons.icList.image(color: iconColor),
                onChanged: (value) => cubit.descriptionChanged(value)),
            TimeProperty(
              timeStart: state.timeStart,
              timeEnd: state.timeEnd,
              onTimeEndChosen: (time) => cubit.timeEndChanged(time),
              onTimeStartChosen: (time) => cubit.timeStartChanged(time),
            ),
            DateProperty(
              date: state.date,
              onDateChosen: (date) => cubit.dateChanged(date),
            ),
            InputProperty(
                hint: "Локация",
                value: state.location,
                icon: Assets.icons.icLocation.image(color: iconColor),
                onChanged: (value) {
                  cubit.locationChanged(value);
                }
            ),
            RemindersProperty(
                reminders: state.reminders?.elements ?? [],
                onDelete: (reminder) => cubit.deleteReminder(reminder),
                onAdd: (reminder) => cubit.addReminder(reminder)
            )
          ],
        ),
      )
    );
  }
}
