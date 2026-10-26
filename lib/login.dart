import 'package:flutter/material.dart';
import 'package:linker/generated/l10n.dart';
import 'package:linker/home.dart';
import 'package:linker/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // The screen to navigate after login

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  Future<void> login() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid login credentials')),
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: login,
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
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Color(0xff3461FD)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
