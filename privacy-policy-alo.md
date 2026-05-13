# alo — Privacy Policy

This policy describes what data alo collects, how it is used, who it is shared
with, and how you can control it. It is written to be accurate to the app's
actual behavior, not to be aspirational. If the app changes, this document
changes with it.

By using alo you agree to the practices described below.

---

## 1. Data We Collect

We try to collect as little as possible. The exhaustive list:

### 1.1 Account Data (provided by you)
- **Email address** — captured via Sign in with Apple, or for development
  builds, email/password sign-in. Used as your account identifier and to let
  other users find you.
- **Display name** — what other users see in chats and calls.
- **Avatar image** _(optional)_ — only if you upload one in Profile.
- **EULA acceptance timestamp and version** — recorded so we can re-prompt you
  if our terms materially change.

### 1.2 Contact Email Addresses (transient, on demand)
When you tap "Allow" on the "Find Friends" screen, alo reads the email
addresses from your device address book **locally on the device**, then sends
**only the email addresses** to our backend (Firebase Firestore) so we can
return the subset that are already registered alo users.

- We **do not store** the emails you send. They are used only as the input to a
  single Firestore query.
- We **do not transmit** contact names, phone numbers, postal addresses, or any
  other contact field — those never leave your device.
- You can deny this permission at any time in iOS Settings → alo → Contacts,
  or by declining the in-app consent prompt. The feature simply turns off.

### 1.3 Conversation Content (created by you)
- **Text messages** — stored in Firestore in the conversation you sent them to.
- **Voice messages, images, and files** — stored in Firebase Storage; the
  message references the file via URL. **Auto-deleted 72 hours after sending**
  by a scheduled Cloud Function (`purgeExpiredMedia`).
- **Call records** — when a call ends, a short record (initiator, participants,
  duration, status) is written so both parties see it in their chat history.
- **Read receipts** — which participants have opened which messages.

### 1.4 Notification Tokens
- **FCM token** — used to deliver message push notifications via Firebase Cloud
  Messaging → Apple APNs.
- **VoIP token** — used by Cloud Functions to wake the app via Apple APNs VoIP
  so incoming calls ring even when the app is closed.

Both are tied to your installation of alo on this device. If you sign out or
uninstall, they stop being used.

### 1.5 Safety & Moderation Data
- **Reports you file** — if you report a message or user, we store the reporter
  ID, reported user ID, optional reported message ID, the reason category
  (spam / harassment / hate / violence / sexual / other), an optional free-text
  note you provide, and a timestamp.
- **Block list** — when you block another user, their UID is stored on your own
  user record so the client can filter their content from your view.
- **Call failure logs** — if a call drops, the app writes a short diagnostic
  record (call ID, error code, network condition) with no PII so we can fix
  reliability issues.

### 1.6 What We Do **Not** Collect
- ❌ Phone numbers
- ❌ Postal address
- ❌ Date of birth
- ❌ Precise or coarse location
- ❌ Advertising identifiers (IDFA, etc.)
- ❌ Analytics events, screen views, or behavioral tracking
- ❌ Crash reports beyond what Apple's standard crash reporting captures at the
      OS level (we do not integrate Firebase Crashlytics, Sentry, or similar)
- ❌ Health, financial, or biometric data
- ❌ Contact names or phone numbers from your address book

---

## 2. How We Use Your Data

We use the data above strictly to operate alo:

- **Authenticate you** and keep you signed in.
- **Deliver your messages and calls** to the intended recipients.
- **Match your contacts** against existing alo users (see §1.2).
- **Send push notifications** for incoming messages and calls.
- **Enforce community safety** — scan text messages for profanity, action
  reports, and apply blocks/ejections.
- **Provide a 24-hour response** to abuse reports per Apple Guideline 1.2.

We do **not** use your data for advertising, profile-building, or sale.

---

## 3. Who Has Access

alo is built on Google Cloud (Firebase) and LiveKit. The data above is stored
with these processors:

