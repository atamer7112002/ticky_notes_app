import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:tick_notes_app/cubits/notes_cubit/notes_states.dart';
import 'package:tick_notes_app/widgets/note_card.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'No notes yet.\nTap + to add one!',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return NoteCard(
                  color: Color(note.color),
                  title: note.title,
                  content: note.content,
                  date: note.date,
                  onDelete: () {
                    context.read<NotesCubit>().deleteNote(index);
                  },
                );
              },
            );
          } else {
            // NotesInitial or any unexpected state.
            return const Center(
              child: Text('Loading notes...'),
            );
          }
        },
      ),
    );
  }
}
