import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_rapiddtech/view_models/task_provider.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
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
                'Add a New Task,',
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2AC6BD))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2AC6BD))),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2AC6BD))),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<TaskProvider>(
                          builder: (context, taskProvider, child) {
                        if (taskProvider.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2AC6BD),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print('called');
                              await taskProvider.addTask(titleController.text,
                                  descriptionController.text, context);
                              print('called 2');
                              titleController.text = '';
                              descriptionController.text = '';
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Color(0xFF2AC6BD),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
