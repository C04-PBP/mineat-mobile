// To parse this JSON data, do
//
//     final ingredient = ingredientFromJson(jsonString);

import 'dart:convert';

List<Ingredient> ingredientFromJson(String str) => List<Ingredient>.from(json.decode(str).map((x) => Ingredient.fromJson(x)));

String ingredientToJson(List<Ingredient> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ingredient {
    String model;
    String pk;
    Fields fields;

    Ingredient({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    List<String> fnb;

    Fields({
        required this.name,
        required this.fnb,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        fnb: List<String>.from(json["fnb"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "fnb": List<dynamic>.from(fnb.map((x) => x)),
    };
}
