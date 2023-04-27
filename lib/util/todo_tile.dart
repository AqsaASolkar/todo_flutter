import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final VoidCallback deleteFunction;
  final Function(bool?)? onChanged;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // checkbox
                SizedBox(
                  height: 20,
                  child: Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                // task name
                Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: deleteFunction,
              icon: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
