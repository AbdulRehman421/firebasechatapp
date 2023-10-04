import 'package:chatapp/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EditProfile.dart';
class AccountScreen extends StatefulWidget {
  final UserModel userModel;
   const AccountScreen({super.key, required this.userModel});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }
String name = "";
String email = "";
String profileImg = "";
  void _fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      setState(() {
        name = userDoc['name'];
        email = userDoc['email'];
        profileImg = userDoc['profileImageUrl'];

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text('User Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(userModel: widget.userModel),
              ));
            },
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            _fetchUserData();
          });

        },
        child: ListView(
            children: [
          Center(
            child: Container(

              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(profileImg),
                      radius: 70,
                    ),
                    SizedBox(height: 20,),
                    Text('Name : ${name}' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    SizedBox(height: 20,),
                    Text('Email : ${email}' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), ),
                    SizedBox(height: 20,),

                    Text('User Id : ${widget.userModel.uid.toString()}' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
