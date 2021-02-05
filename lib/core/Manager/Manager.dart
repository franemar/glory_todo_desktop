import 'dart:io';

import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

String tablo = "\\Tablo.txt";
String gorevler = "\\Gorevler.txt";
final PathProviderWindows provider = PathProviderWindows();
//Bu fonksiyonu dosyadan bütün satırları okur ve geri tablo listesi döndürür.
Future<List<Project>> read() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  List<String> cont = File(path).readAsLinesSync();
  var tablolar = <Project>[];
  cont.forEach((element) {
    //print("e: " + element);
    List<String> l = element.split("#");
    Project yeni = new Project(l[0], l[1]);
    tablolar.add(yeni);
  });

  return tablolar;
}

//Dosya Oluştur
void CreateFile() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  new File(path).createSync(recursive: true);
  print("Dosya oluşturuldu !");
}

//Dosyaya Yaz
void WriteTablo(Project tabloEleman) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  File file = new File(path);
  String id = tabloEleman.projectID;
  String isim = tabloEleman.projectHeader;
  file.writeAsStringSync("$id" + "#" + "$isim" + "\n", mode: FileMode.append);
}