class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;
  int? color;
  int? isFavorite;
  int? isCompleted;
  Task(
      {this.id,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat,
      this.isCompleted,
      this.isFavorite});

  Task.fromJson(Map<dynamic, dynamic> map)
      : id = map['id'] as int,
        title = map['title'] ?? "",
        note = map['note'] ?? "",
        date = map['date'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        color = map['color'],
        remind = map['remind'],
        repeat = map['repeat'],
        isCompleted = map['isCompleted'],
        isFavorite = map['isFavorite'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'date': date,
        'startTime': endTime,
        'color': color,
        'remind': remind,
        'repeat': repeat,
        'isCompleted': isCompleted,
        'isFavorite': isFavorite,
      };

  Task copyWith({
    int? id,
    String? title,
    String? note,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    int? remind,
    String? repeat,
    int? isFavorite,
    int? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
      repeat: repeat ?? this.repeat,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

const String tableTasks = "tasks";

class TaskFields {
  static final List<String> values = [
    id,
    title,
    note,
    date,
    startTime,
    endTime,
    color,
    remind,
    repeat,
    isFavorite,
    isCompleted,
  ];
  static const String id = "_id";
  static const String title = "title";
  static const String note = "note";
  static const String date = "date";
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String color = "color";
  static const String remind = "remind";
  static const String repeat = "repeat";
  static const String isFavorite = "isFavorite";
  static const String isCompleted = "isCompleted";
}
