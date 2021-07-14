import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiRest{
  Future<List<dynamic>> getPokemons() async {
    var parsed;
    try{
    var response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/ability/?limit=150&offset=150"),
    );
    parsed = json.decode(response.body);
    }catch(e){
      print(e.toString());
    }finally {
      if (parsed != null) {
        // sign in successful!
        // ignore: control_flow_in_finally
        return parsed["results"];
      } else {
        // ignore: control_flow_in_finally
        return null;
      }
    }
  }
  Future<List<dynamic>> getdetails(String url) async {
    var parsed;
    try{
    var response = await http.get(
      Uri.parse(url),
    );
    parsed = json.decode(response.body);
    }catch(e){
      print(e.toString());
    }finally {
      if (parsed != null) {
        // sign in successful!
        // ignore: control_flow_in_finally
        return parsed["flavor_text_entries"];
      } else {
        // ignore: control_flow_in_finally
        return null;
      }
    }
  }
}