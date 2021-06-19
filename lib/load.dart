import 'dart:convert';
import 'package:saving/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoadData extends StatefulWidget {
  const LoadData({Key key}) : super(key: key);

  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
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
        title: Text("Load Data"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          print("Length Is----->");
          print(list.length);
          return ListTile(
            title: Text(list[index].name),
            subtitle: Text(list[index].age),
          );
        },
      ),
    );
  }
}
