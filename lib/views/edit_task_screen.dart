import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTask extends StatefulWidget {
  final String docId;
  final String title;
  final String description;
  const EditTask(
      {super.key,
      required this.docId,
      required this.title,
      required this.description});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title!;
    descriptionController.text = widget.description!;
  }

  void updateTextInFirestore(String value, docId, String fieldName) {
    FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      fieldName: value,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2AC6BD),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/hemburger_icon.png',
                    scale: 2,
                  ),
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 40),
              child: Text(
                'Update Task,',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(widget.docId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              TextFormField(
                                controller: titleController,
                                cursorColor: Colors.black,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  label: Text(
                                    'Title',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: descriptionController,
                                  cursorColor: Colors.black,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF2AC6BD))),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF2AC6BD))),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF2AC6BD))),
                                    label: Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(widget.docId)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.data();
                                    String firestoreText = data!['title'] ?? '';
                                    return Text(
                                        'Firestore Text: $firestoreText');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          );
                        }
                        if (!snapshot.hasData) {
                          // var data = snapshot.data!.data();
                          // String firestoreText = data!['title'] ?? '';
                          return Text('Error');
                        }
                        var data = snapshot.data!.data();
                        titleController.text = data!['title'];
                        descriptionController.text = data['description'];
                        return Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              cursorColor: Colors.black,
                              onChanged: (value) {
                                updateTextInFirestore(
                                    value, widget.docId, 'title');
                              },
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF2AC6BD))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF2AC6BD))),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF2AC6BD))),
                                label: Text(
                                  'Title',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: descriptionController,
                                cursorColor: Colors.black,
                                onChanged: (value) {
                                  updateTextInFirestore(
                                      value, widget.docId, 'description');
                                },
                                maxLines: null,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF2AC6BD))),
                                  label: Text(
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
