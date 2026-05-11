# Flow: Non-Verbal Communication System

**Flow** is an assistive technology platform designed to bridge the gap between physical motion, facial expressions, and digital speech. Developed by **Utsha Nandi**, this system empowers individuals to communicate through intent-driven inputs captured by wearable sensors and camera interfaces.

## 📱 Core Capabilities & Integration
**Flow** acts as the central hub for translating multiple forms of non-verbal cues into meaningful verbal output:
* **Sign Language & Expression Translation**: Advanced models interpret dynamic sign language gestures and nuanced facial expressions, converting them into accurate text and speech.
* **Sensor Fusion**: Interfaces with wearable modules (like ESP32/Arduino) to capture physical triggers such as finger taps or eye blinks via a Morse code engine.
* **Wearable Sync**: Utilizes low-latency protocols to ensure real-time synchronization between physical movements and the app UI.

## 🧠 Signal Interpretation & Logic
The core logic focuses on transforming movement into clear communication:
* **Input Processing**: The system filters noise from sensors (IMUs, optical trackers, and camera feeds) to precisely distinguish intentional communication from natural, accidental movement.
* **AI Voice Selection**: Once an input is processed and translated, users can select specific AI-generated voice profiles to speak their messages, adding a personal touch to the output.

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (Latest Version)
* Dart SDK
* For Windows: Visual Studio 2022 with "Desktop development with C++"

### Installation & Running
1. Clone the repository:
   ```bash
   git clone [https://github.com/utshaNandi/kiwi-backend.git](https://github.com/utshaNandi/kiwi-backend.git)
Navigate to the project directory and get dependencies:

Bash
flutter pub get
Run the application:

Bash
flutter run
🛠 Tech Stack
Frontend: Flutter (Dart) for cross-platform accessibility.

Hardware Interface: C++ / Arduino for wearable sensor management.

Communication: Bluetooth Low Energy (BLE) / Serial for high-speed data transfer.

Developed by: Utsha Nandi