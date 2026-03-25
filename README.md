lib/
│
├── core/                                 # 1. الطبقة الأساسية (البنية التحتية والخدمات العامة)
│   ├── network/                          # ملفات الاتصال بالسيرفر
│   │   ├── remote_data_source_impl.dart  # (لإرسال واستقبال بيانات الـ API)
│   │   ├── websocket_manager.dart        # (للاتصال اللحظي للـ Heatmaps)
│   │   ├── auth_interceptor.dart         # (لحقن التوكن في الطلبات)
│   │   └── circuit_breaker_handler.dart  # (للتعامل مع أعطال السيرفر بذكاء)
│   │
│   ├── storage/                          # ملفات التخزين المحلي
│   │   ├── local_data_source_impl.dart   # (قاعدة بيانات Hive للـ Offline Mode)
│   │   ├── secure_storage_service.dart   # (لتخزين التوكنز بأمان)
│   │   ├── file_resource_manager.dart    # (لإدارة ملفات الخرائط المحملة محلياً)
│   │   └── encryption_service.dart       # (لتشفير البيانات الحساسة)
│   │
│   ├── services/                         # الخدمات المشتركة (تعمل في الخلفية)
│   │   ├── service_locator.dart          # (نقطة تجمع الـ Dependency Injection)
│   │   ├── geofencing_service.dart       # (للتأكد من دخول السائق منطقة مزدحمة)
│   │   ├── local_notification_handler.dart # (لإرسال إشعارات الراحة والطلب)
│   │   ├── app_analytics.dart            # (لتتبع سلوك المستخدم)
│   │   └── crashlytics_service.dart      # (لتسجيل الأخطاء والانهيارات)
│   │
│   └── utils/                            # أدوات مساعدة
│       ├── geo_json_parser.dart          # (لتحويل خرائط نيويورك لأشكال هندسية)
│       └── data_integrity_guard.dart     # (للتحقق من دقة الـ GPS والبيانات)
│
├── features/                             # 2. طبقة الخصائص (مقسمة حسب وظائف التطبيق)
│   │
│   ├── auth/                             # خاصية: الحسابات والمصادقة
│   │   ├── data/
│   │   │   └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── user_account.dart         # (Entity: تفاصيل حساب السائق)
│   │   │   └── auth_service.dart         # (عمليات تسجيل الدخول والخروج)
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── user_bloc.dart
│   │       └── screens/
│   │           └── login_screen.dart
│   │
│   ├── map_intelligence/                 # خاصية: الخرائط والذكاء الاصطناعي
│   │   ├── data/
│   │   │   └── map_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── zone_model.dart           # (Entity: بيانات المنطقة وتوقعها)
│   │   │   └── insight_generator.dart    # (توليد الشرح النصي لتوقعات الـ AI)
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── map_cubit.dart
│   │       │   └── map_state_provider.dart # (حالة التكبير والعلامات)
│   │       ├── theme/
│   │       │   └── map_style_manager.dart  # (الوضع المظلم ووضع توفير الطاقة)
│   │       └── screens/
│   │           └── heatmap_screen.dart     # (الشاشة الرئيسية)
│   │
│   ├── trip_management/                  # خاصية: الرحلات والأرباح
│   │   ├── data/
│   │   │   ├── trip_repository_impl.dart   # (المنظم لحفظ الرحلات الأوفلاين والمزامنة)
│   │   │   └── offline_sync_manager.dart   # (مزامنة الرحلات عند عودة الإنترنت)
│   │   ├── domain/
│   │   │   ├── trip_entity.dart            # (Entity: تفاصيل الرحلة)
│   │   │   ├── fare_breakdown_generator.dart # (حساب الأجرة وخصم عمولة الـ 20%)
│   │   │   └── dispatch_rule.dart          # (قواعد التوجيه وتوزيع الرحلات)
│   │   └── presentation/
│   │       └── screens/
│   │           └── trip_history_screen.dart
│   │
│   ├── driver_performance/               # خاصية: أداء السائق والتحليلات
│   │   ├── domain/
│   │   │   ├── performance_monitor.dart    # (مراقبة الربحية والأداء العام)
│   │   │   └── achievement_manager.dart    # (نظام النقاط والـ Leaderboard)
│   │   └── presentation/
│   │       └── screens/
│   │           └── dashboard_screen.dart
│   │
│   ├── voice_assistant/                  # خاصية: المساعد الصوتي
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   └── voice_assistant_bloc.dart # (لإدارة تسجيل ومعالجة الصوت)
│   │       └── widgets/
│   │           └── voice_button_widget.dart
│   │
│   └── support_and_training/             # خاصية: الدعم الفني والتدريب
│       ├── domain/
│       │   ├── support_manager.dart        # (الأسئلة الشائعة وتذاكر الدعم)
│       │   └── tutorial_controller.dart    # (إدارة تشغيل الفيديوهات التعليمية)
│       └── presentation/
│           └── screens/
│               └── help_center_screen.dart
│
└── main.dart                             # نقطة انطلاق التطبيق (يتم فيها استدعاء ServiceLocator)
