class UsersProject {
  UsersProject({
    this.idPro,
    this.namePro,
    // this.question
  });

  int idPro;
  String namePro;
  //String question;

  factory UsersProject.fromJson(Map<String, dynamic> json) => UsersProject(
    idPro: json["id"],
    namePro: json["name"],
    // question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "id": idPro,
    "name": namePro,
    // "question": question,
  };
}