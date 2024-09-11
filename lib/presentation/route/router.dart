import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_for_ictis_flutter/domain/models/schedule_subject/schedule_subject.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/home/home_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/notes/all_notes_list/all_notes_list_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/notes/note_add/note_add_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/notes/note_info/note_info_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/search_schedule_screen/search_schedule_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/pages/search_schedule_screen/search_schedule_result_page.dart';
import 'package:schedule_for_ictis_flutter/presentation/route/routes.dart';

import '../pages/events/event_add/event_add_page.dart';
import '../pages/events/event_info/event_info_page.dart';
import '../pages/favorite_schedules/pages/favorite_schedules_add/favorite_schedules_add_page.dart';
import '../pages/favorite_schedules/pages/favorite_schedules_list/favorite_schedules_list_page.dart';
import '../pages/main_page/main_page.dart';
import '../pages/notes/couple_notes_list/couple_notes_list.dart';
import '../pages/preferences/preferences_page.dart';
import '../pages/schedule/schedule_page.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'main_page');

  static final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.home.path,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return MainPage(child: child);
            },
            routes: [
              GoRoute(
                path: Routes.home.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                      child: HomePage()
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.allNotes.lastPathComponent,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (BuildContext context, GoRouterState state) {
                      return const AllNotesListPage();
                    },
                  ),
                  GoRoute(
                    path: Routes.searchSchedule.lastPathComponent,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return CustomTransitionPage(
                        child: const SearchSchedulePage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        path: Routes.searchScheduleResult.lastPathComponent,
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          return SearchScheduleResultPage(
                              scheduleSubject: state.extra as ScheduleSubject
                          );
                        },
                      ),
                    ],
                  )
                ]
              ),
              GoRoute(
                path: Routes.schedule.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                      child: SchedulePage()
                  );
                },
              ),
              GoRoute(
                path: Routes.preferences.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                      child: PreferencesPage()
                  );
                },
              ),
            ],
        ),
        GoRoute(
          path: Routes.favoriteSchedules.path,
          builder: (BuildContext context, GoRouterState state) {
            final data = state.extra as Map<String, dynamic>?;
            return FavoriteSchedulesListPage(
              afterRegistration: data?["afterRegistration"] ?? false
            );
          },
          routes: [
            GoRoute(
              path: Routes.addFavoriteSchedule.lastPathComponent,
              builder: (BuildContext context, GoRouterState state) {
                return const FavoriteSchedulesAddPage();
              },
            ),
          ],
        ),
        GoRoute(
            path: Routes.coupleNotesList.fullPath,
            builder: (BuildContext context, GoRouterState state) {
              return CoupleNotesListPage(
                  coupleID: state.pathParameters["couple_id"] ?? ""
              );
            },
            routes: [
              GoRoute(
                  path: Routes.addNote.twoLastPathComponents,
                  builder: (context, state) => NoteAddPage(
                    coupleID: state.pathParameters["couple_id"] ?? "",
                    noteID: state.extra as int?,
                  )
              ),
              GoRoute(
                  path: Routes.noteInfo.twoLastPathComponents,
                  builder: (context, state) {
                    return NoteInfoPage(
                      coupleID: state.pathParameters["couple_id"] ?? "",
                      noteID: int.parse(state.pathParameters["note_id"] ?? ""),
                    );
                  }
              )
            ]
        ),
        GoRoute(
          path: Routes.addEvent.path,
          builder: (BuildContext context, GoRouterState state) {
            final data = state.extra as Map<String, dynamic>;
            return EventAddPage(
              eventID: data["eventID"],
              initialDate: data["initialDate"],
            );
          },
        ),
        GoRoute(
            path: Routes.eventInfo.fullPath,
            builder: (BuildContext context, GoRouterState state) {
              return EventInfoPage(
                  eventID: int.parse(state.pathParameters["event_id"] ?? "")
              );
            },
        ),
      ]
  );
}