| Processor | What it processes | Why |
|-----------|-------------------|-----|
| **Firebase Authentication** (Google) | Email, password hash (debug only), Sign in with Apple subject ID | Identity |
| **Cloud Firestore** (Google) | User profile, conversations, messages, reports, blocks, call records | Primary data store |
| **Firebase Storage** (Google) | Avatars; voice/image/file message attachments (72 h TTL) | Media storage |
| **Firebase Cloud Messaging + Apple APNs** | FCM token, VoIP token, push payloads | Notifications and incoming-call wakeup |
| **Cloud Functions** (Google, us-central1) | Token issuance, push fan-out, moderation, account deletion | Server logic |
| **LiveKit Cloud** | Real-time audio/video streams during a call; LiveKit-issued JWT | Call media routing |
| **Apple** (Sign in with Apple) | Your Apple ID identifier and the email you choose to share | Authentication |

We do not sell or rent your data. We do not share it with advertisers,
data brokers, or analytics vendors. We will disclose data only when legally
compelled (e.g., a valid subpoena) or when necessary to protect users from
imminent harm.

---

## 4. Data Retention

| Data | Retention |
|------|-----------|
| Voice messages, images, files | **72 hours** after sending, then auto-deleted by `purgeExpiredMedia` |
| Text messages | Until the conversation is deleted, you delete your account, or the other party deletes theirs (which deletes direct chats) |
| Profile (email, display name, avatar) | Until you delete your account |
| FCM / VoIP tokens | Refreshed on each launch; old tokens overwritten |
| Reports | Retained for safety auditing per Apple Guideline 1.2 |
| Call failure logs | Retained for reliability investigation; contain no PII |

---

## 5. Account Deletion

You can delete your account **in-app**, at any time, with no email or support
ticket required.

**Profile → Delete Account → confirm.**

This irreversibly deletes:
- Your Firebase Auth record
- Your `/users/{uid}` profile document (display name, email, avatar URL)
- Your avatar from Firebase Storage
- Every **direct (1:1) conversation** you are a participant in — including the
  full message history and any media still in Storage
- Your membership in every **group conversation**; the group is also deleted if
  fewer than two members would remain

Messages you sent in group conversations that survive deletion are retained for
the remaining members' chat history; your display name will simply no longer
resolve (it falls back to a generic label on their clients).

Reports you filed and call failure logs are retained for safety/reliability
auditing per Apple Guideline 1.2 — these contain only IDs and reason
categories, no personal content.

---

## 6. Security

- All traffic between the app and Firebase / LiveKit / APNs uses TLS.
- Firebase Storage and Firestore are protected by per-resource security rules
  that prevent users from reading or writing data outside their own
  conversations and profile.
- Sign in with Apple uses Apple's standard nonce-based OAuth flow; we never
  see your Apple ID password.
- LiveKit room access requires a server-issued, short-lived JWT.
- Server secrets (LiveKit keys, APNs certificate) are stored in Google Cloud
  Secret Manager, not in the app binary.

No system is perfectly secure; if we learn of a breach affecting your data we
will notify you per applicable law.

---

## 7. Children

alo is not directed to children under 13 (or the equivalent minimum age in
your jurisdiction). We do not knowingly collect data from such users. If you
believe a child has created an account, please contact us at the address
below.

---

## 8. International Users

alo is hosted in the United States (Google Cloud `us-central1`). By using the
app you consent to your data being processed there. Where required by local
law (e.g., GDPR, CCPA), you have the right to:

- Request access to the data we hold about you
- Request correction of inaccurate data
- Request deletion (you can do this directly via §5 above)
- Lodge a complaint with your local data protection authority

To exercise any of these rights, email us at the address in §10.

---

## 9. Changes to This Policy

If we change this policy materially, we will update the date at the bottom and
— for changes that affect what we collect or how we use it — surface a notice
in the app on next launch.

---

## 10. Contact

Questions, requests, or concerns about your privacy:

**Email:** zade.mehrdad@gmail.com

---

_Last updated: May 13, 2026_
