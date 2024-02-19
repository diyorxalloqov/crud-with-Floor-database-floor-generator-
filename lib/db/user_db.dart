import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor_flutter_database/dao/userDao.dart';
import 'package:floor_flutter_database/model/user_model.dart';

part 'user_db.g.dart';

@Database(version: 1, entities: [UserModel])
abstract class UserDatabase extends FloorDatabase {
  UserDao get userDao;
}
