import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/provider/preference.dart';
import 'package:pokedex/views/pokemons/list_pokemos.dart';

class Login extends StatelessWidget{
  TextEditingController nameController= TextEditingController();
  Preferences preferences= Preferences();
  List<Widget> list=[];
  Login({this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }
  Widget body(BuildContext context){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Ingresa tu Nombre"),
          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 10),
            child: TextField(
              controller: nameController,
            ),
          ),
          RaisedButton(
            child: Text("Ingresar"),
            onPressed: (){
              preferences.logged=true;
              preferences.commit();   
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListPokemons(list:list)));  
            })
        ],
    );
  }
}