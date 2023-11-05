class NotesList {
  final String id;
  final String title;
  final String content;

  NotesList({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "title":title,
      "content":content
    };
  }

  factory NotesList.fromjson(Map<String,dynamic> json){
    return NotesList(id: json['id'], title: json['title'], content: json['content']);
  }
}
