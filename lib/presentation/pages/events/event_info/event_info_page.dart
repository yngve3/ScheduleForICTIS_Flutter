import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_for_ictis_flutter/presentation/extensions/context_ext.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/app_bar.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/date_text.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/property/properties/reminder_property.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/property/properties/text_property.dart';
import 'package:schedule_for_ictis_flutter/presentation/widgets/screen.dart';

import '../../../../gen/assets.gen.dart';
import '../../../route/routes.dart';
import '../../../widgets/property/tiles/text_tile.dart';
import 'cubit/event_info_cubit.dart';
import 'cubit/event_info_state.dart';

class EventInfoPage extends StatelessWidget {
  const EventInfoPage({
    super.key,
    required this.eventID
  });
  
  final int? eventID;

  @override
  Widget build(BuildContext context) {
    final iconColor = context.colorScheme.onSurface;
    return BlocProvider(
      create: (context) => EventInfoCubit()..loadEvent(eventID),
      child: BlocBuilder<EventInfoCubit, EventInfoState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<EventInfoCubit>(context);
          return Scaffold(
              appBar: MyAppBar(
                title: "Мероприятие",
                appBar: AppBar(),
                actions: [
                  IconButton(
                    onPressed: () {
                      cubit.deleteEvent();
                      context.pop();
                    },
                    icon: Assets.icons.icDelete.image(
                      height: 30,
                      width: 30
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                        context.push(Routes.addEvent.path, extra: {"eventID": eventID});
                      },
                      icon: Assets.icons.icEdit.image(
                        height: 30,
                        width: 30
                      )
                  )
                ],
              ),
              body: ScrollableScreen(
                scrollable: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextProperty(
                      children: [
                        TextTile(
                          text: state.title,
                          style: context.textTheme.titleLarge,
                        )
                      ],
                    ),
                    TextProperty(
                      icon: Assets.icons.icTime.image(color: iconColor),
                      children: [
                        TextTile(
                          text: "${state.timeStart?.format(context)}-${state.timeEnd?.format(context)}",
                          style: context.textTheme.titleLarge,
                        )
                      ],
                    ),
                    TextProperty(
                      icon: Assets.icons.icEvent.image(color: iconColor),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DateText(
                            date: state.date,
                            style: context.textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                    _getWidgetOrEmpty(
                      property: state.description,
                      icon: Assets.icons.icList.image(color: iconColor),
                      context: context
                    ),
                    _getWidgetOrEmpty(
                      property: state.location,
                      icon: Assets.icons.icLocation.image(color: iconColor),
                      context: context
                    ),
                    state.reminders?.isNotEmpty ?? [].isNotEmpty ? RemindersProperty(
                      reminders: state.reminders ?? [],
                      readOnly: true,
                    ) : const SizedBox.shrink()
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  Widget _getWidgetOrEmpty(
      {String? property, Widget? icon, required BuildContext context}) {
    if (property == null) return const SizedBox.shrink();

    return TextProperty(
      icon: icon,
      children: [
        TextTile(
          text: property,
          style: context.textTheme.titleLarge,
        )
      ],
    );
  }
}

