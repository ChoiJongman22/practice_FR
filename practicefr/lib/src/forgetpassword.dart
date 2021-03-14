import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget{
  @override
  _ForgetPw createState() => _ForgetPw();
}

class _ForgetPw extends State<ForgetPw>{
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("비밀번호를 잊음.")
      ),
      body: Form(
        key:_formKey,
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
            TextButton(onPressed: () async {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
              final snacBar = SnackBar(content: Text("이메을을 확인해주세요.."));
              ScaffoldMessenger.of(_formKey.currentContext).showSnackBar(snacBar);

            },
            child:Text('비밀번호 재설정'))
          ],
        ),
      ),
    );
  }
  
}