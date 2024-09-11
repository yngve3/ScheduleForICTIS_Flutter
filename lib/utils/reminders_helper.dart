import 'package:awesome_notifications/awesome_notifications.dart';

import '../domain/models/reminder/reminder.dart';

class RemindersHelper {
  static const channelKey = "basic_channel";

  static void init() async {
    await AwesomeNotifications().initialize(
      null,
      [NotificationChannel(
        channelKey: channelKey,
        channelName: "Reminders",
        channelDescription: "Channel for reminders"
      )],
    );
    checkNotificationPermissions();
  }

  static void deleteReminders(List<int> ids) {
    for (final id in ids) {
      AwesomeNotifications().cancel(id);
    }
  }

  static void createReminders(
      List<Reminder> reminders,
      DateTime dateTime,
      {String? title, String? body}
  ) {
    for (final reminder in reminders) {
      RemindersHelper.createReminder(
        reminder.id!,
        dateTime.subtract(Duration(minutes: reminder.minutesBefore)),
        title: title,
      );
    }
  }

  static void createReminder(
      int id,
      DateTime dateTime,
      {String? title, String? body}
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        actionType: ActionType.Default,
        title: title,
        body: body,
        wakeUpScreen: false,
        category: NotificationCategory.Reminder,
        criticalAlert: true
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: dateTime.second,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
        allowWhileIdle: true
      )
    );
  }

  static void checkNotificationPermissions() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
}