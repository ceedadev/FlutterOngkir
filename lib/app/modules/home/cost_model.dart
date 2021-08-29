// To parse this JSON data, do
//
//     final cost = costFromJson(jsonString);

import 'dart:convert';

Cost costFromJson(String str) => Cost.fromJson(json.decode(str));

String costToJson(Cost data) => json.encode(data.toJson());

class Cost {
  Cost({
    this.code,
    this.name,
    this.costs,
  });

  String? code;
  String? name;
  List<CostCost>? costs;

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        code: json["code"],
        name: json["name"],
        costs:
            List<CostCost>.from(json["costs"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs!.map((x) => x.toJson())),
      };

  static List<Cost> fromJsonList(List list) {
    if (list.length == 0) return List<Cost>.empty();
    return list.map((item) => Cost.fromJson(item)).toList();
  }
}

class CostCost {
  CostCost({
    this.service,
    this.description,
    this.cost,
  });

  String? service;
  String? description;
  List<CostCostClass>? cost;

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        service: json["service"],
        description: json["description"],
        cost: List<CostCostClass>.from(
            json["cost"].map((x) => CostCostClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost!.map((x) => x.toJson())),
      };
}

class CostCostClass {
  CostCostClass({
    this.value,
    this.etd,
    this.note,
  });

  int? value;
  String? etd;
  String? note;

  factory CostCostClass.fromJson(Map<String, dynamic> json) => CostCostClass(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
