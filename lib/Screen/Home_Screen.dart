import 'package:firebase02/Utils/Auth.dart';
import 'package:firebase02/Utils/RealDatabase.dart';
import 'package:firebase02/model/FireModel.dart';
import 'package:firebase02/model/ModelNews.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtBody = TextEditingController();
  TextEditingController txtPhoto = TextEditingController();
  TextEditingController txtDTitle = TextEditingController();
  TextEditingController txtDBody = TextEditingController();
  TextEditingController txtDPhoto = TextEditingController();

  List<FireModel> l1 = [];
  List<ModelNews> l2 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                Auth().signOut(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: txtTitle,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtBody,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtPhoto,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  RealDatabase()
                      .addNews(txtTitle.text, txtBody.text, txtPhoto.text);
                },
                child: Text("Add News"),
              ),
              // Expanded(
              //   child: StreamBuilder(
              //     stream: RealDatabase().getReadNews(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       l1.clear();
              //       if (snapshot.hasError) {
              //         return Text("${snapshot.error}");
              //       } else if (snapshot.hasData) {
              //         DataSnapshot snap = snapshot.data.snapshot;
              //
              //         for (DataSnapshot sp in snap.children) {
              //           String photo = sp.child("photo").value.toString();
              //           String title = sp.child("title").value.toString();
              //           String body = sp.child("body").value.toString();
              //           String? key = sp.key;
              //
              //           FireModel firemodel =
              //               FireModel(photo, title, body, key!);
              //           l1.add(firemodel);
              //         }
              //
              //         return ListView.builder(
              //           itemCount: l1.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               child: Column(
              //                 children: [
              //                   Container(
              //                       width: double.infinity,
              //                       height: 150,
              //                       child: Image.network(
              //                         l1[index].photo,
              //                         fit: BoxFit.cover,
              //                       )),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                     children: [
              //                       Text(
              //                         "${l1[index].title}",
              //                         style: TextStyle(fontSize: 15),
              //                       ),
              //                       Text(
              //                         "${l1[index].body}",
              //                         style: TextStyle(fontSize: 15),
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                     children: [
              //                       TextButton(
              //                         onPressed: () {
              //                           setState(() {
              //                             txtDTitle.text = l1[index].title;
              //                             txtDBody.text = l1[index].body;
              //                             txtDPhoto.text = l1[index].photo;
              //                           });
              //
              //                           updateDialog(l1[index].key);
              //                         },
              //                         child: Text("update"),
              //                       ),
              //                       TextButton(
              //                         onPressed: () {
              //                           RealDatabase()
              //                               .deleteNews(l1[index].key);
              //                         },
              //                         child: Text("delete"),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         );
              //       }
              //       return CircularProgressIndicator();
              //     },
              //   ),
              // ),

              Expanded(
                child: StreamBuilder(
                    stream: RealDatabase().getReadNews(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        DataSnapshot datasnaphot = snapshot.data.snapshot;

                        for (var x in datasnaphot.children) {
                          String title = x.child("title").value.toString();
                          String body = x.child("body").value.toString();
                          String photo = x.child("photo").value.toString();
                          String? key = x.key;

                          ModelNews m1 = ModelNews(title, body, photo,key!);
                          l2.add(m1);
                        }

                        return ListView.builder(
                            itemCount: l2.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: InkWell(
                                    onTap: () {
                                          RealDatabase().deleteNews(l2[index].key);
                                    },
                                    child: Text("${l2[index].title}")),
                                title: Text("${l2[index].body}"),
                                subtitle: Text("${l2[index].photo}"),
                              );
                            });
                      }

                      return CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDialog(String key) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              TextField(
                controller: txtDTitle,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtDBody,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtDPhoto,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  RealDatabase().updateData(
                      txtDTitle.text, txtDBody.text, txtDPhoto.text, key);

                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }
}
