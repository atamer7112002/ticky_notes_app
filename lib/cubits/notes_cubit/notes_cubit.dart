import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'notes_states.dart';
import 'package:tick_notes_app/models/notes_view_model.dart';

class NotesCubit extends Cubit<NotesState> {
  final Box<NoteModel> _notesBox;

  NotesCubit(this._notesBox) : super(NotesInitial());

  /// Load all notes from Hive and emit [NotesLoaded].
  Future<void> loadNotes() async {
    try {
      emit(NotesLoading());
      final notes = _notesBox.values.toList();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Add a new note, then reload the list.
  Future<void> addNote(NoteModel note) async {
    try {
      await _notesBox.add(note);
      await loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  /// Delete a note by index, then reload the list.
  Future<void> deleteNote(int index) async {
    try {
      await _notesBox.deleteAt(index);
      await loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
