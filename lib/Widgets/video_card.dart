// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoCard extends StatefulWidget {
//   const VideoCard({super.key});

//   @override
//   _VideoCardState createState() => _VideoCardState();
// }

// class _VideoCardState extends State<VideoCard> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Inicializar el controlador con el video desde los assets
//     _controller = VideoPlayerController.asset("assets/videos/vd1.mp4");
//     _initializeVideoPlayerFuture = _controller.initialize();
//     // Configurar el video para que se reproduzca en bucle
//     _controller.setLooping(true);
//   }

//   @override
//   void dispose() {
//     // Liberar los recursos del controlador cuando no se necesita
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         children: [
//           // Usar FutureBuilder para mostrar el video una vez inicializado
//           FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 );
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           const SizedBox(height: 10.0),
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 15,
//                 backgroundColor: Colors.amber,
//                 backgroundImage: AssetImage("assets/images/im3.jpg"),
//               ),
//               const SizedBox(width: 15.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 250,
//                     child: const Text(
//                       "Titulo del Videooooooooooooooooooooooooooooooooooo",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     width: 250,
//                     child: const Text(
//                       "Labbestia - 10000 Visitas",
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.normal),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
