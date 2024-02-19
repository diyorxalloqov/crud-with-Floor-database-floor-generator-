import 'package:floor_flutter_database/dao/userDao.dart';
import 'package:floor_flutter_database/db/user_db.dart';
import 'package:floor_flutter_database/model/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDatabase? userDatabase;
  UserDao? userDao;
  late TextEditingController _textEditingController;

  builder() async {
    userDatabase =
        await $FloorUserDatabase.databaseBuilder('UserModel.db').build();
    setState(() {
      userDao = userDatabase?.userDao;
    });
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    builder();
    super.initState();
  }

  String patientName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor database'),
      ),
      body: StreamBuilder(
          stream: userDao?.getAllUserModels(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (!snapshot.hasData) {
              const Center(child: Text('Database is empty'));
            }
            final userList = snapshot.data;
            return ListView.builder(
                itemCount: userList?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      showAdaptiveDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('ismni kiriting'),
                                content: Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      autofocus: true,
                                      controller: _textEditingController,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: const InputDecoration(
                                          hintText: 'update'),
                                    ))
                                  ],
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('update'),
                                    onPressed: () {
                                      if (_textEditingController
                                          .text.isNotEmpty) {
                                        userDao?.updateUserModel(UserModel(
                                            name: _textEditingController.text,
                                            userID: userList?[index].userID));
                                        _textEditingController.clear();
                                        Navigator.of(context).pop(patientName);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Please Enter Name'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ));
                    },
                    onLongPress: () {
                      userDao?.deleteUserModel(
                          UserModel(userID: userList?[index].userID));
                    },
                    leading: const Icon(Icons.person),
                    title: Text(userList?[index].name ?? ''),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          showAdaptiveDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('ismni kiriting'),
                content: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      autofocus: true,
                      controller: _textEditingController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(hintText: 'example'),
                    ))
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () async {
                      patientName = _textEditingController.text;
                      var patient = UserModel(name: patientName);
                      if (patientName.isNotEmpty) {
                        // ScaffoldMessenger.of(context)
                        await userDao?.insertUserModel(patient);
                        _textEditingController.clear();
                        Navigator.of(context).pop(patientName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please Enter Patient Name'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
