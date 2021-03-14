import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practicefr/data/join_or_login.dart';
import 'package:practicefr/helper/loginBackground.dart';
import 'package:practicefr/src/forgetpassword.dart';
import 'package:practicefr/src/home.dart';
import 'package:practicefr/src/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final emailListA = [
    'whdgjs3131@naver.com',
    'tndks0770@naver.com',
    'heejeong116@naver.com'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          size: size,
          painter:
              LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Consumer<JoinOrLogin>(
              builder: (context, joinOrlogin, child) => GestureDetector(
                  onTap: () {
                    joinOrlogin.toggle();
                  },
                  child: Image.network(joinOrlogin.isJoin
                      ? 'https://liveconnect.co.kr/assets/img/logo.png'
                      : 'https://liveconnect.co.kr/assets/img/logo-dark.png')),
            ),
            Stack(
              children: <Widget>[
                _inputForm(size),
                _loginButton(size, context),
              ],
            ),
            Container(height: 15),
            Consumer<JoinOrLogin>(
              builder: (context, joinOrlogin, child) => GestureDetector(
                  onTap: () {
                    joinOrlogin.toggle();
                  },
                  child: TextButton(
                    child:
                        Text(joinOrlogin.isJoin?"이미 회원이세요? 로그인":"계정생성하세요!", style: TextStyle(color: Colors.black)),
                  )),
            ),
            Container(
              height: size.height * 0.05,
            )
          ],
        ),
      ],
    ));
  }

  //이러면 계정 생성 가능
  void _register(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snacBar = SnackBar(content: Text("다시 입력해주세요."));
      ScaffoldMessenger.of(context).showSnackBar(snacBar);
    }
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => HomePage(email: user.email)));
  }

  void _login(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snacBar = SnackBar(content: Text("다시 입력해주세요."));
      ScaffoldMessenger.of(context).showSnackBar(snacBar);
    }
    else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(email: user.email)));
    }

  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        elevation: 6,
        shadowColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "Email"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "아이디를 입력하세요.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "Password"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "비밀번호를 입력하세요";
                      }
                      return null;
                    },
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, joinOrlogin, child) => Opacity(
                      opacity: joinOrlogin.isJoin ? 0 : 1,
                      child: GestureDetector(
                        onTap: joinOrlogin.isJoin? null: (){
                          goToForgetPw(context);
                        },
                        child: Text(
                          "Forgot Password",
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _loginButton(Size size, BuildContext context) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, joinOrlogin, child) => ElevatedButton(
                child: Text(
                  joinOrlogin.isJoin?'가입하기':'로그인하기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    joinOrlogin.isJoin ? _register(context) : _login(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
          )),
    );
  }
  goToForgetPw(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgetPw()));
  }
}
