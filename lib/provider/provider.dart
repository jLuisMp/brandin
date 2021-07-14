import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/api/database.dart';
import 'package:pokedex/models/pokemon.dart';

class MyProvider with ChangeNotifier {
  //Creamos una clase "MyProvider" y le agregamos las capacidades de Change Notifier.
  /*
    La propiedad WITH
    Un mixin se refiere a  agregar las capacidades de otra clase o clases a nuestra propia clase,
    sin heredar de esas clases. Los métodos de esas clases ahora pueden llamarse en su clase, y el código 
    dentro de esas clases se ejecutará. Dart no tiene herencia múltiple, pero el uso de mixins le permite 
    plegarse en otras clases para lograr la reutilización del código y evitar los problemas que podría causar
   la herencia múltiple.
  */
  bool _selected=false;
  bool _selectedDouble=false;
  Pokemon _pokemon=Pokemon(name: "",url: "");
  String _name="Equipo1";
  List<Widget> _listflavor=[];
  List<String> _listEquipos=[];
  DataBase _handler; //Dentro de nuestro provider, creamos e inicializamos nuestra variable.

  Pokemon get pokemon =>
      _pokemon; //Creamos el metodo Get, para poder obtener el valor de mitexto
  bool get selected =>
      _selected;
  bool get selectedDouble =>
      _selectedDouble;
  List<Widget> get listFlavor =>
      _listflavor;
  List<String> get listEquipos =>
      _listEquipos;
  DataBase get handler =>
      _handler;
  String get name =>
      _name;
  bool isSelected(String name){
    for(var item in listEquipos){
      if(item==name){
        return true;
      }
    }
    return false;
  }
  //Ahora creamos el metodo set para poder actualizar el valor de _mitexto, este metodo recibe un valor newTexto de tipo String
  set pokemon(Pokemon newPokemon) {
    _pokemon= newPokemon; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set selected(bool newSelected) {
    _selected = newSelected; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set selectedDouble(bool newSelected) {
    _selectedDouble = newSelected; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set listFlavor(List<Widget> newListFlavor) {
    _listflavor = newListFlavor; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set listEquipos(List<String> newListEquipos) {
    _listEquipos = newListEquipos; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set itemEquipos(String newItem) {
    _listEquipos.add(newItem); //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set handler(DataBase newhandler) {
    _handler=newhandler; //actualizamos el valor
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }
  set name(String newName){
      _name=newName;
      notifyListeners();
  }
}