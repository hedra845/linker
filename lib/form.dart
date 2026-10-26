import 'package:flutter/material.dart';
import 'package:linker/test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
late Future<List<UserModel>> _futureUsers;
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();

      final response = await Supabase.instance.client
          .from('users') // 👈 Your table name
          .insert({'name': name, 'email': email});

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data inserted successfully')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.error!.message}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUsers();
  }

Future<List<UserModel>> fetchUsers() async {
  final response = await Supabase.instance.client
      .from('users')
      .select()
      .order('id', ascending: true);

  final data = response;
  return (data as List).map((item) => UserModel.fromMap(item)).toList();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit to Supabase')),
      body: RefreshIndicator(
        onRefresh: () => fetchUsers(),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value == null || !value.contains('@') ? 'Enter valid email' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
                SizedBox(
                  height: 200,
                  child: FutureBuilder<List<UserModel>>(
                          future: _futureUsers,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                  
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                  
                            final users = snapshot.data!;
                            if (users.isEmpty) return Center(child: Text('No users found.'));
                  
                            return ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                              },
                            );
                          },
                        ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RealtimeUsersList()));
                }, child: Text("data"))
              ],
            ),
          ),
        ),
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
