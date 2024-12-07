# FOT Mail Tracking System

# Overview

The **FOT Mail Tracking System** is a Flutter-based mobile application designed to manage and track the physical mail movement within the university. It allows users to update and monitor mail delivery progress using unique IDs and QR codes for each letter. This project includes a web app for creating and assigning QR codes and a mobile app for tracking letter status.

# Features

- **Letter Tracking**: Logs letter movements from sender to receiver.
- **Real-time Status Update**: Shows a detailed tracking log for each letter.
- **Authentication**: Secure user login and registration using Firebase.

# Technologies Used

- **Flutter**: Cross-platform mobile app development.
- **Firebase**: Authentication and data storage.
- **Node.js and Express**: Backend server for API services.
- **MongoDB**: Database for storing letter information and tracking logs.

# Installation

1. **Clone Repository**:
   ```bash
   [https://github.com/FOT-MAIL-TRACK/FMT-APP.git] 

2. **Install Dependencies**:
   ```bash
   flutter pub get
   
3. **Run the Application**:
   ```bash
   flutter run

# Usage

- **Tracking Update**: Use the mobile app to scan the QR code and update the letter status.
- **View Log**: Access the tracking log to see the journey of each letter.

# Project Structure

 - **lib/**: Contains Flutter code for UI and logic.
 - **services/**: Holds the AuthService for handling authentication.
 - **screens/**: Screens like TrackingLog for letter tracking.
 - **backend/**: Server-side code for managing mail tracking data.
   
# Code Highlights

The TrackingLog widget in tracking_log.dart displays letter tracking information and handles tracking updates. It checks if the uniqueID starts with "EXT" before logging tracking information.
