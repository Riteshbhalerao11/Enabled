import 'package:flutter/material.dart';
// import 'package:flutter_contacts/contact.dart';
import 'package:enabled_try_1/features/Auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:enabled_try_1/core/common/widgets/error.dart';
import 'package:enabled_try_1/core/common/widgets/loader.dart';
import 'package:enabled_try_1/features/ChatList/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);

  void selectContact(
      WidgetRef ref, String selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      // body: ref.watch(getContactsProvider).when(
      //       data: (contactList) => ListView.builder(
      //           itemCount: contactList.length,
      //           itemBuilder: (context, index) {
      //             final contact = contactList[index];
      //             return InkWell(
      //               onTap: () => selectContact(ref, contact, context),
      //               child: Padding(
      //                 padding: const EdgeInsets.only(bottom: 8.0),
      //                 child: ListTile(
      //                   title: Text(
      //                     contact,
      //                     style: const TextStyle(
      //                       fontSize: 18,
      //                     ),
      //                   ),
      //                   // leading: contact.photo == null
      //                   //     ? null
      //                   //     : CircleAvatar(
      //                   //         backgroundImage: MemoryImage(contact.photo!),
      //                   //         radius: 30,
      //                   //       ),
      //                 ),
      //               ),
      //             );
      //           }),
      //       error: (err, trace) => ErrorScreen(error: err.toString()),
      //       loading: () => const Loader(),
      //     ),
      body: ref.watch(getContactsProvider).when(
            data: (contactList) => Padding(
              padding: const EdgeInsets.only(top : 8.0 , left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      return ref.watch(getUserDataByName(contactList[index])).when(
                        data: (contact) {
                          return InkWell(
                            onTap: () => selectContact(ref, contact.username, context),
                            child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                contact.username,
                                
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,  
                                  fontFamily: "PTSans",
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            leading: CircleAvatar(
                                    backgroundImage: NetworkImage(contact.profilepic),
                                    radius: 25,
                                  ),
                          ),
                        ),
                      );
                        },
                        error: (err, trace) => ErrorScreen(error: err.toString()),
                        loading: () => const Loader());
                    }
                ),
              ),
            ),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loader())
                  
    );
  }
}