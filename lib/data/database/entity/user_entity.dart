import 'package:floor/floor.dart';

@entity
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(nullable: false)
  String username;

  @ColumnInfo(nullable: false)
  String password;

  @ColumnInfo(nullable: false)
  String fullname;

  @ignore
  bool isSelect = false;

  UserEntity(this.id,this.username,this.password,this.fullname);

  UserEntity.fromJson(Map<String, dynamic> json) {
    this.username = json["username"];
    this.password = json["password"];
    this.fullname = json["fullname"];
  }
}