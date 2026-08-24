# AgriIntel AI — Flutter Front-End

واجهة تطبيق موبايل (Flutter) لمشروع **Artificial Intelligence in Agriculture (AgriTech)**.
التطبيق ثنائي اللغة (عربي RTL / إنجليزي LTR) بزرار تبديل في كل شاشة، ومبني بالكامل من
غير أي مكتبات خارجية — Flutter SDK بس.

Front-end prototype for the AgriIntel AI proposal: an AI decision-support app for
farmers that needs no sensors, drones or IoT kits — only a smartphone.

---

## الشاشات / Screens

| # | الشاشة | يغطي أي بند في الـ proposal |
|---|--------|------------------------------|
| 1 | Onboarding | Executive Summary + Objectives |
| 2 | Dashboard | الطقس، مهام اليوم، اختصارات، نظرة على السوق |
| 3 | Diagnose | 4.1 Plant Disease Diagnosis (Computer Vision) |
| 4 | Result | نسبة الثقة + شدة الإصابة + خطة العلاج + مسار مراجعة الخبير |
| 5 | Assistant | 4.2 Arabic Conversational Assistant (NLP) + إدخال صوتي |
| 6 | Insights | 4.3 Yield Prediction & Irrigation Scheduling |
| 7 | Market | 4.4 Price Forecasting & Smart Marketplace |
| 8 | Profile | الإعدادات + وحدات المشروع + الـ tech stack |

نقاط مهمة اتظبطت علشان المناقشة:

- **نسبة الثقة** ظاهرة مع كل تشخيص، ولما تقل عن ٧٠٪ بيظهر مسار **طلب مراجعة مهندس زراعي**
  (جرّب محصول القمح — نتيجته ٥٨٪ مخصوص علشان تعرض المسار ده).
- **المساعد** بيجاوب من قاعدة معرفة (١٠ مواضيع)، ولو مالقاش إجابة بيعرض تحويل لخبير
  بدل ما يخترع إجابة — نفس فكرة الـ RAG في الـ proposal.
- **الري** محسوب من توقعات الطقس، وفيه أيام "مفيش ري" بسبب المطر — إثبات إن الحل
  software-only من غير حساسات.

## التشغيل / Running the app

Flutter متسطّب على الجهاز ده في `E:\dev\flutter` ومضاف للـ PATH (يوزر)، والـ pub cache
على `E:\dev\pub-cache` (علشان بارتيشن C: ضيّق). النسخة: **Flutter 3.47.0 / Dart 3.13.0**.
مجلد `web/` متولّد بالفعل.

**شوف التطبيق على المتصفح** — أسرع طريقة:

```bash
flutter run -d chrome
```

**أو من نسخة مبنية على localhost** (اللي شغالة دلوقتي على المنفذ 5174):

```bash
flutter build web --release
```

```bash
node preview/server.js build/web 5174
```

**تشغيل على موبايل أندرويد**: مجلد `android/` لسه متولّدش. ولّده من غير ما تمسح الكود:

```bash
flutter create --project-name agriintel_ai --platforms=android "$env:TEMP\agri_scaffold"
```

```bash
robocopy "$env:TEMP\agri_scaffold\android" ".\android" /E
```

> متشغّلش `flutter create .` جوه مجلد المشروع — الأمر ده بيستبدل `lib/main.dart`
> بالقالب الافتراضي ويمسح الكود. النسخ من مشروع مؤقت هو الطريقة الآمنة.

**فحص الكود والتستات**:

```bash
flutter analyze
```

```bash
flutter test
```

`analyze` بيطلع **No issues found**، و`test` فيه ٦ widget tests بتغطي:
الأونبوردنج، تبديل اللغة وRTL، مسار الثقة المنخفضة للقمح، الحفظ في السجل،
إجابة المساعد من قاعدة المعرفة، والتحويل لمهندس لما ميعرفش يجاوب.

## معاينة HTML (من غير Flutter)

نسخة `preview/index.html` بتحاكي نفس التصميم والبيانات وبتشتغل في أي متصفح — مفيدة
للعرض السريع أو لو الجهاز مفيهوش Flutter:

```bash
node preview/server.js
```

ثم افتح <http://localhost:5173>

## بنية الكود / Project structure

```
lib/
  main.dart                 نقطة البداية
  app.dart                  MaterialApp + اللغة + الثيم
  core/
    app_state.dart          الحالة المشتركة (لغة، ثيم، تبويب، سجل التشخيصات)
    app_scope.dart          InheritedNotifier لتوصيل الحالة لكل الشاشات
    app_theme.dart          الألوان والثيم (فاتح/داكن)
    l10n.dart               كل النصوص عربي/إنجليزي + context.tr()
  data/
    models.dart             الموديلات (Crop, DiseaseInfo, PriceSeries, …)
    mock_data.dart          البيانات التجريبية + قاعدة معرفة المساعد
  widgets/
    common.dart             الكروت والأزرار وشكل الورقة المرسومة
    charts.dart             الرسوم البيانية (مرسومة بـ CustomPainter)
  screens/                  الشاشات الثمانية
test/
  app_test.dart             ٦ widget tests على الفلوهات الأساسية
preview/
  index.html                معاينة HTML بنفس التصميم (من غير Flutter)
  server.js                 سيرفر ستاتيك بدون أي مكتبات
```

## ربط الـ Backend لاحقًا

كل البيانات جاية من `lib/data/mock_data.dart` بس. علشان توصله بالـ FastAPI backend:

1. اعمل `lib/data/api_client.dart` فيه دوال `Future<DiseaseInfo> diagnose(File image)` و
   `Future<String> ask(String question)` … إلخ.
2. استبدل نداءات `MockData.*` في الشاشات بنداءات الـ API مع `FutureBuilder`.
3. لتصوير حقيقي من الكاميرا ضيف `image_picker` في `pubspec.yaml` وبدّل دالة
   `_pickPhoto` في `lib/screens/diagnose_screen.dart`.

الموديلات في `models.dart` متطابقة مع الـ JSON المتوقع من الـ backend، فالتغيير محصور
في طبقة البيانات.

---

Prototype only — the data shown in the app is sample data, not live measurements.
