class Data {
  late final Info info;
  late final List<Character> results;

  Data({required this.info, required this.results});

  factory Data.fromJson(Map<String, dynamic> json) {
    final info = Info.fromJson(json['info'] as Map<String, dynamic>);
    final resultsData = json['results'] as List<Map<String, dynamic>>;
    return Data(
        info: info,
        results: resultsData.map((e) => Character.fromJson(e)).toList());
  }
}

class Info {
  late int count;

  Info({required this.count});

  factory Info.fromJson(Map<String, dynamic> json) {
    final count = json['count'];
    if (count is! int) {
      throw FormatException(
          'Invalid JSON: required "count" field of type String in $json');
    }
    return Info(count: count);
  }
}

class Character {
  late final int id;
  late final String name;
  late final String image;
  late final String status;
  late final String species;
  late final String type;
  late final String gender;
  late final Origin origin;

  Character(
      {required this.id,
      required this.name,
      required this.image,
      required this.gender,
      required this.status,
      required this.origin,
      required this.species,
      required this.type});

  factory Character.fromJson(json) {
    final id = json['id'];
    if (id is! int) {
      throw FormatException(
          'Invalid JSON: required "id" field of type String in $json');
    }
    final name = json['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $json');
    }
    final image = json['image'];
    if (image is! String) {
      throw FormatException(
          'Invalid JSON: required "image" field of type String in $json');
    }
    final status = json['status'];
    if (status is! String) {
      throw FormatException(
          'Invalid JSON: required "status" field of type String in $json');
    }
    final species = json['species'];
    if (species is! String) {
      throw FormatException(
          'Invalid JSON: required "species" field of type String in $json');
    }
    final type = json['type'];
    if (type is! String) {
      throw FormatException(
          'Invalid JSON: required "type" field of type String in $json');
    }
    final gender = json['gender'];
    if (gender is! String) {
      throw FormatException(
          'Invalid JSON: required "gender" field of type String in $json');
    }
    return Character(
        id: id,
        name: name,
        image: image,
        gender: gender,
        status: status,
        origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
        species: species,
        type: type);
  }
}

class Origin {
  late final String name;

  Origin({required this.name});

  factory Origin.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $json');
    }
    return Origin(name: name);
  }
}

// Map<String ,dynamic> map={
//   "info": {
//     "count": 826,}
//   ,"results": [
//   {
//     "id": 1,
//     "name": "Rick Sanchez",
//     "status": "Alive",
//     "species": "Human",
//     "type": "",
//     "gender": "Male",
//     "origin": {
//       "name": "Earth (C-137)",
//       "url": "https://rickandmortyapi.com/api/location/1"
//     },},],
// };
