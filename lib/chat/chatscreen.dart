import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_an_apartement/chat/chatroom.dart';

class UserListPage extends StatefulWidget {
final int notificationCount;
  final Function resetNotificationCount;

  const UserListPage({
    Key? key,
    required this.notificationCount,
    required this.resetNotificationCount,
  }) : super(key: key);
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String _currentUserId;

  List<QueryDocumentSnapshot> _users = [];
  List<QueryDocumentSnapshot> _filteredUsers = [];

  String _searchQuery = '';

  void dispose() {
    // Call the resetNotificationCount function before disposing the UserListPage
    widget.resetNotificationCount();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentUserId = _auth.currentUser!.uid;
    _loadUsers();
  }

  void _loadUsers() async {
    QuerySnapshot querySnapshot = await _db.collection('user_profile').get();
    setState(() {
      _users = querySnapshot.docs;
      _filteredUsers = _users;
    });
  }

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty) {
        _filteredUsers = _users
            .where((user) =>
                user['ownername'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredUsers = _users;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Chat List'),
      ),
      body: _filteredUsers.isEmpty
          ? const Center(
              child: Text(
                'No users found.',
                style: TextStyle(fontSize: 14),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 17),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search users by name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) => _filterUsers(value),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      String userId = _filteredUsers[index].id;

                      if (userId == _currentUserId) {
                        return Container(); // don't show current user in the list
                      }

                      String chatRoomId;
                      if (_currentUserId.compareTo(userId) == 1) {
                        chatRoomId = '$_currentUserId-$userId';
                      } else {
                        chatRoomId = '$userId-$_currentUserId';
                      }

                      return StreamBuilder<QuerySnapshot>(
                        stream: _db
                            .collection('chat_rooms')
                            .doc(chatRoomId)
                            .collection('messages')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            final hasMessages = snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty;
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 5),
                              child: Container(
                                // height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  title:
                                      Text(_filteredUsers[index]['ownername']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatRoom(
                                          recipientId: userId,
                                          data: _filteredUsers[index],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.purple,
                                    child: Text(
                                      _filteredUsers[index]['ownername'][0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight
                                            .bold, // set the text color to blue
                                      ),
                                    ),
                                  ),
                                  trailing: hasMessages
                                      ? const Icon(Icons.mark_chat_read)
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            );
                          } else {
                            return Container(); // don't show users with no chat room
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
