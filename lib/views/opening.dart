import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/api/api_rest.dart';
import 'package:pokedex/api/database.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/provider/preference.dart';
import 'package:pokedex/views/auth/login.dart';
import 'package:pokedex/views/pokemons/list_pokemos.dart';
import 'package:pokedex/views/widgets/cards.dart';

class Opening extends StatefulWidget{
  DataBase handler;
  Opening({this.handler});
  OpeningState createState()=> OpeningState();
}
class OpeningState extends State<Opening>{
  Preferences preferences=Preferences();
  List<Widget> list;
  ApiRest api=ApiRest();
  @override
  void initState() {
    super.initState();
    list=[];
    changeView();
  }
  Future<bool> getPokemons() async {
    List<Widget> pokemons=[];
    await api.getPokemons().then((value) {
    for(var i=0;i<value.length;i++){
      pokemons.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PokemonCard(pokemon: Pokemon.fromMap(value[i]),handler:widget.handler),
          i<=value.length?PokemonCard(pokemon: Pokemon.fromMap(value[i+1]),handler:widget.handler):Container()
        ],
      ));
      i++;
    }
    setState(() {
      list=pokemons;
    });
    return true;
  });
  }
  changeView() {
      getPokemons().then((value){
        print(list);
        preferences.logged
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListPokemons(list:list)))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login(list:list)));
      });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 200,
      height: 200,
    );
  }

} 