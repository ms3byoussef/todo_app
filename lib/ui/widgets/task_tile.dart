// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/business_logic/cubit/states.dart';
import 'package:todo/db/models/task.dart';
import 'package:todo/ui/theme.dart';

import '../../business_logic/cubit/cubit.dart';

class TaskTile extends StatelessWidget {
  TaskTile({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double width = mediaQueryData.size.width;
    // double height = mediaQueryData.size.height;
    Orientation orientation = mediaQueryData.orientation;

    return BlocBuilder<AppCubit, TaskStetes>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          showBottomSheet(context, task);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: orientation == Orientation.landscape ? width / 2 : width,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getColor(task.color),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            task.title!,
                            style: AppTheme.taskCardTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[200],
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text('${task.startTime} - ${task.endTime}',
                                style: AppTheme.taskCardTitle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(task.note!,
                            style: AppTheme.taskCardTitle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: .5,
                  height: 60,
                  color: Colors.grey[200]!.withOpacity(.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    task.isCompleted == 0 ? "To Do" : "Complated",
                    style: AppTheme.taskCardTitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  showBottomSheet(BuildContext context, Task task) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.circular(20)),
        ),
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(top: 4, right: 16, left: 16),
                  height: task.isCompleted == 1
                      ? MediaQuery.of(context).size.height * .4
                      : MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  color: white,
                  child: Column(
                    children: [
                      Flexible(
                          child: Container(
                              height: 6,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white))),
                      const SizedBox(height: 20),
                      task.isCompleted == 1
                          ? Container()
                          : _buildBottomSheet(
                              title: "Task Competed",
                              onTap: () {
                                AppCubit.get(context)
                                    .updateToDatebase(1, task.id);
                                Navigator.pop(context);
                              },
                              color: teal),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildBottomSheet(
                          title: "Delete Task",
                          onTap: () {
                            AppCubit.get(context).deleteFromDatabase(task.id);
                            Navigator.pop(context);
                          },
                          color: Colors.red),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildBottomSheet(
                          title: "Favorite",
                          onTap: () {
                            task.isFavorite == 0
                                ? AppCubit.get(context)
                                    .updateIsFavoriteDatebase(1, task.id)
                                : AppCubit.get(context)
                                    .updateIsFavoriteDatebase(0, task.id);
                            Navigator.pop(context);
                          },
                          color: pinkClr),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildBottomSheet(
                          title: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          color: orangeClr)
                    ],
                  )),
            ));
  }

  _buildBottomSheet(
      {required String title,
      required Function() onTap,
      required Color? color,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : color),
        child: Center(
            child: Text(
          title,
          style: AppTheme.taskCardTitle,
        )),
      ),
    );
  }

  _getColor(int? color) {
    switch (color) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      case 3:
        return teal;
      default:
        return teal;
    }
  }
}
