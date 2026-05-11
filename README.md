Flow: Non-Verbal Communication System
Flow is an assistive technology platform designed to bridge the gap between physical motion and digital speech. Developed by Team Ellipse, this system allows individuals to communicate through intent-driven physical inputs captured by wearable sensors.

📱 Software-Hardware Integration
Flow acts as the central hub for wearable hardware, processing raw sensor data into meaningful verbal output:

Sensor Fusion: Interfaces with modules like the ESP32 to capture non-verbal cues.

Morse Code Engine: Translates physical triggers, such as eye blinks or finger taps, into text and speech in real-time.

Wearable Sync: Uses low-latency protocols to ensure physical movements are immediately reflected in the app UI.

🧠 Signal Interpretation & Logic
The core logic focuses on transforming movement into communication:

Input Processing: Our model filters noise from sensors (IMUs or optical trackers) to distinguish between accidental movement and intentional communication.

AI Voice Selection: Once a message is formed, users can select specific AI-generated voices to speak for them.

Developed By: Utsha Nandi
