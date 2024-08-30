import 'package:flutter/material.dart';
import 'package:note_app_bloc/data_base/notes_db.dart';
import 'package:note_app_bloc/data_base/user_model.dart';
import 'package:note_app_bloc/screens/login_page.dart';

class SignUpPage extends StatelessWidget{
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note_sharp,size: 70,color: Colors.deepPurple,),
                  Text('Notes app',style: TextStyle(fontSize: 28,color: Colors.deepPurple,fontWeight: FontWeight.bold),),

                ],
              ),
              Center(child: Text("Now let's make you a Notes App member",style: TextStyle(fontSize: 18,color: Colors.deepPurple.shade300,fontWeight: FontWeight.bold),)),



              SizedBox(
                height: 50,
              ),

              Container(

                height: 55,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    labelStyle: TextStyle(fontSize: 15,color: Colors.deepPurple.shade300,fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                child: TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail,size: 25,color: Colors.deepPurple.shade300,),
                    label: Text('Enter your mail'),
                    labelStyle: TextStyle(fontSize: 15,color: Colors.deepPurple.shade300,fontWeight: FontWeight.w600),
                    suffixText: '@gmail.com',
                    suffixStyle: TextStyle(fontSize: 15,color: Colors.deepPurple.shade300,fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password,size: 25,color: Colors.deepPurple.shade300,),
                    label: Text('Password'),
                    labelStyle: TextStyle(fontSize: 15,color: Colors.deepPurple.shade300,fontWeight: FontWeight.w600),
                    suffixIcon: Icon(Icons.visibility,size: 20,color: Colors.red,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'X  ',style: TextStyle(fontSize: 15,color: Colors.black45,fontWeight: FontWeight.w600)),
                    TextSpan(text: 'Minimum of 8 Characters',style: TextStyle(fontSize: 15,color: Colors.black45,fontWeight: FontWeight.w600)),
                  ]
              )),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'X  ',style: TextStyle(fontSize: 15,color: Colors.black45,fontWeight: FontWeight.w600)),
                    TextSpan(text: 'Uppercase, Lowercase letters, and one number',style: TextStyle(fontSize: 15,color: Colors.black45,fontWeight: FontWeight.w600)),
                  ]
              )),
              SizedBox(
                height: 20,
              ),
              Container(

                height: 2,
                color: Colors.black38,
              ),

              SizedBox(
                height: 25,
              ),
              Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () async{
                    var db = NotesDb.getInstance;
                    var check = await db.addUser(UserModel(u_id: 0,
                        name: nameController.text.toString(),
                        email: mailController.text.toString(),
                        pass: passController.text.toString()));

                    if(check){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already registered!!'),
                        action: SnackBarAction(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

                          },
                          label: "Login Now",
                      ),));
                    }

                  }, child: Text('Sign Up',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),)),

              Center(child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }, child: Text('Already have an account',style: TextStyle(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.bold),)))



            ],
          ),
        ),
      ),
    );
  }
}