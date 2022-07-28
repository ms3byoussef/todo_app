// ignore_for_file: unused_element

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/pages/add_task/add_task_screen.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../../business_logic/cubit/cubit.dart';
import '../../../business_logic/cubit/states.dart';
import '../../widgets/no_task_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

DateTime _selectedValue = DateTime.now();

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, TaskStetes>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.grey,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.dark_mode,
                    color: Colors.grey,
                  ))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('MMMM dd ,yyyy')
                                    .format(DateTime.now())
                                    .toString(),
                                style: AppTheme.darkHeadline.copyWith(
                                  fontFamily: "EduNSWACTFoundation",
                                ),
                              ),
                              Text(
                                "Today",
                                style: AppTheme.darkHeadline,
                              ),
                            ],
                          ),
                          MyButton(
                            label: "+ Add Task",
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddTaskPage(),
                                ),
                              );
                            },
                            width: 120,
                          )
                        ],
                      ),
                    ),
                    DatePicker(
                      DateTime.now(),
                      height: 100,
                      width: 70,
                      dayTextStyle: AppTheme.darkcardText,
                      monthTextStyle: AppTheme.darkcardText.copyWith(
                        fontFamily: "EduNSWACTFoundation",
                      ),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: primaryClr,
                      onDateChange: (date) {
                        setState(() {
                          _selectedValue = date;
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: AppCubit.get(context).allTasks.isEmpty
                          ? const NoTaskMassege()
                          : ListView.builder(
                              itemCount: AppCubit.get(context).allTasks.length,
                              shrinkWrap: true,
                              itemBuilder: ((BuildContext context, int index) {
                                var task =
                                    AppCubit.get(context).allTasks[index];
                                if ((task.repeat == "Daily" ||
                                        task.date ==
                                            DateFormat.yMd()
                                                .format(_selectedValue)) ||
                                    (task.repeat == "Weekly" &&
                                        _selectedValue
                                                    .difference(DateFormat.yMd()
                                                        .parse(task.date!))
                                                    .inDays %
                                                7 ==
                                            0) ||
                                    (task.repeat == "Monthly" &&
                                        DateFormat.yMd()
                                                .parse(task.date!)
                                                .day ==
                                            _selectedValue.day)) {
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 1225),
                                      child: SlideAnimation(
                                          horizontalOffset: 300,
                                          child: FadeInAnimation(
                                              child: TaskTile(task: task))));
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
