import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phoneNumber;
  final String avatar;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.avatar,
  });
}

class ContactListScreen extends StatelessWidget {
  ContactListScreen({Key? key}) : super(key: key);

  final List<MapEntry<String, List<Contact>>> contacts = [
    MapEntry('A', [
      Contact(name: 'Alex Smith', phoneNumber: '(+1) 555-0123', avatar: 'A'),
      Contact(name: 'Anna Parker', phoneNumber: '(+1) 555-0124', avatar: 'A'),
      Contact(name: 'Andrew Wilson', phoneNumber: '(+1) 555-0125', avatar: 'A'),
    ]),
    MapEntry('B', [
      Contact(name: 'Brian Johnson', phoneNumber: '(+1) 555-0126', avatar: 'B'),
      Contact(name: 'Benjamin Davis', phoneNumber: '(+1) 555-0127', avatar: 'B'),
    ]),
    MapEntry('C', [
      Contact(name: 'Catherine Lee', phoneNumber: '(+1) 555-0128', avatar: 'C'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Chọn liên hệ muốn chuyển',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),

            // Contact List
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, sectionIndex) {
                  final section = contacts[sectionIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey[50],
                        child: Text(
                          section.key,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Contact Items
                      ...section.value.map((contact) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(
                            contact.avatar,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        title: Text(
                          contact.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          contact.phoneNumber,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}