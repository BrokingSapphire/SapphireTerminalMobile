# SapphireTerminalMobile

**SapphireTerminalMobile** is the official mobile trading terminal of Sapphire Broking, designed for internal use and distribution to Sapphire clients. The app provides seamless access to market data, trade execution, funds management, and portfolio tracking, optimized for mobile use across Android and iOS devices.

## Private & Confidential

This is a proprietary mobile application developed and maintained by the Sapphire Broking Tech Team. Access to the source code and deployment is restricted to authorized personnel only.

---

## Key Features

- Real-time market watch and price streaming
- Secure order placement and order book management
- Funds deposit and withdrawal interface
- Margin trading and pledge module
- Live portfolio and P&L overview
- Integrated notifications and alerts
- UPI-based wallet loading (in progress)
- Mutual Fund and other investment flows (upcoming)

---

## Internal Setup Instructions

> _For authorized developers only_

### Prerequisites

- Flutter SDK (v3.x+)
- Dart SDK
- Access credentials to internal APIs and Firebase
- Android Studio / Xcode
- Config files (`.env`, `google-services.json`, etc.)

### Installation

```bash
git clone git@github.com:BrokingSapphire/SapphireTerminalMobile.git
cd SapphireTerminalMobile
flutter pub get
```

### Running the App

```bash
flutter run
```


## Project Structure

- `lib/`           # Core app UI and logic
- `core/`          # Shared services and utilities
- `modules/`       # Feature-specific components
- `assets/`        # Static assets (images, icons, etc.)
- `env/`           # Environment configs (ignored from version control)


## Security & Compliance

- Do not share code or credentials externally.
- All builds must go through internal review.
- Follow company commit message and code review protocols.

## Support

For internal technical support or feature requests, please contact:

**Tech Team Lead – Sapphire Broking**  
📧 Email: tech@sapphirebroking.com
