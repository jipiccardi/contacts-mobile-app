import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';

/*

class ContactDetailScreen extends StatefulWidget {
  static const name = 'contact_detail_screen';
  final String contactId;

  const ContactDetailScreen({
    super.key,
    required this.contactId
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late final Future<Contact> futureContact;

  final ContactsRepository _repository = LocalContactsRepository();

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
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




      }),
    );
  }
}

class _ContactDetailView extends StatelessWidget {

}

*/