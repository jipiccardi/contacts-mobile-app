import 'package:flutter/material.dart';
import 'package:contacts_app/domain/models/contact.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.contact,
    required this.onTap,
  });

  final Contact contact;
  final Function? onTap;

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: const Icon(Icons.person, size: 50),
      title: Text('${contact.name} ${contact.lastname ?? ''}', style: const TextStyle(fontSize: 20)),
      onTap: () => onTap?.call(),
    );
  }
}