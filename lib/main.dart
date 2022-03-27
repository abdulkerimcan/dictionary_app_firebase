


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'DetailPage.dart';
import 'Words.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSearching = false;
  String searchWord = "";

  var refWords = FirebaseDatabase.instance.ref().child("kelimeler");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: InputDecoration(hintText: "Search"),
                onChanged: (searchResult) {
                  print(searchResult);
                  setState(() {
                    searchWord = searchResult;
                  });
                },
              )
            : Text("Dictionary App"),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refWords.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var list = <Words>[];
            var datas = event.data!.snapshot.value as dynamic;
            if(datas != null) {
              datas.forEach((key,object) {
                var word = Words.fromJson(key, object);
                if(isSearching) {
                  if(word.eng.contains(searchWord) || word.tur.contains(searchWord))
                    list.add(word);
                }else {
                   list.add(word);
                }
              });
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                var word = list[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(list[i])));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${word.eng}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${word.tur}",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            print("no data");
            return Center();
          }
        },
      ),
    );
  }
}
