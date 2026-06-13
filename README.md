<div align="center">

# 🥘 Khidda (খিদা)
### **"Deshi Sadh, Canada-r Kache" (Taste of Home, Close to Canada)**

[![Platform](https://img.shields.io/badge/Platform-Flutter-blue?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Backend](https://img.shields.io/badge/Backend-Node.js-339933?style=for-the-badge&logo=nodedotjs)](https://nodejs.org/)
[![API](https://img.shields.io/badge/API-Express.js-000000?style=for-the-badge&logo=express)](https://expressjs.com/)
[![Database](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql)](https://www.mysql.com/)
[![Payment](https://img.shields.io/badge/Payment-Stripe-6772E5?style=for-the-badge&logo=stripe)](https://stripe.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

**Bringing authentic Bangladeshi homemade flavors to the Bangladeshi diaspora in Canada.**

---

</div>

---

## 📖 Overview
**Khidda** (meaning "hunger" or "craving" in Bengali) is a specialized cloud kitchen food delivery platform. It bridges the gap between traditional Bangladeshi home-cooked meals and the busy lifestyle of immigrants in Canada. By leveraging a "ghost kitchen" model, Khidda enables home chefs to share their culinary heritage while providing customers with the comfort of authentic, fresh, and high-quality food.

---

## ✨ Key Features

### 📱 Customer App
- 🥗 **Authentic Menu:** Explore a wide variety of traditional Bangladeshi dishes.
- 📍 **Real-time Tracking:** Monitor your order from preparation to delivery.
- 💳 **Secure Payments:** Integrated Stripe gateway for seamless Canadian transactions.
- 📅 **Scheduled Delivery:** Pre-order meals for special occasions or daily routines.
- 💬 **Feedback System:** Rate and review dishes to help maintain quality.

### 🛡️ Admin Panel
- 📊 **Dashboard:** Overview of daily sales, active orders, and revenue.
- 📦 **Order Management:** Efficiently manage order flows from kitchen to dispatch.
- 🥘 **Menu Control:** Update items, prices, and availability in real-time.
- 👥 **User & Delivery Management:** Oversee customers and delivery personnel.

---

## 📸 App Screenshots
<p align="center">
  <i>UI Previews coming soon...</i>
</p>
<p align="center">
  <img src="https://via.placeholder.com/200x400?text=Login+Screen" width="200" alt="Login Screen">
  <img src="https://via.placeholder.com/200x400?text=Home+Screen" width="200" alt="Home Screen">
  <img src="https://via.placeholder.com/200x400?text=Order+Tracking" width="200" alt="Order Tracking">
</p>

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Mobile App** | Flutter (Dart) |
| **Backend** | Node.js + Express.js (REST API) |
| **Database** | MySQL |
| **Authentication** | Firebase Auth / JWT |
| **Payment** | Stripe (Canada) |
| **Deployment** | PM2 + VPS / Railway |

---

## 📁 Project Structure

```text
Khidda-Demo/
├── Khidda/                 # Flutter Customer App
│   ├── lib/
│   │   ├── models/         # Data structures
│   │   ├── screens/        # UI Layers
│   │   ├── services/       # API & Backend integration
│   │   └── widgets/        # Reusable UI components
│   └── pubspec.yaml
├── Admin/                  # Admin Management App
│   ├── src/                # Management features
│   └── ...
├── Backend/                # Node.js REST API
│   ├── src/
│   │   ├── controllers/    # Business logic
│   │   ├── routes/         # API routing
│   │   ├── models/         # Database queries
│   │   └── middleware/     # Auth & Security
│   ├── .env.example
│   └── package.json
└── README.md
```

---

## ⚙️ Installation & Setup

### 1. Backend Setup
```bash
# Navigate to backend directory
cd Backend

# Install dependencies
npm install

# Setup environment variables
cp .env.example .env

# Start the server
npm start
```

### 2. Mobile App Setup
```bash
# Navigate to Khidda directory
cd Khidda

# Get Flutter packages
flutter pub get

# Run the app
flutter run
```

---

## 🔑 Environment Variables
Create a `.env` file in the `Backend` directory:
```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASS=your_secure_password
DB_NAME=khidda_db
JWT_SECRET=your_jwt_secret_key
STRIPE_SECRET_KEY=sk_test_...
FIREBASE_ADMIN_SDK=path/to/firebase-sdk.json
```

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/auth/login` | Secure user authentication |
| `GET` | `/api/menu` | List all available dishes |
| `POST` | `/api/orders` | Place a new food order |
| `GET` | `/api/orders/status` | Track active order progress |

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="center">
  Developed with ❤️ by <b>Team Softece</b><br>
  <i>Khidda</i>
</p>