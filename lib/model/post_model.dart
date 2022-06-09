class PostModel {
  late String name;
  late String image;
  late String uId;
  String postImage = "" ;
  late String text;
  late String dateTime;

  PostModel({
    required this.name,
    required this.text,
    required this.dateTime,
    required this.image,
    required this.uId,
    required this.postImage,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postImage = json['postImage'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'uId': uId,
      'dateTime': dateTime,
      'image': image,
    };
  }
}
