class Question {
  Question({
    this.id,
   // this.name,
    this.question
  });

  int id;
 // String name;
  String question;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
   // name: json["name"],
    question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  //  "name": name,
    "question": question,
  };
}