import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/style/app_colors.dart';
import 'package:talk_line/core/utils/data_base.dart';
import 'package:talk_line/core/model/room_model.dart';
import 'package:talk_line/features/authentication/widgets/custom_form_field.dart';
import 'package:talk_line/features/chat_screen/chat_screen.dart';
import 'package:talk_line/features/genrals/custom_snack_bar.dart';
import 'package:talk_line/features/home_screen/home_screen_navigator.dart';
import 'package:talk_line/features/home_screen/home_screen_view_model.dart';
import 'package:talk_line/features/home_screen/widgets/contact_card.dart';

class HomeScreenView extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    implements HomeScreenNavigator {
  TextEditingController groupName = TextEditingController();
  TextEditingController groupDescription = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  void initState() {
    super
        .initState(); //this because you initialize the navigator in the view model using late
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: REdgeInsets.all(10.0),
              child: Image.asset("assets/images/Ellipse 5.png"),
            ),
            title: Text(
              "Jira Mo'men",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
  icon: Icon(Icons.add),
  color: Colors.white,
  onPressed: () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Allow the sheet to take more space
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Container(
            height: 500.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.r,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView( // Make the content scrollable
              child: Padding(
                padding: REdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Create New Room',
                        style: Theme.of(context).textTheme.titleLarge, 
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Image.asset(
                          "assets/images/room.png",
                          height: 150.h,
                          width: 150.w,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        label: "Room Name",
                        hint: "Meeting Room",
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter a group's name";
                          }
                          return null;
                        },
                        controller: groupName,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFormField(
                        label: "Group Description",
                        hint: "",
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter a group's description";
                          }
                          return null;
                        },
                        controller: groupDescription,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: REdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Add Room'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            validateForm();
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(height: 20.h), // Extra space at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  },
),
              SizedBox(
                width: 10.w,
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {},
              ),
              SizedBox(
                width: 25.w,
              )
            ],
          ),
          body: StreamBuilder<QuerySnapshot<RoomModel>>(
            stream: DataBaseUtils.getRooms(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (asyncSnapshot.hasError) {
                return const Center(child: Text("Error"));
              } else if (asyncSnapshot.hasData) {
                var roomsList = asyncSnapshot.data?.docs
                        .map((doc) => doc.data())
                        .toList() ??
                    [];
                return ListView.builder(
                  itemCount: roomsList.length,
                  itemBuilder: (context, index) {
                    return RoomCard(
                      room: roomsList[index],
                      image: "",
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      viewModel.addRoom(groupName.text.trim(), groupDescription.text.trim());
    } else {
      print("Form validation failed.");
    }
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        });
  }

  @override
  void showMessage(String message, bool isSuccess) {
    CustomSnackBar.show(context, message: message, isSuccess: isSuccess);
  }

  @override
  void navigateToRoomScreen() {
    // TODO: implement navigateToRoomScreen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }
}
