// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/ui/pages/add_task/add_task_screen.dart';
import 'package:todo/ui/pages/board_screen/tapBar/fav_tasks.dart';
import 'package:todo/ui/pages/schedule_screen/schedule_screen.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';

import '../../../business_logic/cubit/cubit.dart';
import '../../../business_logic/cubit/states.dart';
import 'tapBar/all_tasks.dart';
import 'tapBar/completed_tasks.dart';
import 'tapBar/un_completed_tasks.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, TaskStetes>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Board ",
                        style: AppTheme.headline1,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ScheduleScreen()));
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TabBar(
                    tabs: const [
                      Tab(text: "All"),
                      Tab(text: "Complated"),
                      Tab(text: "UnComplated"),
                      Tab(text: "Favorites"),
                    ],
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .65,
                    width: double.infinity,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        MyList(AppCubit.get(context).allTasks),
                        MyComplateList(AppCubit.get(context).allTasks),
                        MyUnComplateList(AppCubit.get(context).allTasks),
                        MyFavList(AppCubit.get(context).allTasks)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    label: "Add Task",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AddTaskPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
