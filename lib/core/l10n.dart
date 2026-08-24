import 'package:flutter/widgets.dart';

import 'app_scope.dart';

/// Lightweight localisation: a flat key -> translation map per language.
/// No code generation and no build step, which keeps the project easy to run.
const Map<String, Map<String, String>> _translations = <String, Map<String, String>>{
  'en': <String, String>{
    // ---------- generic ----------
    'app.name': 'AgriIntel AI',
    'app.tagline': 'AI in your pocket — for every field',
    'common.switchLang': 'العربية',
    'common.close': 'Close',
    'common.done': 'Done',
    'common.soon': 'Planned for the next phase',
    'common.demo': 'Prototype — the data on this screen is sample data.',

    // ---------- onboarding ----------
    'onb.title': 'Smarter decisions,\nfrom the phone you already own',
    'onb.subtitle':
        'Diagnose plant disease from a photo, ask an Arabic AI assistant, and plan irrigation, yield and sales. No sensors, no drones, no extra hardware.',
    'onb.f1': 'Disease diagnosis from a single leaf photo',
    'onb.f2': 'Arabic assistant that answers in seconds',
    'onb.f3': 'Yield forecast and irrigation schedule',
    'onb.f4': 'Live prices and buyer matching',
    'onb.cta': 'Get started',

    // ---------- navigation ----------
    'nav.home': 'Home',
    'nav.diagnose': 'Diagnose',
    'nav.assistant': 'Assistant',
    'nav.insights': 'Insights',
    'nav.market': 'Market',

    // ---------- dashboard ----------
    'dash.greeting': 'Good morning, {name}',
    'dash.weather': 'Today at your farm',
    'dash.temp': 'Temperature',
    'dash.humidity': 'Humidity',
    'dash.wind': 'Wind',
    'dash.rain': 'Rain chance',
    'dash.actions': "Today's actions",
    'dash.quick': 'Quick actions',
    'dash.recent': 'Recent diagnoses',
    'dash.empty': 'No diagnoses yet — scan your first leaf.',
    'dash.market': 'Market snapshot',
    'dash.viewAll': 'View all',
    'badge.now': 'Now',
    'badge.today': 'Today',
    'badge.week': 'This week',
    'act.irrigate.title': 'Irrigate block A tonight',
    'act.irrigate.body':
        '38 mm needed. Best window is 6–9 PM, when evaporation is lowest.',
    'act.spray.title': 'Hold off spraying tomorrow',
    'act.spray.body':
        'Wind at 24 km/h will scatter the spray. Wednesday looks calm.',
    'act.sell.title': 'Tomato prices are trending up',
    'act.sell.body':
        'Up 6.4% this week. Holding for about five more days is likely to pay off.',

    // ---------- diagnosis ----------
    'diag.title': 'Plant diagnosis',
    'diag.crop': 'Pick the crop',
    'diag.capture': 'Add a photo of the affected leaf',
    'diag.camera': 'Camera',
    'diag.gallery': 'Gallery',
    'diag.demoNote':
        'Demo build — a sample leaf image is used in place of the camera.',
    'diag.tips': 'For a more accurate result',
    'diag.tip1': 'Fill the frame with a single leaf.',
    'diag.tip2': 'Shoot in daylight and avoid hard shadows.',
    'diag.tip3': 'Include the healthy part next to the damaged part.',
    'diag.analyze': 'Analyze',
    'diag.retake': 'Change photo',
    'diag.s1': 'Uploading image…',
    'diag.s2': 'Running the vision model…',
    'diag.s3': 'Matching a treatment plan…',

    // ---------- result ----------
    'res.title': 'Diagnosis result',
    'res.confidence': 'Confidence',
    'res.severity': 'Severity',
    'sev.low': 'Low',
    'sev.medium': 'Moderate',
    'sev.high': 'Severe',
    'res.about': 'What it is',
    'res.treatment': 'Treatment plan',
    'res.prevention': 'Prevention',
    'res.lowTitle': 'Low-confidence result',
    'res.lowBody':
        'The model is not certain about this one. Send the case to an agronomist for review.',
    'res.expert': 'Request expert review',
    'res.expertSent': 'Sent — an agronomist will reply within 4 hours.',
    'res.save': 'Save to history',
    'res.saved': 'Saved to your history.',
    'res.ask': 'Ask the assistant about it',
    'res.healthy': 'No disease detected',

    // ---------- assistant ----------
    'asst.title': 'Agricultural assistant',
    'asst.subtitle': 'Answers grounded in an agricultural knowledge base',
    'asst.hint': 'Ask anything about your crop…',
    'asst.greeting':
        "Hello. I am your farm assistant — ask me about irrigation, fertiliser, pests, or planting dates.",
    'asst.typing': 'Assistant is typing…',
    'asst.listening': 'Listening…',
    'asst.voiceNote': 'Voice input (demo)',
    'asst.suggest': 'Try asking',
    'asst.escalate': 'Talk to a human agronomist',
    'asst.escalateBody':
        "I am not confident about this one. Should I forward it to an agronomist?",
    'asst.clear': 'Clear chat',
    'asst.q1': 'When do I irrigate the tomatoes?',
    'asst.q2': 'What fertiliser at flowering?',
    'asst.q3': 'How do I treat whitefly?',
    'asst.q4': 'Is this a good time to sell?',

    // ---------- insights ----------
    'ins.title': 'Yield & irrigation',
    'ins.yield': 'Expected yield',
    'ins.unit': 'ton / feddan',
    'ins.range': 'Likely range {a} – {b}',
    'ins.season': 'Season 2026',
    'ins.history': 'Yield across seasons',
    'ins.forecastTag': 'Forecast',
    'ins.irrigation': 'Irrigation schedule',
    'ins.next': 'Next irrigation',
    'ins.tonight': 'Tonight, 6–9 PM',
    'ins.skip': 'No irrigation',
    'ins.mm': 'mm',
    'ins.note':
        'Built from public weather forecasts and crop water-requirement models — no field sensors required.',
    'ins.weekWater': 'Water this week',
    'ins.savedWater': 'Saved vs. fixed schedule',

    // ---------- market ----------
    'mkt.title': 'Market',
    'mkt.prices': 'Prices',
    'mkt.offers': 'Buyers',
    'mkt.today': 'Today',
    'mkt.trend': '7-day trend',
    'mkt.forecast': 'Next week',
    'mkt.sell': 'Good time to sell',
    'mkt.hold': 'Better to hold',
    'mkt.perTon': 'EGP / ton',
    'mkt.openOffers': 'Open buyer offers',
    'mkt.grade': 'Grade',
    'mkt.qty': 'Quantity',
    'mkt.contact': 'Contact buyer',
    'mkt.gradeCta': 'Grade my produce from a photo',
    'mkt.gradeBody':
        'The vision model classifies produce quality (A / B / C) so you negotiate from a stronger position.',
    'mkt.ton': 'ton',

    // ---------- profile ----------
    'prof.title': 'Profile',
    'prof.settings': 'Settings',
    'prof.language': 'Language',
    'prof.theme': 'Dark mode',
    'prof.history': 'Diagnosis history',
    'prof.about': 'About this project',
    'prof.aboutBody':
        'AgriIntel AI is a software-only AgriTech platform: AI decision support for farmers with no sensors, drones or IoT kits — only the smartphone they already own.',
    'prof.modules': 'Modules',
    'prof.stack': 'Technology stack',
    'prof.version': 'Version',
    'prof.farmer': 'Farmer',
  },
  'ar': <String, String>{
    // ---------- generic ----------
    'app.name': 'أجري إنتل',
    'app.tagline': 'ذكاء اصطناعي في جيبك — لكل فدان',
    'common.switchLang': 'English',
    'common.close': 'إغلاق',
    'common.done': 'تمام',
    'common.soon': 'في المرحلة الجاية',
    'common.demo': 'نسخة تجريبية — البيانات في الشاشة دي بيانات توضيحية.',

    // ---------- onboarding ----------
    'onb.title': 'قرارات أذكى،\nمن الموبايل اللي معاك',
    'onb.subtitle':
        'شخّص أمراض النبات من صورة، واسأل مساعد ذكاء اصطناعي بالعربي، وخطّط للري والمحصول والبيع. من غير حساسات ولا درونز ولا أجهزة إضافية.',
    'onb.f1': 'تشخيص المرض من صورة ورقة واحدة',
    'onb.f2': 'مساعد بالعربي بيرد في ثواني',
    'onb.f3': 'توقّع المحصول وجدول الري',
    'onb.f4': 'أسعار لحظية وربط بالمشترين',
    'onb.cta': 'يلا نبدأ',

    // ---------- navigation ----------
    'nav.home': 'الرئيسية',
    'nav.diagnose': 'التشخيص',
    'nav.assistant': 'المساعد',
    'nav.insights': 'التحليلات',
    'nav.market': 'السوق',

    // ---------- dashboard ----------
    'dash.greeting': 'صباح الخير يا {name}',
    'dash.weather': 'الجو النهارده في الأرض',
    'dash.temp': 'الحرارة',
    'dash.humidity': 'الرطوبة',
    'dash.wind': 'الرياح',
    'dash.rain': 'احتمال المطر',
    'dash.actions': 'مهام النهارده',
    'dash.quick': 'اختصارات سريعة',
    'dash.recent': 'آخر التشخيصات',
    'dash.empty': 'لسه مفيش تشخيصات — صوّر أول ورقة.',
    'dash.market': 'نظرة على السوق',
    'dash.viewAll': 'الكل',
    'badge.now': 'دلوقتي',
    'badge.today': 'النهارده',
    'badge.week': 'الأسبوع ده',
    'act.irrigate.title': 'اسقي القطعة A بالليل',
    'act.irrigate.body': 'محتاجة ٣٨ مم. أنسب وقت من ٦ لـ ٩ مساءً، لما البخر يقل.',
    'act.spray.title': 'أجّل الرش بكرة',
    'act.spray.body': 'الرياح ٢٤ كم/س هتشتت الرش. يوم الأربع الجو هادي.',
    'act.sell.title': 'أسعار الطماطم طالعة',
    'act.sell.body': 'زادت ٦.٤٪ الأسبوع ده. الاستنى ٥ أيام كمان غالبًا في مصلحتك.',

    // ---------- diagnosis ----------
    'diag.title': 'تشخيص النبات',
    'diag.crop': 'اختار المحصول',
    'diag.capture': 'ضيف صورة للورقة المصابة',
    'diag.camera': 'الكاميرا',
    'diag.gallery': 'الاستوديو',
    'diag.demoNote': 'نسخة تجريبية — بنستخدم صورة ورقة جاهزة بدل الكاميرا.',
    'diag.tips': 'علشان النتيجة تطلع أدق',
    'diag.tip1': 'خلي الورقة مالية الصورة.',
    'diag.tip2': 'صوّر في ضوء النهار وابعد عن الظل القوي.',
    'diag.tip3': 'ظهّر الجزء السليم جنب الجزء المصاب.',
    'diag.analyze': 'حلّل الصورة',
    'diag.retake': 'غيّر الصورة',
    'diag.s1': 'بنرفع الصورة…',
    'diag.s2': 'بنشغّل نموذج الرؤية…',
    'diag.s3': 'بنجهّز خطة العلاج…',

    // ---------- result ----------
    'res.title': 'نتيجة التشخيص',
    'res.confidence': 'نسبة الثقة',
    'res.severity': 'شدة الإصابة',
    'sev.low': 'خفيفة',
    'sev.medium': 'متوسطة',
    'sev.high': 'شديدة',
    'res.about': 'إيه المرض ده',
    'res.treatment': 'خطة العلاج',
    'res.prevention': 'الوقاية',
    'res.lowTitle': 'نتيجة ثقتها منخفضة',
    'res.lowBody': 'النموذج مش متأكد من الحالة دي. ابعتها لمهندس زراعي يراجعها.',
    'res.expert': 'اطلب مراجعة خبير',
    'res.expertSent': 'اتبعتت — مهندس زراعي هيرد خلال ٤ ساعات.',
    'res.save': 'احفظ في السجل',
    'res.saved': 'اتحفظت في السجل.',
    'res.ask': 'اسأل المساعد عنها',
    'res.healthy': 'مفيش مرض ظاهر',

    // ---------- assistant ----------
    'asst.title': 'المساعد الزراعي',
    'asst.subtitle': 'إجاباته مبنية على قاعدة معرفة زراعية',
    'asst.hint': 'اسأل عن أي حاجة في زراعتك…',
    'asst.greeting':
        'أهلًا بيك. أنا مساعدك الزراعي — اسألني عن الري أو التسميد أو الآفات أو مواعيد الزراعة.',
    'asst.typing': 'المساعد بيكتب…',
    'asst.listening': 'بسمعك…',
    'asst.voiceNote': 'إدخال صوتي (تجريبي)',
    'asst.suggest': 'جرّب تسأل',
    'asst.escalate': 'كلّم مهندس زراعي',
    'asst.escalateBody': 'مش متأكد من الإجابة دي. أبعتها لمهندس زراعي؟',
    'asst.clear': 'امسح المحادثة',
    'asst.q1': 'أسقي الطماطم إمتى؟',
    'asst.q2': 'أسمّد بإيه وقت الإزهار؟',
    'asst.q3': 'أعالج الذبابة البيضاء إزاي؟',
    'asst.q4': 'الوقت مناسب للبيع؟',

    // ---------- insights ----------
    'ins.title': 'المحصول والري',
    'ins.yield': 'المحصول المتوقع',
    'ins.unit': 'طن / فدان',
    'ins.range': 'المدى المتوقع {a} – {b}',
    'ins.season': 'موسم ٢٠٢٦',
    'ins.history': 'المحصول عبر المواسم',
    'ins.forecastTag': 'متوقع',
    'ins.irrigation': 'جدول الري',
    'ins.next': 'الرية الجاية',
    'ins.tonight': 'الليلة، ٦–٩ مساءً',
    'ins.skip': 'مفيش ري',
    'ins.mm': 'مم',
    'ins.note':
        'محسوبة من توقعات الطقس العامة ونماذج احتياج المحصول للمياه — من غير أي حساسات في الأرض.',
    'ins.weekWater': 'مياه الأسبوع',
    'ins.savedWater': 'التوفير مقارنة بجدول ثابت',

    // ---------- market ----------
    'mkt.title': 'السوق',
    'mkt.prices': 'الأسعار',
    'mkt.offers': 'المشترين',
    'mkt.today': 'النهارده',
    'mkt.trend': 'آخر ٧ أيام',
    'mkt.forecast': 'الأسبوع الجاي',
    'mkt.sell': 'وقت كويس للبيع',
    'mkt.hold': 'الأفضل تستنى',
    'mkt.perTon': 'جنيه / طن',
    'mkt.openOffers': 'عروض شراء متاحة',
    'mkt.grade': 'الرتبة',
    'mkt.qty': 'الكمية',
    'mkt.contact': 'كلّم المشتري',
    'mkt.gradeCta': 'قيّم محصولي من صورة',
    'mkt.gradeBody':
        'نموذج الرؤية بيصنّف جودة المحصول (أ / ب / ج) علشان تتفاوض من موقف أقوى.',
    'mkt.ton': 'طن',

    // ---------- profile ----------
    'prof.title': 'الحساب',
    'prof.settings': 'الإعدادات',
    'prof.language': 'اللغة',
    'prof.theme': 'الوضع الليلي',
    'prof.history': 'سجل التشخيصات',
    'prof.about': 'عن المشروع',
    'prof.aboutBody':
        'أجري إنتل منصة زراعية سوفتوير بالكامل: دعم قرار بالذكاء الاصطناعي للفلاح من غير حساسات ولا درونز ولا أجهزة IoT — بالموبايل اللي معاه بس.',
    'prof.modules': 'الوحدات',
    'prof.stack': 'التقنيات المستخدمة',
    'prof.version': 'الإصدار',
    'prof.farmer': 'المزارع',
  },
};

extension L10n on BuildContext {
  /// Current language code, driven by [AppState.locale].
  String get lang => AppScope.of(this).isArabic ? 'ar' : 'en';

  bool get isArabic => lang == 'ar';

  /// Translates [key], falling back to English and then to the key itself.
  String tr(String key) {
    final Map<String, String>? table = _translations[lang];
    return table?[key] ?? _translations['en']?[key] ?? key;
  }

  /// Same as [tr] with `{placeholder}` substitution.
  String trf(String key, Map<String, String> values) {
    String result = tr(key);
    values.forEach((String k, String v) {
      result = result.replaceAll('{$k}', v);
    });
    return result;
  }

  /// Picks the right side of a bilingual value coming from the data layer.
  String pick(Map<String, String> pair) => pair[lang] ?? pair['en'] ?? '';
}
