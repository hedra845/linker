import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linker/generated/l10n.dart';
import 'package:linker/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // The screen to navigate after login

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;
  bool showPassword = true;

  @override
  /*************  ✨ Codeium Command ⭐  *************/
  /// This function is supposed to be used to show the password when the user
  /// long presses on the "Show Password" button.
  ///
  /// However, this function is currently not used anywhere in the codebase.
  Future<void> shooow() async {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Future<void> signup() async {
    try {
      final response = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        emailRedirectTo: nameController.text,
      );

      if (response.user != null) {
         ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Color(0xff3461FD),content: Text('check your email and confirm it',style: TextStyle(color: Colors.white),)));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Color(0xff3461FD),content: Text('Invalid login credentials',style: TextStyle(color: Colors.white,),)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(backgroundColor: Color(0xff3461FD),content: Text('Error: ${e.toString()}',style: TextStyle(color: Colors.white,))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(S.of(context).title, style: TextStyle(color: Color(0xff3461FD))),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/Group.png', width: 150, height: 50),
              const SizedBox(height: 20),
              Text(
                'Linker Save List is a service that allows you to easily save, manage, and organize link lists for quick access anytime. ',
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Color.fromARGB(255, 132, 155, 238),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                cursorColor: Color(0xff3461FD),
                decoration: InputDecoration(
                  fillColor: Color(0xffF5F9FE),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff3461FD)),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Color(0xff3461FD)),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                cursorColor: Color(0xff3461FD),
                decoration: InputDecoration(
                  fillColor: Color(0xffF5F9FE),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff3461FD)),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xff3461FD)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                cursorColor: Color(0xff3461FD),
                decoration: InputDecoration(
                  fillColor: Color(0xffF5F9FE),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff3461FD)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        shooow();
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xff3461FD),
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff3461FD)),
                ),
                obscureText: showPassword,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: repasswordController,
                cursorColor: Color(0xff3461FD),
                decoration: InputDecoration(
                  fillColor: Color(0xffF5F9FE),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF5F9FE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xff3461FD)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        shooow();
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xff3461FD),
                    ),
                  ),
                  labelText: 'RePassword',
                  labelStyle: TextStyle(color: Color(0xff3461FD)),
                ),
                obscureText: showPassword,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (passwordController.text ==repasswordController.text) {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('name', nameController.text);
                          signup();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Color(0xff3461FD),content: Text('Passwords do not match',style: TextStyle(color: Colors.white),)),
                          );
                        }
                      },
                      style: ButtonStyle(
                        shadowColor: WidgetStateProperty.all<Color>(
                          Color(0xff3461FD),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xff3461FD),
                        ),
                      ),
                      child: const Text(
                        'sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'login',
                      style: TextStyle(color: Color(0xff3461FD)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
