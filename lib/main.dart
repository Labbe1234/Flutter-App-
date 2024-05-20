import 'package:flutter/material.dart';
import 'package:testapp/Widgets/video_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube"),
        backgroundColor: Colors.green,
        actions: const[
          Icon(Icons.search),
          Icon(Icons.camera_alt_outlined),
          Icon(Icons.person)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: const[
          VideoCard(),
          VideoCard()],),
      ),
    );
  }
}
