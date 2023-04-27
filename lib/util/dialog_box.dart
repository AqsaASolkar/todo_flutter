import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 120,
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // get user input
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Task cannot be empty";
                    }
                  }
                  return null;
                },
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                ),
              ),
              // buttons -> save + cancel
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(
                      text: "Save",
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          onSave.call();
                        }
                      }),
                  const SizedBox(width: 8),
                  // cancel button
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
