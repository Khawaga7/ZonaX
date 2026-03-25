# [cite_start]🚖 ZonaX - Smart Fleet Intelligence Platform (SFIP) [cite: 3]

![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-success.svg)
![State Management](https://img.shields.io/badge/State_Management-BLoC%2FCubit-orange.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)

> [cite_start]An Al-powered mobile application designed to optimize taxi and fleet driver operations through predictive analytics, real-time demand mapping, and intelligent decision support[cite: 6].

---

## 📑 Table of Contents
1. [About The Project](#-about-the-project)
2. [Core Features](#-core-features)
3. [Architecture & Folder Structure](#-architecture--folder-structure)
4. [Tech Stack](#-tech-stack)
5. [Getting Started](#-getting-started)
6. [Team & Authors](#-team--authors)

---

## 📌 About The Project
[cite_start]**ZonaX** leverages machine learning, geospatial analysis, and voice-first interaction to provide drivers with actionable insights that maximize earnings while ensuring safe, hands-free operation[cite: 7]. [cite_start]It aims to increase driver earnings by 15-25% through intelligent zone recommendations [cite: 25] [cite_start]and maintain functionality during connectivity loss through offline edge computing[cite: 28].

*(📸 Note: Add a high-quality mockup or GIF of your app's main heatmap screen here later)*

---

## ✨ Core Features
* [cite_start]**🗺️ Dynamic Predictive Heatmaps:** Visualize real-time and forecasted demand on an interactive map[cite: 40].
* [cite_start]**🎙️ Voice-First Smart Assistant:** Enable hands-free interaction using natural language processing[cite: 35].
* [cite_start]**🧠 Explainable Insight Cards:** Provide transparent explanations for Al recommendations[cite: 48].
* [cite_start]**📶 Offline Edge Mode:** Maintain critical functionality during connectivity loss[cite: 54].
* [cite_start]**☕ Smart Break Timer:** Recommend optimal break times based on demand patterns[cite: 144].
* [cite_start]**📊 Business Intelligence Dashboard:** Track and visualize daily earnings progress [cite: 150] [cite_start]and calculate driver payout[cite: 129].

---

## 🏗️ Architecture & Folder Structure
[cite_start]This project strictly follows **Clean Architecture** principles with clear Presentation, Domain, and Data layers [cite: 277, 282, 285] to ensure scalability, testability, and separation of concerns.

```text
lib/
│
├── core/                       # Shared utilities, network client, and DI (ServiceLocator)
│   ├── network/                # DioClient, WebSocketManager, AuthInterceptor
│   ├── storage/                # LocalDataSourceImpl, SecureStorage
│   └── services/               # GetIt setup, AppAnalytics, Crashlytics
│
├── features/                   # Feature-driven modules
│   │
│   ├── auth/                   # User authentication & profile management
│   ├── map_intelligence/       # GIS logic, ZoneModels, InsightGenerator, Geofencing
│   └── trip_management/        # Trip logs, offline sync orchestration (TripRepositoryImpl)
│
└── main.dart                   # Application entry point
