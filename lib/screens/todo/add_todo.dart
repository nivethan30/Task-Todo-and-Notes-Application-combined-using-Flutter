import 'package:flutter/material.dart';

class AddTodoBottomSheet {
  void show(BuildContext context, TextEditingController textEditingController,
      Function(String) onAddPressed) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled:
          true, // Ensure the sheet doesn't overlap with the keyboard
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  5, // Adjust based on keyboard height
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade800,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Create New Task',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: textEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Tap to Create Task',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .transparent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            onAddPressed(textEditingController.text);
                            textEditingController.clear();
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text('Done'),
                        ),
                      ],
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
