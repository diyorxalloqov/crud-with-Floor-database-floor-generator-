import 'package:floor/floor.dart';

@entity
class UserModel {
  @PrimaryKey(autoGenerate: true)
  final int? userID;

  final String? name;

  UserModel({this.userID, this.name});
}
