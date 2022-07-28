import 'package:flutter/material.dart';

import '../theme.dart';

class NoTaskMassege extends StatelessWidget {
  const NoTaskMassege({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  "assets/icons/no_task.png",
                  color: primaryClr.withOpacity(.4),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  "You don't have any task yet !\nAdd new tasks to make your day porductive.",
                  style: AppTheme.darkcardText,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
