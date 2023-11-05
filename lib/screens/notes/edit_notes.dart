import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_notes/model/note_list.dart';
import 'package:todo_notes/providers/note_provider.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, required this.notes});

  final NotesList notes;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  NotesProvider notesProvider = NotesProvider();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    titleController.text = widget.notes.title;
    contentController.text = widget.notes.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Note"),
        actions: [
          IconButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  NotesList newNote = NotesList(
                      id: DateTime.now().toString(),
                      title: title,
                      content: content);
                  context
                      .read<NotesProvider>()
                      .editNotes(widget.notes, newNote);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
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
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: contentController,
                    minLines: 5,
                    maxLines: 20,
                    style: const TextStyle(
                        color: Colors.white, letterSpacing: 0.9),
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
