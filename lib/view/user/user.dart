import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/model/usermodel.dart';
import 'package:restapi/model/valuekey.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String url = 'https://jsonplaceholder.typicode.com/users';
  List<Usermodel> userList = [];

  Future<List<Usermodel>> userApi() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      userList.clear();
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        userList.add(Usermodel.fromJson(i));
      }
      return userList;
    } else {
      throw Exception("Failed to fetch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("User"),
      ),
      body: FutureBuilder(
        future: userApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Paires(
                            keys: "Name",
                            values: userList[index].name.toString(),
                          ),
                          Paires(
                            keys: 'Email',
                            values: userList[index].email.toString(),
                          ),
                          Paires(
                            keys: 'Phone',
                            values: userList[index].phone.toString(),
                          ),
                          Paires(
                            keys: 'Website',
                            values: userList[index].website.toString(),
                          ),
                          Paires(
                            keys: 'Address',
                            values: userList[index].address!.city.toString(),
                          ),
                          Paires(
                            keys: 'Latlong',
                            values:
                                userList[index].address!.geo!.lng.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
