import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? nameStudent1;
  String? genderStudent1;

  List<String> listNameStudent = [];
  List<String> listGenderStudent = [];
  Color ColorBtn = Colors.white;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final dio = Dio();
    final response =
        await dio.get('https://js-post-api.herokuapp.com/api/students');
    final listStudent = response.data as List<dynamic>;

    for (final student in listStudent) {
      final name = student['name'];

      listNameStudent.add(name.toString());
    }
    final listGender = response.data as List<dynamic>;

    for (final student in listStudent) {
      final gender = student['gender'];

      listGenderStudent.add(gender.toString());
    }

    print(listNameStudent.length);
    setState(() {});
    print(listGenderStudent.length);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(children: [
        SizedBox(
          height: 60,
        ),
        Row(children: [
          Container(
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            margin: EdgeInsets.all(10),
          ),
          Divider(
            thickness: 1,
            indent: 300,
            color: Colors.black,
          ),
          Container(
            child: Text(
              'Next',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        ]),
        Container(
          child: Text(
            'Invite Friends',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          margin: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: listNameStudent.length,
                itemBuilder: (context, index) {
                  return BoxItem(
                    nameStudent: listNameStudent[index],
                    genderStudent: listGenderStudent[index],
                  );
                }),
          ),
        ),
      ]),
    );
  }
}

class BoxItem extends StatefulWidget {
  const BoxItem({
    super.key,
    required this.nameStudent,
    required this.genderStudent,
  });

  final String nameStudent;
  final String genderStudent;

  @override
  State<BoxItem> createState() => _BoxItemState();
}

class _BoxItemState extends State<BoxItem> {
  bool click = false;
  Color ColorBtn = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60,
          child: Container(
            child: Container(
              height: 30,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                  child: Image(
                      image: NetworkImage(
                          'https://th.bing.com/th/id/OIP.nMIr-nB5v0rbPzWEJzeZcQHaE7?pid=ImgDet&rs=1'))),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              color: Colors.blueGrey,
              child: ListTile(
                title: Text(
                  widget.nameStudent,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: (Text(
                  widget.genderStudent,
                  style: TextStyle(color: Colors.white30, fontSize: 15),
                )),
              ),
            ),
          ),
        ),
        Divider(
          thickness: 50,
          color: Colors.black,
          indent: 50,
          height: 30,
        ),
        Container(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                  color: ColorBtn),
              child: Icon(click == false ? Icons.add : Icons.check, size: 30),
            ),
            onTap: () {
              ColorBtn = click == false ? Colors.red : Colors.white;
              setState(() {
                click = !click;
              });
            },
          ),
        ),
      ],
    );
  }
}
