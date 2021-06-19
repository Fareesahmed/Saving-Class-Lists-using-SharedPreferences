import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saving/load.dart';
import 'package:saving/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData extends StatefulWidget {
  const SaveData({Key key}) : super(key: key);

  @override
  _SaveDataState createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  List<User> list = new List<User>();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Future<List<User>> loadData() async {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      setState(() {
        print("Inside the set state");
        list =
            listString.map((item) => User.fromMap(json.decode(item))).toList();
      });
      print("Length of list is---->");
      print(list.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Data"),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              TextField(
                controller: _age,
                decoration: InputDecoration(hintText: "Enter Age"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      addItem(User(age: _age.text, name: _name.text));
                    },
                    child: Text("Save Data"),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext) => LoadData()));
                    },
                    child: Text("Load  Data"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItem(User usr) {
    list.add(usr);
    saveData();
  }

  void saveData() {
    List<String> usrList =
        list.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences.setStringList("list",
        usrList); //This command stores our usrList with key "list" in the local storage
    print(usrList);
    loadData();
  }
}
