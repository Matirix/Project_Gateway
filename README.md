![Logo](assets/Loading_Screen_REVISED.png)
# Project Gateway

Teams - [Matthew Puyat](https://github.com/Matirix), [Gareth Ng](https://github.com/Lilchoo), [April Cheng](https://github.com/nickfurk), [Heidi Suen](heidisuen.com)

Meet Gateway, a mobile app created to help care deliverers retrieve and update patient information in the quickest and most painless way possible. We conducted primary research interviews with healthcare workers and found a common pain point - finding what you need is difficult because it's spread across multiple data systems. To address this, we needed a snappy system that could make information gathering a kench. Gateway is the solution. In this video, I'll show you how Gateway works and how it can help you retrieve and update patient information efficiently. Our app includes a directory of patients with robust filtering, in-depth patient profiles, and a log page for an overview of all your patient notes. We believe that our platform, Gateway, is a powerful tool in displaying data and helps deliver care in a digestible and efficient way.

Demo Video : https://www.loom.com/share/92d1df11b0b646169e531da2ae73f4fd

## Install Guideline

You will need to set up our own OPEN_AI API keys, create a api_keys.dart in utils folder and insert const String openAiApiKey = 'your-key';

Step 1: Check System Requirements
Before you begin the installation, ensure that your system meets the minimum requirements for running Android Studio and Flutter. You can find the system requirements on the official websites of Android Studio and Flutter.

Step 2: Install Android Studio

Download Android Studio from the official website (https://developer.android.com/studio).
Run the downloaded installer and follow the on-screen instructions.
Choose a location for the installation and select the components you want to install (Android SDK, emulator, etc.).
Once the installation is complete, launch Android Studio.
Step 3: Set Up Android SDK

On the Android Studio Welcome screen, click "Configure" and select "SDK Manager".
In the SDK Platforms tab, select the Android versions you want to target and click "Apply" to download them.
In the SDK Tools tab, select "Android SDK Build-Tools" and "Android SDK Platform-Tools" (and any other tools you need) and click "Apply" to download them.
Step 4: Set Up Flutter

Download the Flutter SDK from the official website (https://flutter.dev).
Extract the downloaded file to a desired location on your system.
Add the Flutter SDK to your system's environment variables:
Open a terminal or command prompt.
Run the command flutter doctor to verify if Flutter is correctly installed.
Copy the Flutter SDK path.
Add the Flutter SDK path to the system's PATH environment variable.
Step 5: Configure Flutter in Android Studio

Launch Android Studio.
Open the Settings/Preferences dialog by going to "File" > "Settings" (on Windows/Linux) or "Android Studio" > "Preferences" (on macOS).
In the left pane, navigate to "Languages & Frameworks" > "Flutter".
Click on the "Enable Flutter SDK" checkbox.
Set the Flutter SDK path to the location where you extracted the Flutter SDK in Step 4.
Click "Apply" and then "OK".

