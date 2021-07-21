// To parse this JSON data, do
//
//     final police = policeFromJson(jsonString);

// Police-->Features----> Geometry----> Coordinates
// Police-->Features----> FeatureProperties -----> Name

import 'dart:convert';

Police policeFromJson(String str) => Police.fromJson(json.decode(str));

String policeToJson(Police data) => json.encode(data.toJson());

class Police {
  Police({
    this.type,
    this.features,
    this.totalFeatures,
    this.numberMatched,
    this.numberReturned,
    this.timeStamp,
    this.crs,
  });

  String type;
  List<Feature> features;
  int totalFeatures;
  int numberMatched;
  int numberReturned;
  DateTime timeStamp;
  Crs crs;

  factory Police.fromJson(Map<String, dynamic> json) => Police(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        totalFeatures: json["totalFeatures"],
        numberMatched: json["numberMatched"],
        numberReturned: json["numberReturned"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        crs: Crs.fromJson(json["crs"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "totalFeatures": totalFeatures,
        "numberMatched": numberMatched,
        "numberReturned": numberReturned,
        "timeStamp": timeStamp.toIso8601String(),
        "crs": crs.toJson(),
      };
}

class Crs {
  Crs({
    this.type,
    this.properties,
  });

  String type;
  CrsProperties properties;

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        type: json["type"],
        properties: CrsProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
      };
}

class CrsProperties {
  CrsProperties({
    this.name,
  });

  String name;

  factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Feature {
  Feature({
    this.type,
    this.id,
    this.geometry,
    this.geometryName,
    this.properties,
  });

  FeatureType type;
  String id;
  Geometry geometry;
  GeometryName geometryName;
  FeatureProperties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        geometryName: geometryNameValues.map[json["geometry_name"]],
        properties: FeatureProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "id": id,
        "geometry": geometry.toJson(),
        "geometry_name": geometryNameValues.reverse[geometryName],
        "properties": properties.toJson(),
      };
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  GeometryType type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

enum GeometryName { GEOM }

final geometryNameValues = EnumValues({"geom": GeometryName.GEOM});

class FeatureProperties {
  FeatureProperties({
    this.id,
    this.globalId,
    this.name,
    this.wardCode,
    this.timestamp,
    this.lgaName,
    this.stateCode,
    this.stateName,
  });

  int id;
  String globalId;
  String name;
  String wardCode;
  DateTime timestamp;
  String lgaName;
  StateCode stateCode;
  StateName stateName;

  factory FeatureProperties.fromJson(Map<String, dynamic> json) =>
      FeatureProperties(
        id: json["id"],
        globalId: json["global_id"],
        name: json["name"],
        wardCode: json["ward_code"],
        timestamp: DateTime.parse(json["timestamp"]),
        lgaName: json["lga_name"],
        stateCode: stateCodeValues.map[json["state_code"]],
        stateName: stateNameValues.map[json["state_name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "global_id": globalId,
        "name": name,
        "ward_code": wardCode,
        "timestamp": timestamp.toIso8601String(),
        "lga_name": lgaName,
        "state_code": stateCodeValues.reverse[stateCode],
        "state_name": stateNameValues.reverse[stateName],
      };
}

enum StateCode {
  TA,
  OG,
  LA,
  OS,
  OY,
  AB,
  EB,
  GO,
  EN,
  IM,
  EK,
  NA,
  PL,
  AN,
  CR,
  NI,
  KW,
  ON,
  BY,
  ED,
  RI
}

final stateCodeValues = EnumValues({
  "AB": StateCode.AB,
  "AN": StateCode.AN,
  "BY": StateCode.BY,
  "CR": StateCode.CR,
  "EB": StateCode.EB,
  "ED": StateCode.ED,
  "EK": StateCode.EK,
  "EN": StateCode.EN,
  "GO": StateCode.GO,
  "IM": StateCode.IM,
  "KW": StateCode.KW,
  "LA": StateCode.LA,
  "NA": StateCode.NA,
  "NI": StateCode.NI,
  "OG": StateCode.OG,
  "ON": StateCode.ON,
  "OS": StateCode.OS,
  "OY": StateCode.OY,
  "PL": StateCode.PL,
  "RI": StateCode.RI,
  "TA": StateCode.TA
});

enum StateName {
  TARABA,
  OGUN,
  LAGOS,
  OSUN,
  OYO,
  ABIA,
  EBONYI,
  GOMBE,
  ENUGU,
  IMO,
  EKITI,
  NASARAWA,
  PLATEAU,
  ANAMBRA,
  CROSS_RIVER,
  NIGER,
  KWARA,
  ONDO,
  BAYELSA,
  EDO,
  RIVERS
}

final stateNameValues = EnumValues({
  "Abia": StateName.ABIA,
  "Anambra": StateName.ANAMBRA,
  "Bayelsa": StateName.BAYELSA,
  "Cross River": StateName.CROSS_RIVER,
  "Ebonyi": StateName.EBONYI,
  "Edo": StateName.EDO,
  "Ekiti": StateName.EKITI,
  "Enugu": StateName.ENUGU,
  "Gombe": StateName.GOMBE,
  "Imo": StateName.IMO,
  "Kwara": StateName.KWARA,
  "Lagos": StateName.LAGOS,
  "Nasarawa": StateName.NASARAWA,
  "Niger": StateName.NIGER,
  "Ogun": StateName.OGUN,
  "Ondo": StateName.ONDO,
  "Osun": StateName.OSUN,
  "Oyo": StateName.OYO,
  "Plateau": StateName.PLATEAU,
  "Rivers": StateName.RIVERS,
  "Taraba": StateName.TARABA
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
