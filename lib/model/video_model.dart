import 'dart:convert';

PixelVideoModel pixelVideoModelFromJson(String str) => PixelVideoModel.fromJson(json.decode(str));

String pixelVideoModelToJson(PixelVideoModel data) => json.encode(data.toJson());

class PixelVideoModel {
  int page;
  int perPage;
  List<Video> videos;
  int totalResults;
  String nextPage;
  String url;

  PixelVideoModel({
    required this.page,
    required this.perPage,
    required this.videos,
    required this.totalResults,
    required this.nextPage,
    required this.url,
  });

  factory PixelVideoModel.fromJson(Map<String, dynamic> json) => PixelVideoModel(
    page: json["page"],
    perPage: json["per_page"],
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    totalResults: json["total_results"],
    nextPage: json["next_page"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "total_results": totalResults,
    "next_page": nextPage,
    "url": url,
  };
}

class Video {
  int id;
  int width;
  int height;
  int duration;
  dynamic fullRes;
  List<dynamic> tags;
  String url;
  String image;
  dynamic avgColor;
  User user;
  List<VideoFile> videoFiles;
  List<VideoPicture> videoPictures;

  Video({
    required this.id,
    required this.width,
    required this.height,
    required this.duration,
    required this.fullRes,
    required this.tags,
    required this.url,
    required this.image,
    required this.avgColor,
    required this.user,
    required this.videoFiles,
    required this.videoPictures,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    duration: json["duration"],
    fullRes: json["full_res"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    url: json["url"],
    image: json["image"],
    avgColor: json["avg_color"],
    user: User.fromJson(json["user"]),
    videoFiles: List<VideoFile>.from(json["video_files"].map((x) => VideoFile.fromJson(x))),
    videoPictures: List<VideoPicture>.from(json["video_pictures"].map((x) => VideoPicture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "duration": duration,
    "full_res": fullRes,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "url": url,
    "image": image,
    "avg_color": avgColor,
    "user": user.toJson(),
    "video_files": List<dynamic>.from(videoFiles.map((x) => x.toJson())),
    "video_pictures": List<dynamic>.from(videoPictures.map((x) => x.toJson())),
  };
}

class User {
  int id;
  String name;
  String url;

  User({
    required this.id,
    required this.name,
    required this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}

class VideoFile {
  int id;
  Quality quality;
  FileType fileType;
  int width;
  int height;
  double fps;
  String link;

  VideoFile({
    required this.id,
    required this.quality,
    required this.fileType,
    required this.width,
    required this.height,
    required this.fps,
    required this.link,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
    id: json["id"],
    quality: qualityValues.map[json["quality"]]!,
    fileType: fileTypeValues.map[json["file_type"]]!,
    width: json["width"],
    height: json["height"],
    fps: json["fps"]?.toDouble(),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quality": qualityValues.reverse[quality],
    "file_type": fileTypeValues.reverse[fileType],
    "width": width,
    "height": height,
    "fps": fps,
    "link": link,
  };
}

enum FileType {
  VIDEO_MP4
}

final fileTypeValues = EnumValues({
  "video/mp4": FileType.VIDEO_MP4
});

enum Quality {
  HD,
  SD,
  UHD
}

final qualityValues = EnumValues({
  "hd": Quality.HD,
  "sd": Quality.SD,
  "uhd": Quality.UHD
});

class VideoPicture {
  int id;
  int nr;
  String picture;

  VideoPicture({
    required this.id,
    required this.nr,
    required this.picture,
  });

  factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
    id: json["id"],
    nr: json["nr"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nr": nr,
    "picture": picture,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
