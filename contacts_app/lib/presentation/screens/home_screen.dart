import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:contacts_app/presentation/screens/contact_detail_screen.dart';
import 'package:contacts_app/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/presentation/widgets/contact_item.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  final _scafoldKey = GlobalKey<ScaffoldState>();


  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scafoldKey.currentState!.openDrawer(); // Open the drawer using the key
            },
            icon: const Icon(Icons.menu)),
        title: const Text('Contacts'),
      ),
      body: const _HomeView(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            const DrawerHeader(
              child:  Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap:() {
                Navigator.pop(context);
                // context.push
              },
            )
          ],
        ),
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
  Future<List<Contact>>? contactsFuture;

  final ContactsRepository _repository = LocalContactsRepository();

  @override
  void initState() {
    super.initState();
    contactsFuture = _repository.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: contactsFuture,
          builder: (context, snapshot) {
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
                  onTap: () async {
                    await context.pushNamed(ContactDetailScreen.name,
                        pathParameters: {'contactId': contact.id.toString()});
                    setState(() {
                      contactsFuture = _repository.getContacts();
                    });
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await context.pushNamed(NewContactScreen.name);
            if (result == true) {
              setState(() {
                contactsFuture = _repository.getContacts();
              });
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
