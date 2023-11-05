import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_notes/model/note_list.dart';

import '../../providers/note_provider.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          IconButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  NotesList note = NotesList(
                      id: DateTime.now().toString(),
                      title: title,
                      content: content);
                  context.read<NotesProvider>().addNotes(note);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: titleController,
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 0.9),
                    decoration: const InputDecoration(
                      hintText: 'Tap to Enter Title',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: contentController,
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 0.9),
                    minLines: 5,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      hintText: 'Tap and Start Typing',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  ElevatedButton(
//                 onPressed: () {
//                   String title = titleController.text;
//                   String content = contentController.text;
//                   if (title.isNotEmpty && content.isNotEmpty) {
//                     NotesList note = NotesList(
//                         id: DateTime.now().toString(),
//                         title: title,
//                         content: content);
//                     context.read<NotesProvider>().addNotes(note);
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Add Note'))
