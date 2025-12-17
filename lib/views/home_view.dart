import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tick_notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:tick_notes_app/models/notes_view_model.dart';
import 'package:tick_notes_app/widgets/notes_builder.dart';
import 'package:tick_notes_app/widgets/add_note_bottom_sheet.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = 'home_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final box = Hive.box<NoteModel>('notes');
        final cubit = NotesCubit(box);
        cubit.loadNotes(); // load notes once when HomeView is built
        return cubit;
      },
      child: Builder(
        // This Builder gives us a new BuildContext that is *under* BlocProvider
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF020617)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Tick Notes',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Capture your ideas in seconds',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF22C1C3), Color(0xFFFDBB2D)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.note_alt_outlined,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF020617),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: const NotesBuilder(),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  final notesCubit = context.read<NotesCubit>();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (sheetContext) => BlocProvider.value(
                      value: notesCubit,
                      child: const SafeArea(child: AddNoteBottomSheet()),
                    ),
                  );
                },
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
