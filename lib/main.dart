import 'package:flutter/material.dart';
import 'package:json/model/student_model.dart';
import 'package:json/services/address_services.dart';
import 'package:json/services/post_services.dart';
import 'package:json/services/student_services.dart';

import 'model/address_model.dart';
import 'model/post_model.dart';

void main() {
  runApp(new MyApp());
//  loadProduct();
//  loadPhotos();

//  loadShape();
//  loadBakery();
//  loadPage();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  int age;
  List<String> street = [];
  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Post>(
            future: getPost(),
            builder: (context, snapshot) {
              // callAPI();
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                }

                return Column(
                  children: [
                    Text('Title from Post JSON : ${snapshot.data.title}' +
                        name +
                        age.toString()),
                    Expanded(
                      child: ListView.builder(
                        itemCount: street.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(street[index]),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else
                return CircularProgressIndicator();
            }));
  }

  void callAPI() {
    Post post = Post(body: 'Testing body body body', title: 'Flutter jam6');
    createPost(post).then((response) {
      if (response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });
  }

  Future<void> getdata() async {
    Student data = await loadStudent();
    Address address = await loadAddress();
    print(address.city);
    address.streets.forEach((element) {
      street.add(element);
    });
    print(street);
    if (data != null) {
      print(data.studentName);
      name = data.studentName;
      age = data.studentScores;
    } else {
      // getdata();
    }
  }
}
