import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/screens/login_screen.dart';
import 'package:pokemon/widgets/button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  bool obscuree = false;
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
                  'assets/animations/lottie2.json',
                  height: 250,
                ),
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(249, 241, 30, 1),
                ),
              ),
              Text(
                'Enter valid email & password',
                style: TextStyle(color: const Color(0xFFD9F314), fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: namecontroller,
                  onChanged: (text) {
                    // 3. Call setState to trigger a rebuild
                    setState(() {});
                  },
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hint: Text("Name", style: TextStyle(fontSize: 20)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    prefixIcon: Icon(Icons.person),
                    suffixIcon: namecontroller.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                namecontroller.clear();
                              });
                            },
                            icon: Icon(Icons.close),
                          ),
                  ),
                ),
              ),
              Container(
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
                    hint: Text("Email", style: TextStyle(fontSize: 20)),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: LoadingAnimatedButton(
                    onTap: () {
                      registerUser();
                    },
                    child: Center(
                      child: Text(
                        "Register",
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
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Sign In",
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

  void registerUser() {
    if (passwordcontroller.text == "") {
      Fluttertoast.showToast(
        msg: "Password cannot cannot be blank",
        backgroundColor: Colors.red,
      );
    } else if (emailcontroller.text == "") {
      Fluttertoast.showToast(
        msg: "Email cannot be blank",
        backgroundColor: Colors.red,
      );
    } else if (namecontroller.text == "") {
      Fluttertoast.showToast(
        msg: "Name cannot be blank",
        backgroundColor: Colors.red,
      );
    } else {
      String email = emailcontroller.text;
      String password = passwordcontroller.text;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            if (value != null) {
              var userCredential = value;
              var uid = userCredential.user?.uid;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            }
          })
          .catchError((e) {
            Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
          });
    }
  }
}
