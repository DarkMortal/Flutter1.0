class Task{
  late String title;
  List<String> subtasks = <String>[];
  DateTime dateTime = DateTime.now();
  //Time//= DateTime.utc(1989, 11, 9);
  bool isDone = false;
  Task(String title,DateTime dateTime){
    this.title = title;
    this.dateTime = dateTime;
  }
}

class Note{
  late String? title;
  late String desc;
  Note(String? title,String desc){
    this.title = title;
    this.desc = desc;
  }
}