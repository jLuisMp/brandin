import 'package:flutter/material.dart';
import 'package:pokedex/api/database.dart';
import 'package:pokedex/provider/preference.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:pokedex/views/opening.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Preferences preferences= Preferences();
  DataBase handler=DataBase();
  handler.initializeDB();
  preferences.init().then((value){
        preferences = value;
    });
   runApp(MyApp(handler:handler));
   }

class MyApp extends StatelessWidget {
  DataBase handler;
  MyApp({this.handler});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>MyProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: Opening(handler:handler),
    ),
    );
  }
}