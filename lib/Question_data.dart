class QuestionC {
  QuestionC({
    this.assetid,
    this.question,this.awnser,this.type
    // this.question
  });

  int assetid;
  String question;
  String awnser;
  String type;
  //String question;

  factory QuestionC.fromJson(Map<String, dynamic> json) => QuestionC(
    assetid: json["assetid"],
    question: json["question"],awnser: json["awnser"],type: json["type"]
    // question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "assetid": assetid,
    "question": question,"awnser": awnser,"type": type
    // "question": question,
  };
}