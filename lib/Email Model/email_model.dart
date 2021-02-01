class EmailAddress {
  EmailAddress({
    this.id,
     this.email_address,
    this.password
  });

  int id;
  String email_address;
  String password;

  factory EmailAddress.fromJson(Map<String, dynamic> json) => EmailAddress(
    id: json["id"],
    email_address: json["email_address"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
      "email_address": email_address,
    "password": password,
  };
}