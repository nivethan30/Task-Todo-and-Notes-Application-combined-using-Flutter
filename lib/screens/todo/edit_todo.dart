import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_notes/model/todo_list.dart';
import 'package:todo_notes/providers/todo_provider.dart';

class EditTodoBottomSheet {
  final TextEditingController _textEditingController = TextEditingController();

  void show(BuildContext context, TodoProvider todoProvider, TodoList todo) {
    _textEditingController.text = todo.content;

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 5,
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
                    const Text('Edit Task Details',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _textEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Tap to Create Task',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            String editedTodoTitle =
                                _textEditingController.text;
                            if (editedTodoTitle.isNotEmpty) {
                              TodoList editedTodo = TodoList(
                                id: todo.id,
                                content: editedTodoTitle,
                              );
                              Provider.of<TodoProvider>(context, listen: false)
                                  .editTodo(todo, editedTodo);
                            }
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

// Example usage:
// In your widget's build method or wherever you need to show the bottom sheet:
// EditTodoBottomSheet().show(context, todoProvider, todo);
