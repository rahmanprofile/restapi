import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/photomodel.dart';

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  String url = 'https://jsonplaceholder.typicode.com/photos';
  List<PhotoModel> photoList = [];

  Future<List<PhotoModel>> photoApi() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      photoList.clear();
      var data = jsonDecode(response.body.toString());
      for(Map i in data) {
        photoList.add(PhotoModel.fromJson(i));
      }
      return photoList;
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
        title:const Text("Photo"),
      ),
      body: FutureBuilder(
        future: photoApi(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Text(photoList[index].title.toString()),
                        Text(photoList[index].url.toString()),
                        Text(photoList[index].title.toString()),
                        Image(
                          image: NetworkImage(photoList[index].thumbnailUrl.toString()),
                        ),
                        const SizedBox(height: 4.0),
                        Image(
                          image: NetworkImage(photoList[index].url.toString()),
                        ),
                      ],
                    ),
                  );

                });
          }
        },
      ),
    );
  }
}
