import 'package:flutter/material.dart';
import 'package:pokedex/api/database.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  Pokemon pokemon;
  DataBase handler;
  PokemonCard({this.pokemon,this.handler});
  void showNombre(BuildContext context,MyProvider provider){
    TextEditingController controller=TextEditingController();
    showDialog(
      context: context, 
      builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ingresa el nombre del equipo",textAlign: TextAlign.center,),
              content:TextField(
                controller:controller
              ),
              actions: <Widget>[
                TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  provider.itemEquipos=pokemon.name;
                  provider.name=controller.text;
                  provider.selectedDouble=true;
                  Navigator.pop(context);
                }
            ),
                TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
              ],
            );
                  },
      );
  }
  void showNewEquipo(BuildContext context,String label){
    TextEditingController controller=TextEditingController();
    showDialog(
      context: context, 
      builder: (BuildContext context) {
            return AlertDialog(
              title: Text(label,textAlign: TextAlign.center,),
              actions: <Widget>[
                TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
              ],
            );
                  },
      );
  }
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.8),
      borderRadius: const BorderRadius.all(Radius.circular(25))),
        width:myProvider.isSelected(pokemon.name)&&myProvider.selectedDouble?MediaQuery.of(context).size.width*.41:MediaQuery.of(context).size.width*.45,
        height:myProvider.isSelected(pokemon.name)&&myProvider.selectedDouble?MediaQuery.of(context).size.width*.36:MediaQuery.of(context).size.width*.40,
        child: Text(pokemon.name,style: const TextStyle(fontSize: 25),),
      ),
      onTap: (){
        myProvider.selected=true;
        myProvider.pokemon=pokemon;
      },
      onLongPress: (){
        myProvider.pokemon=pokemon;
        if(myProvider.listEquipos.length<6){
          if(myProvider.listEquipos.isEmpty){
            showNombre(context,myProvider);
          }else{
          myProvider.itemEquipos=pokemon.name;
          if(myProvider.listEquipos.length==6){
            Map<String,dynamic> data={
              "name":myProvider.name,
              "item1":myProvider.listEquipos[0],
              "item2":myProvider.listEquipos[1],
              "item3":myProvider.listEquipos[2],
              "item4":myProvider.listEquipos[3],
              "item5":myProvider.listEquipos[4],
              "item6":myProvider.listEquipos[5],
            };
            handler.insertEquipo(data);
            myProvider.listEquipos=[];
            myProvider.selectedDouble=false;
            showNewEquipo(context, "se gurado el equipo: "+myProvider.name);
          }
          }
        }
      },
    );
  }
}