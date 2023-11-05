import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_notes/model/note_list.dart';

class NotesProvider extends ChangeNotifier {
  List<NotesList> _notesList = [];

  List<NotesList> get notesList => _notesList;

  void addNotes(NotesList note) {
    _notesList.add(note);
    saveNotes();
    notifyListeners();
  }

  void deleteNotes(NotesList note) {
    _notesList.remove(note);
    saveNotes();
    notifyListeners();
  }

  void editNotes(NotesList oldNote, NotesList newNote) {
    int index = _notesList.indexOf(oldNote);
    if (index != -1) {
      _notesList[index] = newNote;
    }
    saveNotes();
    notifyListeners();
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesStringList =
        _notesList.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList('noteList', notesStringList);
    notifyListeners();
  }

  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesStringList = prefs.getStringList('noteList');
    if (notesStringList != null) {
      _notesList = notesStringList
          .map((e) => NotesList.fromjson(jsonDecode(e)))
          .toList();

      // Sort the _notesList based on id
      _notesList.sort((a, b) => a.id.compareTo(b.id));

      notifyListeners();
    }
  }
}
