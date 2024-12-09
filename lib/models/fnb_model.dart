// To parse this JSON data, do
//
//     final fnb = fnbFromJson(jsonString);

import 'dart:convert';

List<Fnb> fnbFromJson(String str) => List<Fnb>.from(json.decode(str).map((x) => Fnb.fromJson(x)));

String fnbToJson(List<Fnb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fnb {
    Model model;
    String pk;
    Fields fields;

    Fnb({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Fnb.fromJson(Map<String, dynamic> json) => Fnb(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    String image;
    int price;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.image,
        required this.price,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
    };
}

enum Model {
    FNB_FNB
}

final modelValues = EnumValues({
    "fnb.fnb": Model.FNB_FNB
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
