class Course {
  Source source;
  String id,
      cname,
      owner,
      descp,
      duration,
      image;

  Course(
      {this.source,
      this.id,
      this.cname,
      this.owner,
      this.descp,
      this.duration,
      this.image});

  factory Course.fromJson(Map<String , dynamic> json) {
    return Course(
      source: Source.fromJson(json["source"]),
      id: json["id"],
      cname: json["cname"],
      owner: json["owner"],
      descp: json["descp"],
      duration: json["duration"],
      image: json["image"]); 
    }
  }

  class Source {
    String id;
    String owner;

  Source({this.id, this.owner});

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
      id: json["id"] as String,
      owner: json["owner"] as String,
    );
  }
}
