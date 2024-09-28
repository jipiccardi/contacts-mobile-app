import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/presentation/widgets/contact_item.dart';

class HomeScreen extends StatelessWidget{
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: const _HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final Future<List<Contact>> contactsFuture;

  final ContactsRepository _repository = LocalContactsRepository();

  @override
  void initState() {
    super.initState();
    contactsFuture = _repository.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: contactsFuture,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final contactList = snapshot.data as List<Contact>;
        return ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            final contact = contactList[index];
            return ContactItem(
              contact: contact,
              onTap: ()=> {},
            );
          },
        );
      },
    );
  }
}