// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// void main() {
//   runApp(new MaterialApp(
//     title: "ListView JSON",
//     //home: new Home(data: new List<String>.generate(300, (i) => "ini data ke $i"),), //mendapatkan data array
//     home: new Home() //mendapatkan data dari JSON
//   ));
// }
//     ///data Array

// // class Home extends StatelessWidget {

// //   //membuat variabel string data
// //   final List<String> data;
// //   Home ({this.data});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: new AppBar(
// //         title: new Text("ListView JSON"),
// //       ),
// //       body: new Container(
// //         child: new ListView.builder( //isi data
// //         itemCount: data.length,
// //         itemBuilder: (context, index) {
// //           return new ListTile(
// //             leading: new Icon(Icons.widgets),
// //             title: new Text("${data[index]}"),
// //           );
// //         },
// //         ),
// //       )
// //     );
// //   }
// // }
//       ///end data Array

//       ///data JSON from https://jsonplaceholder.typicode.com/posts
//       ///
//     class Home extends StatefulWidget {
//       @override
//       _HomeState createState() => _HomeState();
//     }

//     class _HomeState extends State<Home> {

//       List dataJSON; //mengambil data JSON

//       // Future<String> ambildata() async {
//       //   http.Response hasil = await http.get(
//       //     Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"), headers: {
//       //       "Accept" : "application/json"
//       //     }
//       //   );

//         ///membuat perubahan data JSON

//       // this.setState(
//       //   dataJSON = json.decode(hasil.body),
//       // );
//       // }

//       //mengambil data dari Future string (ambildata)
//       @override
//   void initState() {
//     this.ambildata();
//   }

//       @override
//       Widget build(BuildContext context) {
//         return new Scaffold(
//           appBar: new AppBar(
//             title: new Text("ListData JSON"),
//           ),
//           body: new ListView.builder(
//             itemCount: dataJSON == null ? 0 : dataJSON.length, //mengeksekusi jika dataJSON null atau Berisi
//             itemBuilder: (context, i) {
//               return new Card(
//                 child:
//                 new Column(
//                   children: <Widget>[
//                     new Text(dataJSON[i]['title'], style: new TextStyle(
//                   fontSize: 20.0, color: Colors.blue)), //mengambil data title dari JSON URL
//                   new Text(dataJSON[i]['body'])
//                   ],
//                 )
//               );
//             },
//           ),
//         );
//       }
//     }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return null;
//   }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
