# Toko Rakyat 🛒

**Toko Rakyat** (The People's Store) is a simple yet full-stack mobile e-commerce application built using **Flutter** and **Firebase**. This app covers the complete e-commerce business cycle, ranging from user authentication and product browsing to cart management and order history.

This project serves as a demonstration of Android application development capabilities with real-time backend integration.

## 📱 Key Features

* **Splash Screen & Auto Login:** Automatic user session check upon application launch.
* **User Authentication:** Secure Login and Register using Email & Password (Firebase Auth).
* **Real-time Product Catalog:** Displays product data directly from Cloud Firestore.
* **Search & Filter:** Search products by name and filter by specific categories (e.g., Shoes, Outdoor, Accessories).
* **Shopping Cart (State Management):** Add items and dynamically calculate total prices using Provider.
* **Checkout System:** Saves orders to the database and automatically clears the cart.
* **Order History:** View the purchase history for the currently logged-in user.
* **User Profile:** Displays user information and handles the Logout functionality.

## 🛠️ Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Firebase (Authentication, Cloud Firestore)
* **State Management:** Provider
* **Architecture:** MVC (Model-View-Controller) pattern

## 📋 Prerequisites

Before running this project, ensure you have the following installed:

1.  **Flutter SDK** (Latest Stable Version)
2.  **Git**
3.  **Android Studio / VS Code**
4.  **Google Account** (To access Firebase Console)

## 🚀 Installation & Setup

Follow these steps to run the application on your local machine:

### 1. Clone the Repository

git clone https://github.com/ANazmuddin/tokorakyat_app.git
cd toko_rakyat

```

### 2. Install Dependencies

Download all required libraries (Provider, Firebase, etc.):

```bash
flutter pub get

```

### 3. Configure Firebase (Crucial!)

For security reasons, the Firebase configuration file is not included in this repository. You must connect it to your own Firebase project:

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (e.g., `toko-rakyat-db`).
3. Enable **Authentication**: Select *Sign-in method* -> *Email/Password* -> *Enable*.
4. Enable **Firestore Database**: Select *Create Database* -> *Start in Test Mode*.
5. In your project terminal, run:
```bash
flutterfire configure

```


*(Select the project you just created).*

### 4. Seed the Database

To populate the app with data, you need to manually add product data to your Firestore Database:

* Create a new Collection named: **`products`**
* Add a Document with the following fields:
* `name` (string): e.g., "Cool Sneakers"
* `price` (string): e.g., "Rp 500.000"
* `category` (string): e.g., "Sepatu" (Options: Sepatu, Outdoor, Aksesoris, Pakaian)
* `image` (string): Image URL (use a link from Unsplash/Google)



### 5. Run the App

Ensure your Android Emulator is running or a physical device is connected.

```bash
flutter run

```

## 📂 Project Structure

```
lib/
├── controllers/      # Business Logic (Cart, Auth, Product)
├── models/           # Data Structure (Product Model)
├── views/            # UI Screens
│   ├── login_page.dart
│   ├── home_page.dart
│   ├── cart_page.dart
│   └── ...
└── main.dart         # Entry point & Provider Setup

```

## 🤝 Contribution

Contributions are welcome! If you have suggestions for improvements or want to add new features, feel free to open a Pull Request. Future improvement ideas:

* Payment Gateway Integration (Midtrans/Stripe).
* Profile Editing & Photo Upload.
* Admin Dashboard for managing products.

---

Made with ❤️ using Flutter.

```

***

### Pro Tip for Your Portfolio:
If you upload this to GitHub, you can also add a section called **"Screenshots"** or **"Demo"** in the README and include a GIF or images of your app running. This drastically increases the chances of recruiters or other developers noticing your work!

```
