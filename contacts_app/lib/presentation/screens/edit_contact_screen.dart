import 'package:contacts_app/domain/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({super.key, required this.contactId});

  static const name = 'edit_contact_screen';
  final int contactId;

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  Future<Contact>? futureContact;

  final ContactsRepository _repository = LocalContactsRepository();

  @override
  void initState() {
    super.initState();
    futureContact = _repository.getById(widget.contactId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Object>(
            future: futureContact,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final contact = snapshot.data as Contact;
              return _EditContactView(contact: contact);
            }));
  }
}

class _EditContactView extends StatefulWidget {
  const _EditContactView({required this.contact});

  final Contact contact;

  @override
  State<_EditContactView> createState() => _EditContactViewState();
}

class _EditContactViewState extends State<_EditContactView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ContactsRepository _repository = LocalContactsRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.contact.name.toString();
    lastnameController.text = widget.contact.lastname ?? '';
    phoneController.text = widget.contact.phoneNumber.toString();
    emailController.text = widget.contact.email ?? '';
    notesController.text = widget.contact.notes ?? '';
    _selectedImage =
        widget.contact.img != null && widget.contact.img!.isNotEmpty
            ? File(widget.contact.img!)
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Changes'),
                    content: const Text('Do you want to save changes?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'cancel');
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'save');
                          },
                          child: const Text("Yes")),
                    ],
                  );
                },
              );
              if (result == 'save') {
                if (_formKey.currentState!.validate()) {
                  await _repository.updateContact(Contact(
                      id: widget.contact.id,
                      name: nameController.text,
                      lastname: lastnameController.text,
                      phoneNumber: phoneController.text,
                      email: emailController.text,
                      notes: notesController.text,
                      img: _selectedImage?.path,
                      userId: widget.contact.userId));
                  if (context.mounted) context.pop('updated');
                }
              }
            },
          )
        ],
      ),
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
                child: const Text('Edit'),
                onPressed: () {
                  _pickImageFromGallery();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(
                  label: const Text('Lastname'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
                  FilteringTextInputFormatter.digitsOnly, // Only allows digits
                ],
                decoration: InputDecoration(
                  label: const Text('Phone Number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Phone number cannot be empty';
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
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
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
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Deletion'),
                content: const Text(
                    'Are you sure you want to permanently remove this contact?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'yes');
                      },
                      child: const Text("Yes")),
                ],
              );
            },
          );
          if (result == 'yes') {
            await _repository.deleteContact(widget.contact);
            if (context.mounted) context.pop('deleted');
          }
        },
        child: const Icon(Icons.delete),
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
