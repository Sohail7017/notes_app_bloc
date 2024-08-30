
import 'package:flutter/material.dart';
import 'package:note_app_bloc/data_base/notes_db.dart';
import 'package:note_app_bloc/screens/home_page.dart';
import 'package:note_app_bloc/screens/sign_up_page.dart';

class LoginPage extends  StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  bool? isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white,Colors.deepPurple.shade100,Colors.deepPurple.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                ),
                Center(child: Icon(Icons.edit_note_sharp,size: 50,color: Colors.deepPurple,)),
                Center(child: Text('Notes App',style: TextStyle(fontSize: 30,color: Colors.deepPurple,fontWeight: FontWeight.bold),)),
                Text('Please enter your details to Sign in.',style: TextStyle(fontSize: 18,color: Colors.deepPurple.shade300,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 50,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          )

                      ),
                      child: IconButton(onPressed: (){}, icon: Image.asset("assets/icons/apple.png",color: Colors.black,width: 40,height: 40,)),
                    ),
                    Container(
                      width: 100,
                      height: 50,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          )

                      ),
                      child: IconButton(onPressed: (){}, icon: Image.asset("assets/icons/google.png",width: 40,height: 40,)),
                    ),
                    Container(
                      width: 100,
                      height: 50,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          )

                      ),
                      child: IconButton(onPressed: (){}, icon: Image.asset("assets/icons/twiter.png",width: 40,height: 40,)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('OR',style: TextStyle(fontSize: 25,color: Colors.black54),),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                      label: Text('Enter your mailId...'),
                      labelStyle: TextStyle(fontSize: 14),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.purpleAccent,
                            width: 2,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black45,width: 2)
                      )
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration:  InputDecoration(

                      label: Text('Enter your password..'),
                      helperStyle: TextStyle(fontSize: 15,color: Colors.black87),
                      suffixIcon: Icon(Icons.visibility,size: 20,),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2,color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,color: Colors.purpleAccent.shade100),
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(value: isCheck,
                      activeColor: Colors.deepPurple,
                      tristate: false,
                      onChanged: (newBool){
                        setState(() {
                          isCheck = newBool;
                        });
                      },),
                    Text('Remember Me ',style: TextStyle(fontSize: 17,color: Colors.black,),),
                    SizedBox(
                      width: 60,
                    ),
                    Text('Forget Password?',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w500,decoration: TextDecoration.underline,
                        decorationColor: Colors.black,decorationThickness: 1.5,decorationStyle: TextDecorationStyle.solid),),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                ElevatedButton(onPressed: () async{
                  var db = NotesDb.getInstance;
                  var check = await db.userLogin(mailController.text.toString(), passController.text.toString());

                  if(check){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username/password!!'),

                      ));
                  }

                    },
                  child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign in',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                ),
                SizedBox(
                  height: 20,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account yet? ",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400)),
                    InkWell(
                        onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                        child: Text("Sign up",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)))
                  ],
                )


              ],
            ),
          ),
        )
    );
  }
}