# Dictionary App by Flutter



## About The Project

I have made a Turkish-English dictionary app in this project. I can receive dictionaries from the database from firebase realtime. And You can search words in this application. <br>

i can get the data on the web in json format. I need to add this method to obtain the object on the web.

Thanks to the following code, I can access the table in the database by creating a reference.
```dart
var refWords = FirebaseDatabase.instance.ref().child("kelimeler");
```

I used the StreamBuilder structure to view our data in a list.

```dart
 body: StreamBuilder<DatabaseEvent>(
        stream: refWords.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var list = <Words>[];
            var datas = event.data!.snapshot.value as dynamic;
            if(datas != null) {
            .
            .
            .
            .
            
```


![image](https://user-images.githubusercontent.com/79968953/159443679-4d7cc9aa-91a0-47d5-8c52-a18f5765bf9e.png)
![image](https://user-images.githubusercontent.com/79968953/159443762-07950ca3-3623-4129-ba74-6b4e4a97b8fe.png)
![image](https://user-images.githubusercontent.com/79968953/159443831-b9a1885f-b8bf-4be8-a580-004656159bf8.png)



