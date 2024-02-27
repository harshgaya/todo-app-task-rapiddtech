import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app_rapiddtech/views/edit_task_screen.dart';
import 'package:todo_app_rapiddtech/views/task_details.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriIsHandled = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uri? _initialUri;

  Uri? _latestUri;

  Object? _err;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        //Get.to(()=> RegisterScreen());
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          // Uri url = Uri.parse(uri);
          Map<String, String> queryParams = uri.queryParameters;
          print('query $queryParams');
          print('got initial uri: $uri');
          if (queryParams['id'] != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (contex) {
              return EditTask(
                  docId: queryParams['id']!,
                  title: queryParams['title']!,
                  description: queryParams['description']!);
            }));
          }

          //Get.to(()=> RegisterScreen());
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: const Color(0xFF2AC6BD),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TaskDetails();
            }));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
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
                'Howdy,',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
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
                child: FirestorePagination(
                  isLive: true,
                  limit: 10, // Defaults to 10.
                  viewType: ViewType.list,
                  bottomLoader: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF2AC6BD),
                    ),
                  ),
                  query: FirebaseFirestore.instance
                      .collection('tasks')
                      .orderBy('timestamp', descending: true),
                  itemBuilder: (context, documentSnapshot, index) {
                    final data =
                        documentSnapshot.data() as Map<String, dynamic>?;
                    if (data == null) return const Text('No Tasks');

                    return ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EditTask(
                            docId: data['id'],
                            title: data['title'],
                            description: data['description'],
                          );
                        }));
                      },
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xFF2AC6BD).withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: const Icon(
                          Icons.task,
                          size: 30,
                          color: Color(0xFF2AC6BD),
                        ),
                      ),
                      title: Text(data['title']),
                      subtitle: Text(data['shortDescription']),
                      trailing: IconButton(
                        onPressed: () {
                          Share.share(
                              'https://todoapptask.000webhostapp.com/task?id=${data['id']}&title=${Uri.encodeComponent(data['title'])}&description=${Uri.encodeComponent(data['description'])}');
                        },
                        icon: const Icon(Icons.share),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
