// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/business_logic/cubit/cubit.dart';
import 'package:todo/business_logic/cubit/states.dart';
import 'package:todo/db/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/utils/validator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _stratTime = DateFormat('hh:mm a').format(DateTime.now());

  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _selectedRemind = 5;

  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = 'None';

  List<String> repeatedList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add Task ",
                        style: AppTheme.headline1,
                      ),
                      InputField(
                        label: "Title",
                        controller: _titleController,
                        hintText: 'Enter title here',
                        keyboardType: TextInputType.text,
                        validator: (value) => Validator.validateEmpty(value!),
                      ),
                      InputField(
                        label: "Note",
                        controller: _noteController,
                        hintText: 'Enter note here',
                        keyboardType: TextInputType.text,
                        validator: (value) => Validator.validateEmpty(value!),
                      ),
                      InputField(
                        label: "date",
                        hintText:
                            DateFormat('dd/MM/yyyy').format(_selectedDate),
                        keyboardType: TextInputType.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month_outlined),
                          onPressed: () {
                            _getDate();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              label: "Strat Time",
                              hintText: _stratTime,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time_rounded),
                                onPressed: () {
                                  _getTime(isStartTime: true);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InputField(
                              label: "End Time",
                              hintText: _endTime,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time_rounded),
                                onPressed: () {
                                  _getTime(isStartTime: false);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      InputField(
                        label: "Remind",
                        hintText: '$_selectedRemind  minutes early ',
                        suffixIcon: DropdownButton(
                            alignment: AlignmentDirectional.center,
                            isDense: true,
                            elevation: 4,
                            underline: const SizedBox(height: 0),
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: Colors.blueGrey,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 35,
                            ),
                            items: remindList
                                .map<DropdownMenuItem<String>>(
                                    (int e) => DropdownMenuItem<String>(
                                          value: e.toString(),
                                          child: Text("$e"),
                                        ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRemind = int.parse(newValue!);
                              });
                            }),
                      ),
                      InputField(
                        label: "Repeat",
                        hintText: _selectedRepeat,
                        suffixIcon: DropdownButton(
                            underline: const SizedBox(height: 0),
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: Colors.blueGrey,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 35,
                            ),
                            items: repeatedList
                                .map<DropdownMenuItem<String>>(
                                    (String e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRepeat = newValue.toString();
                              });
                            }),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          colorPalette(),
                          MyButton(
                              label: ' Create Task',
                              width: 150,
                              onPressed: () async {
                                await addTask();
                              }),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  addTask() async {
    if (_titleController.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Title is empty",
        ),
      );
      return;
    }
    if (_noteController.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Note is empty",
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Task task = Task(
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat('dd/MM/yyyy').format(_selectedDate),
        startTime: _stratTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        isCompleted: 0,
        isFavorite: 1,
      );
      AppCubit.get(context).insertIntoDatabase(task: task);
      Navigator.pop(context);
    } else {
      debugPrint("Not Valid");
    }
  }

  _getDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) setState(() => _selectedDate = pickedDate);
  }

  _getTime({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: 15),
              ),
            ),
    );
    String? forrmatTime = pickedTime!.format(context);
    if (isStartTime) {
      setState(() => _stratTime = forrmatTime);
    } else if (!isStartTime) {
      setState(() => _endTime = forrmatTime);
    } else {
      print("error Time");
    }
  }

  Column colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: AppTheme.labelText,
        ),
        const SizedBox(height: 10),
        Wrap(
            children: List.generate(
          4,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CircleAvatar(
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : index == 2
                            ? orangeClr
                            : teal,
                radius: 14,
                child: _selectedColor == index
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ),
        )),
      ],
    );
  }
}
