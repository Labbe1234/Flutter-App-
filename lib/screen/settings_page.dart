import 'package:flutter/material.dart';
import 'package:testapp/screen/home_page.dart';
import 'package:testapp/screen/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  final String supportPhoneNumber = '+56993948960';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Profile'),
            children: [
              ListTile(
                title: Text('View Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(
                      username: 'John Doe', // Replace with actual data
                      email: 'john.doe@example.com', // Replace with actual data
                      age: 30, // Replace with actual data
                      imageUrl: 'https://example.com/profile.jpg', // Replace with actual data
                    )),
                  );  
                },
              ),
              ListTile(
                title: Text('Edit Profile'),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  if (result != null) {
                    // Handle the edited profile data
                    print(result);
                  }
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Phone'),
            children: [
              ListTile(
                title: Text('Support Number: $supportPhoneNumber'),
                onTap: () {
                  _launchPhoneApp(supportPhoneNumber);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Alert'),
            children: [
              ListTile(
                title: Text('Report Problems'),
                onTap: () {
                  _showReportDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to launch phone app
  _launchPhoneApp(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to show report dialog
  void _showReportDialog(BuildContext context) {
    final _problemTypeController = TextEditingController();
    final _problemDescriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report a Problem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _problemTypeController,
                decoration: InputDecoration(labelText: 'Problem Type'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _problemDescriptionController,
                decoration: InputDecoration(labelText: 'Problem Description'),
                maxLines: null,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showThankYouDialog(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  // Function to show thank you dialog
  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: Text('Thank you for cooperating with us.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
