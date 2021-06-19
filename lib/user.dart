class User {
  String name;
  String age;
  User({
    this.name,
    this.age,
  });

  User.fromMap(
      Map map) // This Function helps to convert our Map into our User Object
      : this.name = map["name"],
        this.age = map["age"];

  Map toMap() {
    // This Function helps to convert our Object into a Map.
    return {
      "name": this.name,
      "age": this.age,
    };
  }
}
