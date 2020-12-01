class Users {
  Users({
    this.id,
    this.name,
   // this.question
  });

  int id;
  String name;
  //String question;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    name: json["name"],
     // question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
   // "question": question,
  };
}