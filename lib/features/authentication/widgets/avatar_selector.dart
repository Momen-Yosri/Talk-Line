import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarSelector extends StatefulWidget {
  final Function(String) onAvatarSelected;
  
  const AvatarSelector({
    Key? key,
    required this.onAvatarSelected,
  }) : super(key: key);

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  String? selectedAvatar;
  
  // List of avatar image paths
  final List<String> avatarImages = [
    'assets/images/avatars/avatar1.jpg',
    'assets/images/avatars/avatar2.jpg',
    'assets/images/avatars/avatar3.jpg',
    'assets/images/avatars/avatar4.jpg',
    'assets/images/avatars/avatar5.jpg',
    'assets/images/avatars/avatar6.jpg',
    'assets/images/avatars/avatar7.jpg',
    'assets/images/avatars/avatar8.jpg',
    'assets/images/avatars/avatar9.jpg',
  ];

  void _openAvatarSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: REdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose your avatar',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0.sp,
                    mainAxisSpacing: 10.0.sp,
                  ),
                  itemCount: avatarImages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = avatarImages[index];
                        });
                        widget.onAvatarSelected(avatarImages[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedAvatar == avatarImages[index]
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            avatarImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                    
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openAvatarSelectionSheet(context),
      child: Column(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: selectedAvatar != null
                ? ClipOval(
                    child: Image.asset(
                      selectedAvatar!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.add_a_photo,
                    size: 40.sp,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Select Avatar',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}