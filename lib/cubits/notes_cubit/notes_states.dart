import 'package:tick_notes_app/models/notes_view_model.dart';

/// Base class for all notes states.
///
/// Think of this as: "what is happening with my notes right now?"
abstract class NotesState {}

/// Initial state before anything is loaded.
class NotesInitial extends NotesState {
  NotesInitial();
}

/// Emitted while notes are being loaded from Hive.
class NotesLoading extends NotesState {
  NotesLoading();
}

/// Emitted when notes are successfully loaded.
class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  NotesLoaded(this.notes);
}

/// Emitted when an error happens (e.g. Hive failure).
class NotesError extends NotesState {
  final String message;

  NotesError(this.message);
}
