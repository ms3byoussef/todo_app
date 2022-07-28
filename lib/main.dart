import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/cubit.dart';
import 'ui/pages/board_screen/board_screen.dart';
import 'ui/theme.dart';
import 'utils/bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  await AndroidAlarmManager.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..createDataBase(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        home: const BoardScreen(),
      ),
    );
  }
}
