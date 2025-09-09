import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/screens/home_screen.dart';
import 'package:pokemon/screens/registration_screen.dart';
import 'package:pokemon/widgets/button.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscuree = true;
  Icon icon = Icon(Icons.remove_red_eye);
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 135, 153),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Lottie.asset(
                  'assets/animations/lottie1.json',
                  height: 250,
                ),
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(249, 241, 30, 1),
                ),
              ),
              Text(
                'Enter valid Email & Password',
                style: TextStyle(color: const Color(0xFFD9F314), fontSize: 20),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailcontroller,
                  onChanged: (text) {
                    // 3. Call setState to trigger a rebuild
                    setState(() {});
                  },
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hint: Text("Emails", style: TextStyle(fontSize: 20)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    prefixIcon: Icon(Icons.email),
                    suffixIcon: emailcontroller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                emailcontroller.clear();
                              });
                            },
                            icon: Icon(Icons.close),
                          ),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: obscuree,
                  style: TextStyle(fontSize: 20),

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hint: Text("Password", style: TextStyle(fontSize: 20)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: GestureDetector(
                      onTapUp: (details) {
                        setState(() {
                          obscuree = true;
                          icon = Icon(Icons.visibility);
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          obscuree = false;
                          icon = Icon(Icons.visibility_off);
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          obscuree = false;
                          icon = Icon(Icons.visibility_off);
                        });
                      },
                      child: icon,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: LoadingAnimatedButton(
                    onTap: () {
                      loginuser(context);
                    },
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        SizedBox(width: 10),
                        Text("Sign in with Google"),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign UP",
                        style: TextStyle(
                          color: const Color.fromRGBO(249, 241, 30, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginuser(BuildContext context) {
    if (passwordcontroller.text == '') {
      Fluttertoast.showToast(
        msg: "Password can't be empity",
        backgroundColor: Colors.red,
      );
    } else {
      String email = emailcontroller.text;
      String password = passwordcontroller.text;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((Value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          });
    }
  }
}
