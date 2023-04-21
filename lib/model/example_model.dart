class ExampleModel {
  ExampleModel({
    this.name,
  });

  final String? name;

  static ExampleModel fromJson(Map<String, dynamic> json) => ExampleModel(
        name: json["name"],
      );
}
