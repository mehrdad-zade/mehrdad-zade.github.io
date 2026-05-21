# Privacy Policy

**MacRemote Server**
Last updated: May 21, 2026

## Overview

MacRemote Server is a macOS menu bar app that allows your iPhone to control your Mac over your local network. This policy describes what data the app accesses and how it is handled.

## Data Collection

MacRemote Server does **not** collect, store, transmit, or share any personal data. There are no analytics, crash reporting, or telemetry of any kind.

## What the App Does

- **Local network server:** The app runs an HTTP server on port 8080, accessible only on your local Wi-Fi network. No data is sent to the internet.
- **Input simulation:** The app receives commands from your iPhone (mouse movement, clicks, scrolling, keystrokes) and replays them on your Mac using macOS Accessibility APIs. Input commands are not logged or stored.
- **PIN authentication:** A 4-digit PIN you set is stored locally in macOS `UserDefaults`. It is never transmitted off your device.

## Permissions

- **Accessibility:** Required to simulate mouse and keyboard input. This permission is used solely to execute input events received from your iPhone over the local network.

## Data Storage

The only data stored by the app is your chosen PIN, saved locally in macOS `UserDefaults`. This data never leaves your Mac.

## Third-Party Services

MacRemote Server uses no third-party SDKs, services, or frameworks.

## Contact

For questions or concerns, contact: mehrdad.azh@gmail.com
