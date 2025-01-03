import 'package:elo_clone/views/mainPage.dart';
import 'package:elo_clone/views/productListPage.dart';
import 'package:flutter/material.dart';
import 'package:elo_clone/controllers/apiProductController.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginView extends StatefulWidget {
  loginView({super.key, required this.cart });
  final FlutterCart cart;
  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final apiProductController apiController = Get.find();
  bool isLoading = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try{
        bool responseCode =  await apiController.loginUser(usernameController.text, passwordController.text);
        if (responseCode){
          final userDetails = await apiController.getUserDetails(usernameController.text, passwordController.text);
          if(userDetails != null){
            Get.snackbar(
              'Login Successful',
              'Welcome, ${userDetails['firstname']} ${userDetails['lastname']} ',
            );
            Get.offAll( (() => MainPage(cart: widget.cart)));
          }
        }
      }
      finally{
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
                child: Image.asset('assets/background-img.jpg',
                fit: BoxFit.cover,),

            ),
         Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    children: [
                      SizedBox(height: 80,),
                      Text('Welcome back!',
                      style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 50,),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        icon: Icon(Icons.person), iconColor: Theme.of(context).colorScheme.secondary),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        icon: Icon(Icons.lock),
                        iconColor: Theme.of(context).colorScheme.secondary),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: login,
                        child: Text(
                          'Login',
                        ),
                      ),
                      SizedBox(height: 5,),
                    ]
                )
            )
        ),
            if(isLoading)
              Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              )
    ]
    )
    );
  }
}
