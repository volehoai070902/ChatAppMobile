class UserModel {
  final String? id;
  ///created_at
  final String? created;
  final String? username;
  final String? email;
  ///img_url
  final String? imageUrl;
  String get tableName => "table_user";

  UserModel(
    {
      this.id,
      this.created,
      this.username,
      this.email,
      this.imageUrl,
    });

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: json['id'],
    created: json['created_at'],
    username: json['username'],
    email: json['email'],
    imageUrl: json['img_url']
  );

}