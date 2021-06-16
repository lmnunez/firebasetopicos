import 'package:firebasetopicos/list_page.dart';
import 'package:firebasetopicos/save_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE : (_) => ListPage(),
        SavePage.ROUTE : (_) => SavePage()
      },
    );
  }
}