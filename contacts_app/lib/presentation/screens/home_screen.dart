import 'package:contacts_app/data/local_contacts_repository.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';
import 'package:contacts_app/main.dart';
import 'package:contacts_app/presentation/screens/contact_detail_screen.dart';
import 'package:contacts_app/presentation/screens/login_screen.dart';
import 'package:contacts_app/presentation/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/presentation/widgets/contact_item.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              _scafoldKey.currentState!
                  .openDrawer(); 
            },
            icon: const Icon(Icons.menu)),
        title: const Text('Contacts'),
      ),
      body: const _HomeView(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                   const Text('Menu',style: TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(height: 20), 
                   Text('Hi, $sessionUsername!',style: const TextStyle(fontSize: 18),)
                  ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // context.push
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _logout();
                context.pushReplacementNamed(LoginScreen.name);
              },
            )
          ],
        ),
      ),
    );
  }

  _logout() async {
    sessionUserId = '';
    sessionUsername = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
    contactsFuture = _repository.getContactsByUserId(int.tryParse(sessionUserId) ?? -1);
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
                      contactsFuture = _repository.getContactsByUserId(int.tryParse(sessionUserId) ?? -1);
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
                contactsFuture = _repository.getContactsByUserId(int.tryParse(sessionUserId) ?? -1);
              });
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
