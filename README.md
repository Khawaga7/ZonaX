**# [cite_start]🚖 ZonaX - Smart Fleet Intelligence Platform (SFIP) [cite: 3]

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

```text**

lib/
│
├── core/                                 # 1. Core Layer (Infrastructure & Shared Services)
│   ├── network/                          # Network communication
│   │   ├── remote_data_source_impl.dart  # (API data fetching)
│   │   ├── websocket_manager.dart        # (Real-time connection for Heatmaps)
│   │   ├── auth_interceptor.dart         # (Token injection)
│   │   └── circuit_breaker_handler.dart  # (Handling server failures gracefully)
│   │
│   ├── storage/                          # Local storage
│   │   ├── local_data_source_impl.dart   # (Hive DB for Offline Mode)
│   │   ├── secure_storage_service.dart   # (Secure token storage)
│   │   ├── file_resource_manager.dart    # (Managing local map files)
│   │   └── encryption_service.dart       # (Encrypting sensitive data)
│   │
│   ├── services/                         # Shared background services
│   │   ├── service_locator.dart          # (Dependency Injection setup - GetIt)
│   │   ├── geofencing_service.dart       # (Detecting when a driver enters a hotspot)
│   │   ├── local_notification_handler.dart # (Break and demand alerts)
│   │   ├── app_analytics.dart            # (User behavior tracking)
│   │   └── crashlytics_service.dart      # (Error and crash reporting)
│   │
│   └── utils/                            # Helper utilities
│       ├── geo_json_parser.dart          # (Parsing NYC maps into geometries)
│       └── data_integrity_guard.dart     # (Validating GPS precision and data)
│
├── features/                             # 2. Features Layer (Feature-First grouping)
│   │
│   ├── auth/                             # Feature: Authentication & Accounts
│   │   ├── data/
│   │   │   └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── user_account.dart         # (Entity: Driver account details)
│   │   │   └── auth_service.dart         # (Login/Logout operations)
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── user_bloc.dart
│   │       └── screens/
│   │           └── login_screen.dart
│   │
│   ├── map_intelligence/                 # Feature: Maps & AI
│   │   ├── data/
│   │   │   └── map_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── zone_model.dart           # (Entity: Zone data and forecasts)
│   │   │   └── insight_generator.dart    # (Generating text for AI explanations)
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── map_cubit.dart
│   │       │   └── map_state_provider.dart # (Zoom state and markers)
│   │       ├── theme/
│   │       │   └── map_style_manager.dart  # (Dark mode & Battery saver mode)
│   │       └── screens/
│   │           └── heatmap_screen.dart     # (Main screen)
│   │
│   ├── trip_management/                  # Feature: Trips & Earnings
│   │   ├── data/
│   │   │   ├── trip_repository_impl.dart   # (Orchestrator for offline sync)
│   │   │   └── offline_sync_manager.dart   # (Syncing trips when online)
│   │   ├── domain/
│   │   │   ├── trip_entity.dart            # (Entity: Trip details)
│   │   │   ├── fare_breakdown_generator.dart # (Calculating fare and 20% commission)
│   │   │   └── dispatch_rule.dart          # (Routing and dispatching rules)
│   │   └── presentation/
│   │       └── screens/
│   │           └── trip_history_screen.dart
│   │
│   ├── driver_performance/               # Feature: Driver Performance & Analytics
│   │   ├── domain/
│   │   │   ├── performance_monitor.dart    # (Monitoring profitability and performance)
│   │   │   └── achievement_manager.dart    # (Points system & Leaderboard)
│   │   └── presentation/
│   │       └── screens/
│   │           └── dashboard_screen.dart
│   │
│   ├── voice_assistant/                  # Feature: Voice Assistant
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── voice_assistant_bloc.dart # (Handling voice recording and processing)
│   │       └── widgets/
│   │           └── voice_button_widget.dart
│   │
│   └── support_and_training/             # Feature: Support & Training
│       ├── domain/
│       │   ├── support_manager.dart        # (FAQs and support tickets)
│       │   └── tutorial_controller.dart    # (Managing tutorial videos)
│       └── presentation/
│           └── screens/
│               └── help_center_screen.dart
│
└── main.dart                             # Application Entry Point (Calls ServiceLocator)
