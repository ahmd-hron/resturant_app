import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const HomeTest(),
    );
  }
}

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapShot.hasError) {
            print('snapShotHasError');
            print(snapShot.error);
            return SizedBox();
          }
          print(snapShot.connectionState);
          print(snapShot.data);
          if (snapShot.connectionState != ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Container(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc('JzhZz4PnoGWhBZY3Kg0L')
                          .get(),
                      builder: (ctx, snapShot) {
                        print('no problem so far');
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final data = snapShot.data
                            as DocumentSnapshot<Map<String, dynamic>>;
                        print(data['name']);
                        return Text(data['name']);
                      }),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
