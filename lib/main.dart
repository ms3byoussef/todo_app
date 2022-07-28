import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/cubit.dart';
import 'ui/pages/board_screen/board_screen.dart';
import 'ui/theme.dart';
import 'utils/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
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
