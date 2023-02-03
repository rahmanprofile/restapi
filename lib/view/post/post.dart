import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi/model/valuekey.dart';
import '../../model/postmodel.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String url = "http://jsonplaceholder.typicode.com/posts";
  List<Postmodel> postList = [];
  Future<List<Postmodel>> getPost() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        postList.add(Postmodel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
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
        title: const Text("PostApi Example"),
      ),
      body: FutureBuilder(
        future: getPost(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Container(
                      //height: 100,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Paires(
                            keys: 'Title : ',
                            values: postList[index].title.toString(),
                          ),
                          Paires(
                            keys: 'Description : ',
                            values: postList[index].body.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
