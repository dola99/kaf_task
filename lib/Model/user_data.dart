class UserData {
  int id;
  String firstName;
  String lastName;
  String about;
  List<Tag> tags;
  List<String> favoriteSocialMedia;
  int salary;
  String email;
  String birthDate;
  int gender;
  UserType type;
  String avatar;

  UserData._privateConstructor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.tags,
    required this.favoriteSocialMedia,
    required this.salary,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.type,
    required this.avatar,
  });

  // Singleton instance
  static final UserData _instance = UserData._privateConstructor(
    id: 0,
    firstName: '',
    lastName: '',
    about: '',
    tags: [],
    favoriteSocialMedia: [],
    salary: 0,
    email: '',
    birthDate: '',
    gender: 0,
    type: UserType(code: 0, name: '', niceName: ''),
    avatar: '',
  );

  factory UserData.getInstance() {
    return _instance;
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    List<Tag> tags =
        (json['tags'] as List).map((tagJson) => Tag.fromJson(tagJson)).toList();

    List<String> favoriteSocialMedia =
        List<String>.from(json['favorite_social_media']);

    return UserData._privateConstructor(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      about: json['about'],
      tags: tags,
      favoriteSocialMedia: favoriteSocialMedia,
      salary: json['salary'],
      email: json['email'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      type: UserType.fromJson(json['type']),
      avatar: json['avatar'],
    );
  }
}

class Tag {
  int id;
  String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'], name: json['name']);
  }
}

class UserType {
  int code;
  String name;
  String niceName;

  UserType({required this.code, required this.name, required this.niceName});

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      code: json['code'],
      name: json['name'],
      niceName: json['nice_name'],
    );
  }
}
