import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Puedes cargar los datos del usuario actual aquí
    // Ejemplo:
    // _usernameController.text = 'John Doe';
    // _emailController.text = 'john.doe@example.com';
    // _ageController.text = '30';
    // _imageUrlController.text = 'https://example.com/profile.jpg';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí debes guardar los cambios en la base de datos
                    // Ejemplo:
                    // FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                    //   'username': _usernameController.text,
                    //   'email': _emailController.text,
                    //   'age': int.parse(_ageController.text),
                    //   'imageUrl': _imageUrlController.text,
                    // });
                    Navigator.pop(context, {
                      'username': _usernameController.text,
                      'email': _emailController.text,
                      'age': int.parse(_ageController.text),
                      'imageUrl': _imageUrlController.text,
                    });
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}