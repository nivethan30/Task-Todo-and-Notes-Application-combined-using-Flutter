import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:todo_notes/model/note_list.dart';
import 'package:todo_notes/providers/note_provider.dart';
import 'package:todo_notes/screens/notes/add_notes.dart';
import 'package:todo_notes/screens/notes/edit_notes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final NotesProvider notesProvider = NotesProvider();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await Provider.of<NotesProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: provider.notesList.length,
            itemBuilder: (context, index) {
              var sorted = provider.notesList.reversed.toList();
              var note = sorted[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditNotes(notes: note),
                    ),
                  );
                },
                onLongPress: () {
                  _showBottomSheet(context, note);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.grey.shade700,
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey.shade700,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            note.content,
                            maxLines: 5,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddNotes()));
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, NotesList note) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.red,
                leading: const Icon(Icons.delete, color: Colors.white),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  context.read<NotesProvider>().deleteNotes(note);
                },
              ),
            ),
            // Add more ListTiles for other actions as needed
          ],
        );
      },
    );
  }
}
