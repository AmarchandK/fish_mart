# Fish Mart - Fresh Fish & Seafood Delivery App

A modern Flutter application for fresh fish and seafood delivery, built following clean architecture principles and Material Design 3 guidelines.

## 🐟 Features

### Core Features (MVP)

- **Phone Authentication**: Firebase-based OTP verification
- **Home Dashboard**: Hero carousel, categories, and featured products
- **Product Catalog**: Browse products by categories with detailed information
- **User Profile**: Profile management and address book
- **Beautiful UI**: Ocean-themed design with smooth animations

### Technical Features

- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **State Management**: BLoC pattern for predictable state management
- **Modern UI**: Material Design 3 with custom ocean-inspired theme
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Performance Optimized**: Image caching and efficient data loading

## 🏗️ Architecture

The app follows Clean Architecture principles:

```
lib/
├── core/                   # Core functionality
│   ├── config/            # App configuration
│   ├── theme/             # App theming
│   ├── di/                # Dependency injection
│   └── router/            # App routing
├── domain/                # Business logic
│   └── entities/          # Domain entities
├── data/                  # Data layer (future)
│   ├── models/           # Data models
│   ├── repositories/     # Repository implementations
│   └── datasources/      # Data sources
├── presentation/          # UI layer
│   ├── pages/            # App screens
│   ├── widgets/          # Reusable widgets
│   └── app/              # App configuration
└── main.dart             # App entry point
```

## 🎨 Design System

### Color Palette

- **Primary**: Ocean Blue (#0077BE)
- **Secondary**: Sea Green (#00A86B)
- **Accent**: Coral Orange (#FF6B35)
- **Background**: Off White (#F8FFFE)
- **Surface**: Pure White (#FFFFFF)

### Typography

- **Font Family**: Poppins
- **Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)

## 📱 Screenshots

### Authentication Flow

- Splash screen with animated logo
- Phone number login with OTP verification
- Smooth transitions between screens

### Home Experience

- Hero carousel with promotional content
- Category grid with ocean-themed icons
- Featured products with ratings and pricing

### User Profile

- Profile information with statistics
- Menu items for various app functions
- Settings and logout functionality

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/fish_mart.git
   cd fish_mart
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Create a new Firebase project
   - Add Android/iOS apps to the project
   - Download and place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Authentication with Phone provider

4. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

### Core Dependencies

- `flutter_bloc: ^8.1.3` - State management
- `equatable: ^2.0.5` - Value equality
- `go_router: ^12.1.3` - Navigation
- `get_it: ^7.6.4` - Dependency injection

### Firebase

- `firebase_core: ^2.24.2` - Firebase core
- `firebase_auth: ^4.15.3` - Authentication

### UI & UX

- `cached_network_image: ^3.3.0` - Image caching
- `carousel_slider: ^4.2.1` - Image carousel
- `shimmer: ^3.0.0` - Loading animations
- `lottie: ^2.7.0` - Animations

### Networking & Storage

- `dio: ^5.3.2` - HTTP client
- `shared_preferences: ^2.2.2` - Local storage
- `hive: ^2.2.3` - Local database

### Utilities

- `intl: ^0.18.1` - Internationalization
- `logger: ^2.0.2+1` - Logging
- `permission_handler: ^11.1.0` - Permissions

## 🏃‍♂️ Development

### Code Structure

- Follow clean architecture principles
- Use BLoC for state management
- Implement repository pattern for data access
- Write unit tests for business logic

### Coding Standards

- Use meaningful variable and function names
- Follow Dart/Flutter style guidelines
- Add documentation for public APIs
- Implement proper error handling

### Git Workflow

- Create feature branches from `develop`
- Use conventional commit messages
- Submit pull requests for code review
- Maintain clean commit history

## 🧪 Testing

### Unit Tests

```bash
flutter test
```

### Integration Tests

```bash
flutter test integration_test/
```

### Widget Tests

- Test individual widgets
- Verify UI behavior
- Mock dependencies

## 📱 Platform Support

### Android

- Minimum SDK: API 23 (Android 6.0)
- Target SDK: Latest stable
- Adaptive icon support

### iOS

- Minimum version: iOS 12.0
- Support for iPhone and iPad
- Dark mode compatibility

## 🔧 Configuration

### Environment Variables

Create `.env` files for different environments:

- `.env.development`
- `.env.staging`
- `.env.production`

### Build Flavors

Configure different build flavors for:

- Development
- Staging
- Production

## 🚀 Deployment

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🔄 Future Enhancements

### Phase 2 Features

- Shopping cart functionality
- Order management system
- Payment integration
- Real-time order tracking
- Push notifications
- Product reviews and ratings

### Phase 3 Features

- Advanced search and filters
- Wishlist functionality
- Loyalty program
- Multi-language support
- Offline mode
- Social sharing

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📞 Support

For support and questions:

- Email: support@fishmart.com
- Phone: +1-800-FISH-MART
- Website: https://fishmart.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Unsplash for placeholder images
- Material Design team for design guidelines

---

**Made with ❤️ and Flutter**
