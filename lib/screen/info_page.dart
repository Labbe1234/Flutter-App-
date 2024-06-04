import 'package:flutter/material.dart';
import 'package:testapp/Widgets/info_message.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: Colors.green, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Información',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.cartonTitle, InfoMessages.cartonMessage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.local_activity, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.vidrioTitle, InfoMessages.vidrioMessage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.local_florist, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.plasticoTitle, InfoMessages.plasticoMessage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.local_drink, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.lataTitle, InfoMessages.lataMessage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.category, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.metalTitle, InfoMessages.metalMessage);
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.delete, size: 50.0),
                    //   onPressed: () {
                    //     _showInfoDialog(context, InfoMessages.basuraTitle, InfoMessages.basuraMessage);
                    //   },
                    // ),
                    IconButton(
                      icon: Icon(Icons.description, size: 50.0),
                      onPressed: () {
                        _showInfoDialog(context, InfoMessages.papelTitle, InfoMessages.papelDescription);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
