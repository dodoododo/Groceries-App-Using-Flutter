import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'ProductPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = "";
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(width: double.infinity),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink.withValues(alpha: 0.2),
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset("assets/images/Group.png"),
            ),

            SizedBox(
              height: 40,
            ),

            Container(
              width: 370,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text (
                        "Log in",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Roboto'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text (
                        "Enter your emails and password",
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Roboto'),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 20,
            ),

            buildEmailInput(),


            SizedBox(
              height: 20,
            ),
            buildPassword(),


            SizedBox(
              height: 40,
            ),

            buildLoginButton(),

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Don't Have An Account? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }
  Widget buildEmailInput() => Padding( //username
    padding: const EdgeInsets.all(1),
    child: SizedBox(
      width: 370,
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please input Email";
          }
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },

        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );

  Widget buildPassword() => Padding( //password
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      width: 370,
      height: 50,
      child: TextFormField(
        onChanged: (value) => setState(() {
          password = value;
        }),
        onFieldSubmitted: (value) => setState(() {
          password = value;
        }),
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
        decoration: InputDecoration(
          suffixIcon: Container(
            margin: EdgeInsets.only(
              right: 3,
            ),
            child: IconButton(icon:
            isPasswordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                onPressed: () => {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  }),
                }
            ),
          ),
        ),
        obscureText: isPasswordVisible,
      ),
    ),
  );

  Widget buildLoginButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(370, 55),
      backgroundColor: Colors.green,   // button color
      foregroundColor: Colors.white,  // text color
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (ProductPage())),
      );
    },
    child: Text("Log In", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Roboto')),
  );
}