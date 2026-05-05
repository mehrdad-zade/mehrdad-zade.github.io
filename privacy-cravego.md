# Privacy Policy for CraveGo

**Effective Date:** May 4, 2026  
**Last Updated:** May 4, 2026  

---

## Introduction

CraveGo ("we," "our," or "the app") is designed to help you find the best local spots with minimal data footprint. This Privacy Policy outlines how we handle your information, specifically focusing on location data and third-party service integration.

- **Developer:** [Your Name/Company Name]  
- **Contact:** [Your Email/Support Link]  

---

## 1. Information We Collect & How We Use It

### Location Data

To provide "nearby" search results and calculate travel times (walking, biking, transit, or driving), CraveGo requires access to your device's precise location.

- **Processing:** Your coordinates are sent to the Google Places API to fetch relevant businesses near you.  
- **Storage:** We do not store your location history on any server. Location data is processed in real-time and discarded after the search is complete.

---

### Subscription & Purchase Data (StoreKit 2)

CraveGo offers a monthly subscription via Apple's StoreKit 2.

- **Transaction Processing:** All payments are handled securely by Apple. We do not see or store your credit card information or personal billing details.  
- **Local Tracking:** We track your "Free Tier" usage (up to 3 successful searches) locally on your device using UserDefaults. This data does not leave your device.

---

### Search Queries

When you search for a term (e.g., "cappuccino"), that query is sent to Google Services to identify matching venues.

These searches are not linked to a personal CraveGo account, as the app does not require registration.

---

## 2. Third-Party Services

We rely on the following partners to provide core app functionality:

| Service              | Purpose                    | Data Shared                          | Policy          |
|---------------------|----------------------------|--------------------------------------|-----------------|
| Google Places API   | Venue search & details     | Search terms, Location, IP            | Google Privacy  |
| Apple StoreKit      | $1.99/mo subscription      | Transaction ID, Purchase status      | Apple Privacy   |
| Maps/Waze           | Directions & Navigation    | Destination coordinates              | Subject to app  |

---

## 3. Data Retention

- **On-Device:** Your travel mode preferences and free-tier search count are stored in UserDefaults. This is deleted if you uninstall the app.  
- **Cloud:** Because CraveGo has no backend server, we retain zero personal user data in the cloud.

---

## 4. Your Choices

### Location Permissions

You can choose to grant location access "While Using the App" or "Never." If you deny access, you must manually enter a location to receive search results.

---

### App Tracking Transparency (ATT)

CraveGo does not use third-party advertising identifiers (IDFA) or data-mining brokers. However, should we implement analytics in the future, you will be prompted via the iOS tracking dialog.

---

## 5. Security

We use industry-standard protocols to protect your data:

- All communication with Google APIs is encrypted via HTTPS.  
- Subscription status is verified using Apple's cryptographically signed StoreKit 2 values.

---

## 6. Contact Us

For questions regarding this policy or your data, please open an issue on our GitHub Repository or contact us at **zade.mehrdad@gmail.com**.