import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';

class NewContactScreen extends StatelessWidget {
  static const name = 'new_contact_screen';

  const NewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: _NewContactView(),
    );
  }
}

class _NewContactView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ContactsRepository _repository = LocalContactsRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _repository.insertContact(Contact(
                name: nameController.text,
                lastname: lastnameController.text,
                phoneNumber: phoneController.text,
                email: emailController.text,
                notes: notesController.text,
                userId: 1));
            if (context.mounted) context.pop(true);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
