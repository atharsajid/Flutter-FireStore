import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/color.dart';
import 'package:google_sign_in/homeScreen/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  adddata() async {
    await FirebaseFirestore.instance.collection("Users").add({
      "Todo Task": textadd.text,
      "Date":
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
    });
    textadd.clear();
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  int index = 0;

  String addtextfield = "";

  //isNotEmpty function
  submit() {
    setState(() {
      tasklist.add(addtextfield);
      textadd.clear();
      Navigator.pop(context);
    });
  }

  notsubmit() {
    setState(() {
      Navigator.pop(context);
    });
  }
  //edit function

  TextEditingController textadd = TextEditingController();
  TextEditingController textedit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar("ToDo List"),
        drawer: drawer(),
        body: StreamBuilder(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                Center(
                  child: Text("SomeThing Went Wrong"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                      title: Text(data['Todo Task']),
                      subtitle: Text(data['Date']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                document.reference.delete();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: primary,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Edit Your Task"),
                                    content: TextField(
                                      onChanged: (value) {
                                        addtextfield = value;
                                      },
                                      controller: textedit,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              document.reference.update(
                                                  {"Todo Task": textedit.text});

                                              textedit.clear();
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ));
                }).toList(),
              );
            }),
        floatingActionButton: floatingbtn());
  }

//Floating action Add button
  Widget floatingbtn() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          addDialogbox(context);
        });
      },
      child: Icon(
        Icons.add,
        color: white,
      ),
    );
  }

//Add dialogbox
  void addDialogbox(
    BuildContext context,
  ) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Write your Text",
            ),
            onChanged: (value) {
              addtextfield = value;
            },
            controller: textadd,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // textadd.text.isNotEmpty ? submit() : notsubmit();
                setState(() {
                  adddata();
                  Navigator.pop(context);
                });
              },
              child: const Text("Add"),
            ),
          ],
        ),
      );

//Add dialogbox
  void editDialogbox(BuildContext context, int index) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Edit Your Task"),
          content: TextField(
            onChanged: (value) {
              addtextfield = value;
            },
            controller: textedit,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    tasklist[index] = addtextfield;
                    textedit.clear();
                    Navigator.pop(context);
                  },
                );
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      );
}

List<String> tasklist = [];
