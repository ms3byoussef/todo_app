// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../business_logic/cubit/cubit.dart';
import '../../../../business_logic/cubit/states.dart';
import '../../../../db/models/task.dart';
import '../../../widgets/no_task_widget.dart';
import '../../../widgets/task_tile.dart';

class MyComplateList extends StatelessWidget {
  MyComplateList(this.myTasks, {Key? key}) : super(key: key);
  List<Task> myTasks;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, TaskStetes>(
      builder: (context, state) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            child: myTasks.isEmpty
                ? const NoTaskMassege()
                : ListView.builder(
                    itemCount: myTasks.length,
                    shrinkWrap: true,
                    itemBuilder: ((BuildContext context, int index) =>
                        myTasks[index].isCompleted == 1
                            ? AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1225),
                                child: SlideAnimation(
                                  horizontalOffset: 300,
                                  child: FadeInAnimation(
                                    child: TaskTile(task: myTasks[index]),
                                  ),
                                ),
                              )
                            : const SizedBox()),
                  ));
      },
    );
  }
}
