import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/presentation/screens/edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:go_router/go_router.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({super.key, required this.contactId});

  static const name = 'contact_detail_screen';
  final int contactId;

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
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
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final result = await context.pushNamed(EditContactScreen.name,
                  pathParameters: {'contactId': widget.contactId.toString()});
              if (result == 'deleted') {
                if (context.mounted) context.pop();
              }
              if (result == 'updated') {
                setState(() {
                  futureContact = _repository.getById(widget.contactId);
                });
              }
            },
          )
        ],
      ),
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
            return _ContactDetailView(contact: contact);
          }),
    );
  }
}

class _ContactDetailView extends StatelessWidget {
  const _ContactDetailView({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/default_user.png'),
            ),
            const SizedBox(height: 15),
            Text(
              '${contact.name} ${contact.lastname ?? ''}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Mobile'),
              subtitle: Text(
                contact.phoneNumber,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(
                contact.email ?? '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notes',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    readOnly: true,
                    initialValue: contact.notes ?? '',
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
