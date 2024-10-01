import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';


class NewContactScreen extends StatelessWidget {
  static const name = 'new_contact_screen';

  const NewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('New Contact'),
      ),
      body: const _NewContactView(),
    );
  }
}

class _NewContactView extends StatefulWidget {
  const _NewContactView();

  @override
  State<_NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<_NewContactView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ContactsRepository _repository = LocalContactsRepository();

  String name = '';
  String lastname = '';
  String phoneNumber = '';
  String email = '';
  String notes = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Name')
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Must enter contact name';
              }
              return null;
            },
            onSaved: (value) {
              name = value!;
            },
          ),
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Lastname')
            ),
            onSaved: (value) {
              lastname = value!;
            },
          ),
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Phone Number')
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Must enter contact number';
              }
              return null;
            },
            onSaved: (value) {
              phoneNumber = value!;
            },
          ),
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Email')
            ),
            onSaved: (value) {
              email = value!;
            },
          ),
            TextFormField(
            decoration: const InputDecoration(
              label: Text('Notes')
            ),
            onSaved: (value) {
              notes = value!;
            },
          ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            setState(() {
              //database.contactDao.insertContact(Contact(name: name, phoneNumber: phoneNumber, userId: 1));
              _repository.insertContact(Contact(name: name, phoneNumber: phoneNumber, userId: 1));
            });
            _formKey.currentState!.reset();
            context.pop(true);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}