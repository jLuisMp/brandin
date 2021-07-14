
class Pokemon {
  final String url;
  final String name;

  Pokemon(
    { this.url,
      this.name});

  Pokemon.fromMap(Map res)
      : this.url = res["url"],
        this.name = res["name"];
        
  Map<String, Object> toMap() {
    return {'id':url,'name': name,};
  }
}