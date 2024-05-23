// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class GoogleMapsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(
//         center: LatLng(37.7749, -122.4194), // Coordenadas iniciales (San Francisco, CA)
//         zoom: 12.0, // Zoom inicial
//       ),
//       layers: [
//         TileLayerOptions(
//           urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//           subdomains: ['a', 'b', 'c'],
//         ),
//         MarkerLayerOptions(
//           markers: [
//             Marker(
//               width: 80.0,
//               height: 80.0,
//               point: LatLng(37.7749, -122.4194), // Coordenadas del marcador
//               builder: (ctx) => Container(
//                 child: FlutterLogo(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class GoogleMapsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Altura fija para el contenedor de Google Maps
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Mapa aquí próximamente',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}