import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeUsersList extends StatefulWidget {
  const RealtimeUsersList({super.key});

  @override
  _RealtimeUsersListState createState() => _RealtimeUsersListState();
}

class _RealtimeUsersListState extends State<RealtimeUsersList> {
  List<UserModel> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _subscribeToChanges();
  }

  Future<void> _fetchUsers() async {
    final data = await Supabase.instance.client.from('users').select();
    setState(() {
      _users = (data as List).map((e) => UserModel.fromMap(e)).toList();
    });
  }
  

  void _subscribeToChanges() {
    Supabase.instance.client
        .channel('public:users')
        .on(
          RealtimeListenTypes.postgresChanges,
          ChannelFilter(event: '*', schema: 'public', table: 'users'),
          (payload, [ref]) {
            final String event = payload['eventType'];
            final newData = payload['new'];
            final oldData = payload['old'];
            setState(() {
              if (event == 'INSERT') {
                _users.add(UserModel.fromMap(newData));
              } else if (event == 'UPDATE') {
                final index = _users.indexWhere((u) => u.id == newData['id']);
                if (index != -1) {
                  _users[index] = UserModel.fromMap(newData);
                }
              } else if (event == 'DELETE') {
                _users.removeWhere((u) => u.id == oldData['id']);
              }
            });
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    Supabase.instance.client.removeAllChannels();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Realtime ListView')),
      body: _users.isEmpty
          ? Center(child: Text('No users found'))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
    );
  }
}



class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}
