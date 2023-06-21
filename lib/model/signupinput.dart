class SignUpInput {
  SignUpInput({this.phoneNumber, this.name, this.address});

  int? phoneNumber;
  String? name;
  String? address;
  String? password;

  Map<String, dynamic> toMap() => {
        "password": password,
        "phoneNum": phoneNumber,
        "username": name,
        "roleType": "ADMIN",
        "address": address,
      };

  Map<String, dynamic> tosigninMap() => {
        "password": password,
        "phoneNum": phoneNumber,
      };

  factory SignUpInput.fromMap(Map<String, dynamic> json) => SignUpInput(
      // email: json["email"],
      // password: json["password"],
      // phone: json["phoneNumber"],
      // name: json["name"]

      );
}
