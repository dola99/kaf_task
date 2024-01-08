class AppData {
  final List<TagElement> types;
  final List<TagElement> tags;
  final List<SocialMedia> socialMedia;

  AppData({
    required this.types,
    required this.tags,
    required this.socialMedia,
  });

  factory AppData.fromJson(Map<String, dynamic> json) => AppData(
        types: List<TagElement>.from(
            json['types']?.map((x) => TagElement.fromJson(x)) ?? []),
        tags: List<TagElement>.from(
            json['tags']?.map((x) => TagElement.fromJson(x)) ?? []),
        socialMedia: List<SocialMedia>.from(
            json['social_media']?.map((x) => SocialMedia.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        'types': List<dynamic>.from(types.map((x) => x.toJson())),
        'tags': List<dynamic>.from(tags.map((x) => x.toJson())),
        'social_media': List<dynamic>.from(socialMedia.map((x) => x.toJson())),
      };
}

class SocialMedia {
  final String? value;
  final String? label;

  SocialMedia({
    this.value,
    this.label,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        value: json['value'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
      };
}

class TagElement {
  final int? value;
  final String? label;

  TagElement({
    this.value,
    this.label,
  });

  factory TagElement.fromJson(Map<String, dynamic> json) => TagElement(
        value: json['value'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
      };
}
