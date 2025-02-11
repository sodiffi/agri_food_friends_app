import 'package:agri_food_freind/myData.dart';
import 'package:agri_food_freind/request/user/account.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String account = "";
  String psw = "";
  TextEditingController accountC = TextEditingController();
  TextEditingController pswC = TextEditingController();

  TextField te(TextEditingController t) {
    return (TextField(
      controller: t,
      cursorColor: MyTheme.color,
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 25 * 4),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: MyTheme.color,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: MyTheme.color,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color.fromRGBO(10, 112, 41, 1),
            width: 2.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
    ));
  }

  Widget button_custom(String s, Function f) {
    return (TextButton(
      style: TextButton.styleFrom(
          backgroundColor: MyTheme.color, foregroundColor: Colors.white),
      onPressed: () {
        f.call();
      },
      child: Text(s),
    ));
  }

  var accountRepo = AccountRepo();

  @override
  Widget build(BuildContext context) {
    TextField accountField = te(accountC);

    TextField passwordField = te(pswC);

    SharedPreferences prefs;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyTheme.lightColor,
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png",
                width: 300,
                height: 300,
              ),
              Row(
                children: [Image.asset("assets/icons/tomato.png"), Text("帳號")],
              ),
              accountField,
              Row(
                children: [Image.asset("assets/icons/tomato.png"), Text("密碼")],
              ),
              passwordField,
              button_custom("登入", () async {
                var a = await accountRepo.login(accountC.text, pswC.text);
                if (a == "gogo") {
                  prefs = await SharedPreferences.getInstance();
                  prefs.setString(Name.userName, accountC.text);
                  Navigator.pushReplacementNamed(context, "home");
                } else {
                  print(a);
                }
              }),
              button_custom("Ｇoogle 登入",
                  () => Navigator.pushReplacementNamed(context, "home")),
            ],
          ),
        )),
      ),
    );
  }
}
