import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts Demo',
      debugShowCheckedModeBanner: false,
      home: StorageUpload(),
    );
  }
}

class StorageUpload extends StatefulWidget {
  @override
  StorageUploadState createState() => new StorageUploadState();
}

class StorageUploadState extends State<StorageUpload> {
  List<Map<String, dynamic>> original = [], duplicate = [];
  String query = '';
  TextEditingController tc;
  StreamController<List<Map<String, dynamic>>> controller =
      StreamController<List<Map<String, dynamic>>>();

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    original = [
      {
        'contact_name': 'Test User 1',
        'contact_phone': '066 560 4900',
      },
      {
        'contact_name': 'Test User 2',
        'contact_phone': '066 560 7865',
      },
      {
        'contact_name': 'Test User 3',
        'contact_phone': '906 500 4334',
      }
    ];
    duplicate.addAll(original);
    controller.sink.add(duplicate);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Delivero Contacts",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: tc,
                    decoration: InputDecoration(hintText: 'Search...'),
                    onChanged: (v) {
                      if (v.isEmpty) {
                        duplicate = original;
                        controller.sink.add(duplicate);
                        return;
                      }

                      //If your data is a Map object you can use toString()
                      //and avoid checking both fields
                      duplicate = original
                          .where((m) =>
                              m['contact_name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(v.toLowerCase()) ||
                              m['contact_phone']
                                  .toString()
                                  .toLowerCase()
                                  .contains(v.toLowerCase()))
                          .toList();
                      controller.sink.add(duplicate);
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: StreamBuilder<Object>(
                      stream: controller.stream,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: duplicate.length,
                          itemBuilder: (con, ind) {
                            return query.isEmpty
                                ? ListTile(
                                    title: Text(duplicate[ind]['contact_name']),
                                    subtitle:
                                        Text(duplicate[ind]['contact_phone']),
                                    onTap: () {
                                      setState(() {
                                        tc.text =
                                            duplicate[ind]['contact_name'];
                                        query = duplicate[ind]['contact_name'];
                                      });
                                    },
                                  )
                                : duplicate[ind]['contact_name']
                                            .toString()
                                            .toLowerCase()
                                            .contains(query) ||
                                        duplicate[ind]['contact_phone']
                                            .toString()
                                            .toLowerCase()
                                            .contains(query)
                                    ? ListTile(
                                        title: Text(
                                            duplicate[ind]['contact_name']),
                                        subtitle: Text(
                                            duplicate[ind]['contact_phone']),
                                        onTap: () {
                                          setState(() {
                                            tc.text =
                                                duplicate[ind]['contact_name'];
                                            query =
                                                duplicate[ind]['contact_name'];
                                          });
                                        },
                                      )
                                    : null;
                          },
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }
}
