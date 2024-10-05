import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewContactScreen extends StatelessWidget {
  const NewContactScreen({super.key});

  static const name = 'new_contact_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: const _NewContactView(),
    );
  }
}

class _NewContactView extends StatefulWidget {
  const _NewContactView();

  @override
  State<_NewContactView> createState() => _NewContactState();
}

class _NewContactState extends State<_NewContactView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ContactsRepository _repository = LocalContactsRepository();

  File? _selectedImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage('assets/images/default_user.png')
                          as ImageProvider,
                ),
                TextButton(
                  child: const Text('Add Image'),
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    label: const Text('Name'),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Must enter contact name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: lastnameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    label: const Text('Lastname'),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .digitsOnly, // Only allows digits
                  ],
                  decoration: InputDecoration(
                    label: const Text('Phone Number'),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Must enter contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: notesController,
                  decoration: InputDecoration(
                    label: const Text('Notes'),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _repository.insertContact(Contact(
                name: nameController.text,
                lastname: lastnameController.text,
                phoneNumber: phoneController.text,
                email: emailController.text,
                notes: notesController.text,
                img: _selectedImage?.path,
                userId: 1));
            if (context.mounted) context.pop(true);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _selectedImage = File(image.path);
    });
  }
}
