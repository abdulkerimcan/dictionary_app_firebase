class Words {
  String word_id;
  String eng;
  String tur;

  Words(this.word_id, this.eng, this.tur);

  factory Words.fromJson(String key,Map<dynamic,dynamic> json) {
    return Words(key, json["ingilizce"] as String, json["turkce"] as String);
  }
}