<div align="center">

# 🥘 Khidda (খিদা)
### **"Deshi Sadh, Canada-r Kache" (Taste of Home, Close to Canada)**

[![Platform](https://img.shields.io/badge/Platform-Flutter-blue?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Language](https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Backend](https://img.shields.io/badge/Backend-Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![API](https://img.shields.io/badge/API-Express.js-000000?style=for-the-badge&logo=express&logoColor=white)](https://expressjs.com/)
[![Database](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Payment](https://img.shields.io/badge/Payment-Stripe-6772E5?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

**Bringing authentic Bangladeshi homemade flavors to the Bangladeshi diaspora in Canada.**

---

[Explore Features](#-key-features) • [Project Structure](#-project-structure) • [Tech Stack](#-tech-stack) • [Installation](#-installation--setup)

</div>

---

## 📖 Overview
**Khidda** (meaning "hunger" or "craving" in Bengali) is an artisanal cloud-kitchen food delivery ecosystem. It connects the authentic culinary heritage of Bangladeshi home-cooked delicacies with the busy lives of students and professionals living in Canada. Utilizing a distributed ghost-kitchen model, Khidda empowers passionate home chefs to monetize their recipes while giving customers fresh, hygienic, and nostalgic comfort food delivered directly to their doorstep.

---

## ✨ Key Features

### 📱 Customer Mobile App
- 🥗 **Authentic Deshi Menu:** Explore traditional Bengali culinary favorites from Kachchi Biryani to Bhorta platters.
- 📍 **Live Order Journey:** Interactive tracking from kitchen preparation through packaging to driver dispatch.
- 💳 **Seamless Canadian Payments:** Fully PCI-compliant payment pipeline powered by Stripe Canada.
- 📅 **Scheduled Pre-Orders:** Plan ahead for weekend feasts, family gatherings, or meal prep plans.
- 💬 **Verified Reviews & Ratings:** Honest community feedback ensuring consistently high culinary standards.

### 🛡️ Admin & Kitchen Command Center
- 📊 **Real-time Operations Dashboard:** Live revenue streams, order throughput, and inventory forecasting.
- 📦 **Order Dispatch Board:** Kitchen-friendly kanban flow for order confirmation, prep status, and dispatching.
- 🥘 **Dynamic Menu Control:** Update item availability, seasonal specials, and pricing instantly.
- 👥 **Driver & Customer Management:** Automated routing, driver assignments, and live customer support.

---

## 📁 Project Structure

```text
Khidda/
├── client/                     # Flutter Customer Mobile App
│   ├── lib/
│   │   ├── models/             # Data models (FoodItem, Order, User, Cart)
│   │   ├── screens/            # UI Pages (Home, Menu, Checkout, Tracking)
│   │   ├── services/           # REST API client & Stripe SDK integration
│   │   └── widgets/            # Custom styled cards, buttons, badges
│   └── pubspec.yaml
├── admin/                      # Operations & Admin Dashboard
│   ├── src/                    # Kitchen & dispatch management
│   └── package.json
├── backend/                    # Node.js + Express REST API Server
│   ├── src/
│   │   ├── controllers/        # Order, Menu, and User business logic
│   │   ├── routes/             # RESTful API endpoints
│   │   ├── models/             # MySQL schema definitions and queries
│   │   └── middleware/         # JWT verification, CORS & rate limiters
│   ├── .env.example
│   └── package.json
└── README.md
```

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Mobile App** | Flutter (Dart SDK 3.x) |
| **Backend** | Node.js + Express.js REST API |
| **Database** | MySQL (Transactional Order & Catalogue Data) |
| **Authentication** | Firebase Auth / Signed JWT Tokens |
| **Payment Gateway** | Stripe (Interac / Credit Card Processing) |
| **State Management** | Provider / BLoC |
| **Process Manager** | PM2 on Linux VPS / Railway |

---

## ⚙️ Installation & Setup

### 1. Backend Setup
```bash
cd backend
npm install
cp .env.example .env
npm start
```

### 2. Mobile App Setup
```bash
cd client
flutter pub get
flutter run
```

---

## 🔌 Core API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/auth/login` | Secure customer & chef authentication |
| `GET` | `/api/menu` | List active menu items and specials |
| `POST` | `/api/orders` | Place a new culinary order |
| `GET` | `/api/orders/:id/track` | Live delivery location and status |
| `POST` | `/api/payments/create-intent` | Stripe payment sheet initialization |

---

## 📄 License
Distributed under the MIT License. See `LICENSE` for more information.

<div align="center">

**Developed with ❤️ by Fuad**  
*Developed by Softece*  
*Khidda*

</div>
