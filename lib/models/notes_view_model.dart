import 'package:hive/hive.dart';
part 'notes_view_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final int color;
  @HiveField(3)
  final String date;

  NoteModel(this.title, this.content, this.color, this.date);
}
