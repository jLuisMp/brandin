import 'package:flutter/material.dart';
import 'package:pokedex/api/api_rest.dart';
import 'package:pokedex/api/database.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/provider/preference.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:pokedex/views/auth/login.dart';
import 'package:provider/provider.dart';

class ListPokemons extends StatelessWidget {
  List<Widget> list;
  ListPokemons({this.list});
  Preferences preferences=Preferences();
  getDetails(MyProvider provider,BuildContext context) async {
    List<Widget> list=[];
    var res=await ApiRest().getdetails(provider.pokemon.url);
    for(var data in res){
      if(data["language"]["name"]=="es"){
        list.add(Container(
          width: MediaQuery.of(context).size.width*.8,
          padding: const EdgeInsets.only(top: 20,bottom: 20),
          child:Text(data["flavor_text"])
        ));
      }
    }
    provider.listFlavor=list;
  }
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return myProvider.selected?Selection(context,myProvider):Scaffold(
      appBar: AppBar(
        title: Text('Pokemons'),
        actions: [
          GestureDetector(
            child: Icon(Icons.exit_to_app),
            onTap: (){
              preferences.logged=false;
              preferences.commit();
              Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: list.toList(),
          ),
        ),
      ),
    );
  }
  Widget Selection(BuildContext context,MyProvider provider){
    getDetails(provider,context);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.9),
      body:Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child:Text(provider.pokemon.name,style: const TextStyle(fontSize: 40),),
      decoration:BoxDecoration(
      color: Colors.blue.withOpacity(0.8),
      borderRadius: const BorderRadius.all(Radius.circular(25))),
      margin: const EdgeInsets.only(bottom:20,left: 20,right: 20,top: 40),
      height: (MediaQuery.of(context).size.height-40)*.52,
      width: MediaQuery.of(context).size.width-40,
    ),
    Container(
      decoration:const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.48,left: 20,right: 20),
      height: (MediaQuery.of(context).size.height-40)*.5,
      width: MediaQuery.of(context).size.width-40,
      child: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height-40)*.4,
            child:SingleChildScrollView(
            child:Column(
              children: provider.listFlavor,
            )
            )
          ),
          GestureDetector(
          child:Container(
            child: Text("Atras",style: const TextStyle(fontSize: 20)),
            height: (MediaQuery.of(context).size.height-40)*.1,
          ),
          onTap: ()=>provider.selected=false,
          )
        ],
      ),
    )
      ],
    ));
  }
}