import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restapi/model/valuekey.dart';
import '../../model/commentmodel.dart';

class Comment extends StatefulWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List<CommentModel> commentList = [];
  String url = 'https://jsonplaceholder.typicode.com/comments';
  Future<List<CommentModel>> commentApi() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      commentList.clear();
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        commentList.add(CommentModel.fromJson(i));
      }
      return commentList;
    } else {
      throw Exception("Failed to fetch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Comment Api"),
      ),
      body: FutureBuilder(
        future: commentApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: commentList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Paires(
                          keys: 'Name',
                          values: commentList[index].name.toString(),
                        ),
                        Paires(
                          keys: 'Email',
                          values: commentList[index].email.toString(),
                        ),
                        Paires(
                          keys: 'Description',
                          values: commentList[index].body.toString(),
                        ),
                      ],
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
