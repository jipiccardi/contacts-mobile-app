import 'package:contacts_app/presentation/screens/contact_detail_screen.dart';
import 'package:contacts_app/presentation/screens/edit_contact_screen.dart';
import 'package:contacts_app/presentation/screens/new_contact_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/presentation/screens/home_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    name: HomeScreen.name,
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    name: NewContactScreen.name,
    path: '/new-contact',
    builder: (context, state) => const NewContactScreen(),
  ),
  GoRoute(
      name: ContactDetailScreen.name,
      path: '/contact_details/:contactId',
      builder: (context, state) {
        final contactId = state.pathParameters['contactId'];
        return ContactDetailScreen(
          contactId: int.tryParse(contactId.toString()) ?? -1,
        );
      }),
  GoRoute(
      name: EditContactScreen.name,
      path: '/edit-contact/:contactId',
      builder: (context, state) {
        final contactId = state.pathParameters['contactId'];
        return EditContactScreen(
          contactId: int.tryParse(contactId.toString()) ?? -1,
        );
      })
]);
