//============================================================================
// 1) IMPORT
//============================================================================
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//============================================================================
// 2) VOID MAIN
//============================================================================
void main() =>  runApp(MyApp());

//============================================================================
// 3) MY APP
//============================================================================
class MyApp extends StatefulWidget {
@override
    State<StatefulWidget> createState(){
    return _MyAppState();
  }}


//============================================================================
// 4) GET UI
//============================================================================
class _MyAppState extends State<MyApp> {
    //============================================================================
    // SET VARIABLE
    //============================================================================
    bool _isLoggedIn = false;
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    //============================================================================
    // FUNCTION: LOGIN
    //============================================================================    
    _login() async {
      try {
        await _googleSignIn.signIn();
        setState((){_isLoggedIn = true;});
      }
      catch(err){print(err);}
      }
    //============================================================================
    // FUNCTION: LOGOUT
    //============================================================================      
    _logout() {
      _googleSignIn.signOut();
      setState((){_isLoggedIn = false;}
    );
  }
  //============================================================================
  // CREATE UI
  //============================================================================  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: _isLoggedIn ? Column(
        //============================================================================
        // IF LOGIN OK
        //============================================================================          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //============================================================================
            // SHOW PICTURE, DISPLAY NAME, EMAIL
            //============================================================================               
            Image.network(_googleSignIn.currentUser.photoUrl,height: 50.0,width:50.0,),
            Text(_googleSignIn.currentUser.displayName),
            Text(_googleSignIn.currentUser.email),            
            OutlineButton(child: Text("Logout"),onPressed: () {_logout();},
            ),
          ],
        )
        //============================================================================
        // 2) IF NOT LOGIN
        //============================================================================        
        : OutlineButton(child: Text("Login with Google"),onPressed: () { _login();},
        ),
        ),
      ),
        ); 
  }}