# Talk-Line - Real-Time Chat App

Talk-Line is a real-time chat application that allows users to connect and communicate seamlessly in group chats. With a smooth and interactive UI, Talk-Line supports animations, user avatars, and a fully responsive design for an optimal experience across all devices.

## ✨ Features

- **Real-Time Messaging**: Instant group chats powered by Firebase for seamless communication.
- **User Authentication**: Secure login and registration using email and password.
- **User Profiles**: Each user has a unique avatar and email display.
- **Group Chat Support**: Create and participate in multiple group conversations.
- **Animated UI**: Smooth transitions and effects for an engaging chat experience.
- **Responsive Design**: Works across all screen sizes, from mobile to tablet.
- **MVVM Architecture**: Ensures a clean and scalable code structure.

## 🚀 Technologies Used

- **Flutter** - Cross-platform UI framework.
- **Firebase** - Backend services for authentication and real-time database.
- **Provider** - State management for handling user sessions.
- **Dio** - For API handling and network requests.
- **Animated Text Kit** - For smooth animated text effects.
- **Flutter ScreenUtil** - For responsive UI scaling.
- **Google Fonts** - Custom typography support.
- **Flutter SVG** - Vector graphics support.
- **Cupertino Icons** - iOS-style icons.
- **Flutter Launcher Icons** - Customizable app icons.

## 📸 Screenshots



## 🛠️ Installation & Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/Momen-Yosri/Talk-Line.git
   ```
2. Navigate to the project directory:
   ```sh
   cd Talk-Line
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 🔐 Firebase Setup
To use Firebase services, set up your own Firebase project:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project and register your app
3. Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the respective folders.
4. Enable Firebase Authentication and Firestore Database.

## 📄 Folder Structure
```
lib/
│── main.dart           # Entry point of the application
│── models/             # Data models (User, Message, etc.)
│── providers/          # State management using Provider
│── screens/            # UI screens (Login, Chat, Groups, etc.)
│── services/           # Firebase and API handling services
│── viewmodels/         # MVVM ViewModel layer
│── widgets/            # Reusable UI components
```

## 📌 Upcoming Features
- ✅ Private one-on-one messaging
- ✅ Voice and video calling
- ✅ Message reactions and GIF support
- ✅ Push notifications

## 🤝 Contributing
Contributions are welcome! Feel free to fork this repository, make your changes, and submit a pull request.

## 📧 Contact
For support or collaboration, reach out to **momen.yosri@gmail.com**.

---
💬 **Talk-Line - Connect, Chat, Enjoy!**

