import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HomeBase{

 String signin = "https://api.example.com/signin";
 String signup = "https://api.example.com/signup";

void signUp(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse(signup),
    headers: {
      "Content-Type" : "application/json"
    },
    body: jsonEncode({
      'name' : name,
      'email' : email,
      'password' : password,
    }),
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    log(data);
  } else {
    throw Exception("SignUp failed");
  
  }
}


void signIn(String email, String password) async {
  final response = await http.post(
    Uri.parse(signin),
    headers: {
      "Content-Type" : "application/json"
    },
    body: jsonEncode({
      'email' : email,
      'password' : password,
    },
    ),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body.toString());
    log(data);
  } else {
    throw Exception("SignIn Failed");
  }
}

 
}