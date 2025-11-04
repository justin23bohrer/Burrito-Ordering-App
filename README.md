# Burrito Ordering App 🌮

A full-featured iOS application that provides users with a seamless food ordering experience, store location finder, and account management system.

## 📱 Features

### 🔐 User Authentication
- **Account Creation**: New users can create accounts with profile pictures
- **Firebase Authentication**: Secure login/logout functionality
- **Profile Management**: Upload and manage profile pictures using camera or photo library

### 🛒 Food Ordering System
- **Menu Selection**: Choose from various food options (Bowls, Tacos, Burritos, Nachos)
- **Customization**: Fully customizable orders with:
  - Bread/base selection
  - Bean varieties
  - Rice options
  - Meat choices (with vegan/vegetarian options)
  - Fresh vegetables and toppings
  - Sauce selection
- **Order Management**: Add multiple items to cart and review full orders
- **Dietary Preferences**: Support for vegan and vegetarian options

### 🗺️ Store Locator
- **Interactive Map**: Find nearby restaurant locations using MapKit
- **Multiple Locations**: View all restaurant locations
- **Location Details**: Get information about each store location

### ⚙️ Settings & Preferences
- **Dark/Light Mode**: Toggle between dark and light themes
- **Dietary Settings**: Set vegan/vegetarian preferences
- **User Preferences**: Customizable app settings

## 🛠️ Technical Details

### Built With
- **Language**: Swift
- **Platform**: iOS
- **Architecture**: MVC (Model-View-Controller)
- **Database**: Firebase Authentication & Storage
- **Maps**: MapKit Framework
- **UI**: Storyboard-based interface

### Key Components
- `ViewController.swift` - Login screen and authentication
- `CreateAccountViewController.swift` - Account creation with profile pictures
- `FullOrderViewController.swift` - Main ordering interface and cart management
- `workingOrderViewController.swift` - Food customization screen
- `findStoreViewController.swift` - Store locator with map integration
- `settingViewController.swift` - App settings and preferences
- `Food.swift` - Data model for food items and orders

### Dependencies
- Firebase SDK (Authentication & Storage)
- MapKit Framework
- UIKit Framework

## 🚀 Installation & Setup

### Prerequisites
- Xcode 12.0 or later
- iOS 13.0 or later
- Firebase project setup

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/justin23bohrer/Burrito-Ordering-App.git
   cd Burrito-Ordering-App
   ```

2. **Firebase Configuration**
   - Add your `GoogleService-Info.plist` file to the project
   - Ensure Firebase Authentication and Storage are enabled in your Firebase console

3. **Open in Xcode**
   ```bash
   open FinalProject.xcodeproj
   ```

4. **Install Dependencies**
   - The project includes Firebase SDK
   - Ensure all dependencies are properly linked

5. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run the application

## 📖 Usage

1. **First Time Users**
   - Launch the app
   - Tap "Create Account" to register
   - Upload a profile picture (optional)
   - Complete registration

2. **Ordering Food**
   - Log in with your credentials
   - Browse the menu and select food items
   - Customize each item with your preferred ingredients
   - Add items to your cart
   - Review and place your order

3. **Finding Stores**
   - Use the store locator to find nearby restaurant locations
   - View locations on the interactive map
   - Get directions to your preferred location

4. **Managing Settings**
   - Access settings to customize your experience
   - Toggle dark/light mode
   - Set dietary preferences (vegan/vegetarian)

## 🏗️ Project Structure

```
FinalProject/
├── ViewControllers/
│   ├── ViewController.swift              # Login screen
│   ├── CreateAccountViewController.swift # Account creation
│   ├── FullOrderViewController.swift     # Main ordering interface
│   ├── workingOrderViewController.swift  # Food customization
│   ├── findStoreViewController.swift     # Store locator
│   ├── settingViewController.swift       # App settings
│   └── ...
├── Models/
│   └── Food.swift                        # Data models
├── Assets.xcassets/                      # Images and icons
├── Base.lproj/                          # Storyboards
└── Supporting Files/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── Info.plist
    └── GoogleService-Info.plist
```

## 🎨 Design Features

- **Responsive UI**: Adapts to different screen sizes
- **Dark Mode Support**: Full dark/light theme toggle
- **Accessibility**: VoiceOver and accessibility support
- **Intuitive Navigation**: Easy-to-use interface design
- **Visual Appeal**: Custom icons and branded imagery

## 🔒 Privacy & Security

- **Secure Authentication**: Firebase Authentication handles user credentials securely
- **Data Protection**: User data is protected and stored securely
- **Permission Handling**: Proper camera and photo library permission requests
- **Privacy Compliance**: Follows iOS privacy guidelines

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Justin Bohrer**
- GitHub: [@justin23bohrer](https://github.com/justin23bohrer)

## 🙏 Acknowledgments

- Cabo Bob's restaurant for inspiration
- Firebase team for authentication and storage solutions
- Apple for iOS development frameworks

## 📞 Support

For support or questions about this application, please open an issue on GitHub or contact the developer.

---

*Built with ❤️ for food ordering lovers everywhere!*
