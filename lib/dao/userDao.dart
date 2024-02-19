import 'package:floor/floor.dart';
import 'package:floor_flutter_database/model/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserModel')
  Stream<List<UserModel>> getAllUserModels();

  @update
  Future<void> updateUserModel(UserModel usermodelUserModel);

  @insert
  Future<void> insertUserModel(UserModel usermodelUserModel);

  @delete
  Future<void> deleteUserModel(UserModel usermodelUserModel);
}
