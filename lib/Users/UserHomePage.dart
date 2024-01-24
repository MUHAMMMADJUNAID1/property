import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property/Models/FirebaseUserModel.dart';
import 'package:property/Users/UserAddPost.dart';
import 'package:property/Users/UserHomeBody.dart';
import 'package:property/Users/UserNotification.dart';
import 'package:property/Users/UserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _RealHomePageState createState() => _RealHomePageState();
}

class _RealHomePageState extends State<UserHomePage> {
  String? image;

  UserModel userModel = UserModel();

  int currentTab = 0;
  final List<Widget> screen = [
    const UserHomeBody(),
    const NotificationPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const UserHomeBody();
  DateTime timeBackPressed = DateTime.now();

  getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();
    setState(() {
      image = userDoc.get('image');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExectWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExectWarning) {
          const message = "press back again to exit";
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[300],
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    setState(() {
                      currentScreen = const UserHomeBody();
                      currentTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    size: 30,
                    color:
                        currentTab == 0 ? const Color(0xff1098c2) : Colors.grey,
                  ),
                ),
                MaterialButton(
                  minWidth: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPost()));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: 50,
                  onPressed: () {
                    setState(() {
                      currentScreen = const NotificationPage();
                      currentTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.notifications,
                    color:
                        currentTab == 2 ? const Color(0xff1098c2) : Colors.grey,
                  ),
                ),
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          image ??
                              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// void scrollBottom() {
//   showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return const BottomSheetPage();
//       });
// }
}
