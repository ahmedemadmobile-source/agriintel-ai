import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import 'models.dart';

/// Everything the prototype shows. In the real product each list here is
/// replaced by a call to the FastAPI backend described in the proposal.
class MockData {
  const MockData._();

  // ---------------------------------------------------------------- farmer
  static const Bilingual farmerName = <String, String>{
    'ar': 'أحمد',
    'en': 'Ahmed',
  };

  static const Bilingual farmName = <String, String>{
    'ar': 'مزرعة النصر · البحيرة',
    'en': 'El-Nasr Farm · Beheira',
  };

  // ---------------------------------------------------------------- weather
  static const String temperature = '31°';
  static const String humidity = '58%';
  static const String wind = '24 km/h';
  static const String rainChance = '15%';

  // ------------------------------------------------------------------ crops
  static const List<Crop> crops = <Crop>[
    Crop(
      id: 'tomato',
      name: <String, String>{'ar': 'طماطم', 'en': 'Tomato'},
      icon: Icons.local_florist,
      color: Color(0xFFD24B3E),
    ),
    Crop(
      id: 'potato',
      name: <String, String>{'ar': 'بطاطس', 'en': 'Potato'},
      icon: Icons.spa,
      color: Color(0xFFB07A2E),
    ),
    Crop(
      id: 'wheat',
      name: <String, String>{'ar': 'قمح', 'en': 'Wheat'},
      icon: Icons.grass,
      color: Color(0xFFCB9B1E),
    ),
    Crop(
      id: 'maize',
      name: <String, String>{'ar': 'ذرة', 'en': 'Maize'},
      icon: Icons.eco,
      color: Color(0xFF7CA82B),
    ),
    Crop(
      id: 'citrus',
      name: <String, String>{'ar': 'موالح', 'en': 'Citrus'},
      icon: Icons.park,
      color: Color(0xFFE08E0B),
    ),
    Crop(
      id: 'grape',
      name: <String, String>{'ar': 'عنب', 'en': 'Grapes'},
      icon: Icons.agriculture,
      color: Color(0xFF7B4B94),
    ),
  ];

  static Crop cropById(String id) =>
      crops.firstWhere((Crop c) => c.id == id, orElse: () => crops.first);

  // --------------------------------------------------------------- diseases
  static const List<DiseaseInfo> diseases = <DiseaseInfo>[
    DiseaseInfo(
      id: 'early_blight',
      cropId: 'tomato',
      name: <String, String>{
        'ar': 'اللفحة المبكرة',
        'en': 'Early blight',
      },
      scientificName: 'Alternaria solani',
      summary: <String, String>{
        'ar':
            'مرض فطري بيبدأ على الأوراق السفلية على شكل بقع بنية دايرية بحلقات جوّاها زي هدف السهام، وبيزيد مع الرطوبة العالية والحرارة من ٢٤ لـ ٢٩ درجة. لو اتساب بيوصل للساق والثمار ويقلل المحصول لحد ٣٠٪.',
        'en':
            'A fungal disease that starts on the lower leaves as brown circular lesions with concentric rings. It spreads under high humidity at 24–29 °C and, left untreated, reaches stems and fruit and can cut yield by up to 30%.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'شيل الأوراق المصابة واحرقها بعيد عن الأرض — متسبهاش بين الخطوط.',
          'en':
              'Remove infected leaves and burn them away from the field — do not leave them between the rows.',
        },
        <String, String>{
          'ar':
              'رش مبيد فطري نحاسي أو مانكوزيب كل ٧–١٠ أيام، ٣ رشات على الأقل.',
          'en':
              'Spray a copper-based fungicide or mancozeb every 7–10 days, at least three applications.',
        },
        <String, String>{
          'ar': 'قلل الري بالرش من فوق وحوّل للتنقيط علشان الورق يفضل جاف.',
          'en':
              'Cut overhead irrigation and switch to drip so the foliage stays dry.',
        },
        <String, String>{
          'ar': 'راقب النباتات المجاورة يوميًا لمدة أسبوعين بعد أول رشة.',
          'en':
              'Check neighbouring plants daily for two weeks after the first spray.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'دورة زراعية ٢–٣ سنين ومتزرعش طماطم ورا بطاطس.',
          'en':
              'Rotate crops on a 2–3 year cycle and never plant tomato straight after potato.',
        },
        <String, String>{
          'ar': 'باعد بين النباتات علشان الهواء يعدي ويجفف الورق بسرعة.',
          'en':
              'Space plants so air moves through the canopy and dries the leaves quickly.',
        },
        <String, String>{
          'ar': 'استخدم أصناف مقاومة وشتلات من مصدر موثوق.',
          'en': 'Use resistant varieties and seedlings from a trusted source.',
        },
      ],
      confidence: 0.94,
      severity: Severity.medium,
    ),
    DiseaseInfo(
      id: 'late_blight',
      cropId: 'potato',
      name: <String, String>{
        'ar': 'اللفحة المتأخرة',
        'en': 'Late blight',
      },
      scientificName: 'Phytophthora infestans',
      summary: <String, String>{
        'ar':
            'من أخطر أمراض البطاطس. بقع مائية غامقة بتكبر بسرعة وحواليها هالة بيضا تحت الورقة في الجو الرطب. بينتشر في أيام ويقدر يضيّع الحقل كله لو الجو فضل رطب وبارد.',
        'en':
            'The most destructive potato disease. Dark water-soaked lesions expand fast, with a white halo on the leaf underside in humid weather. It can take a whole field within days in cool, wet conditions.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'ابدأ رش وقائي فوري بمبيد جهازي (ميتالاكسيل + مانكوزيب).',
          'en':
              'Start an immediate systemic spray programme (metalaxyl + mancozeb).',
        },
        <String, String>{
          'ar': 'اقطع الري تمامًا لمدة ٣ أيام وحسّن الصرف في الجور المصابة.',
          'en':
              'Stop irrigation completely for three days and improve drainage in affected spots.',
        },
        <String, String>{
          'ar': 'اقلع النباتات المصابة بجذورها وابعدها عن الأرض.',
          'en': 'Pull out infected plants with their roots and remove them from the field.',
        },
        <String, String>{
          'ar': 'أجّل الحصاد أسبوعين بعد آخر رشة لحد ما القشرة تتماسك.',
          'en':
              'Delay harvest for two weeks after the last spray so the skin sets.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'تقاوي معتمدة خالية من الإصابة وتخزين بارد جاف.',
          'en': 'Certified disease-free seed tubers and cool, dry storage.',
        },
        <String, String>{
          'ar': 'ترديم عالي على الخطوط علشان الدرنات متتعرضش للجراثيم.',
          'en': 'Hill the ridges high so tubers are not exposed to spores.',
        },
        <String, String>{
          'ar': 'تابع تنبيهات الرطوبة — الخطر بيعلى فوق ٩٠٪ رطوبة.',
          'en': 'Watch humidity alerts — risk climbs above 90% relative humidity.',
        },
      ],
      confidence: 0.91,
      severity: Severity.high,
    ),
    DiseaseInfo(
      id: 'yellow_rust',
      cropId: 'wheat',
      name: <String, String>{
        'ar': 'الصدأ الأصفر (يحتاج تأكيد)',
        'en': 'Yellow rust (needs confirmation)',
      },
      scientificName: 'Puccinia striiformis',
      summary: <String, String>{
        'ar':
            'الصورة بتوحي بخطوط صفرا برتقالية متوازية مع عروق الورقة، وده نمط الصدأ الأصفر. بس جودة الصورة والإضاءة خلت النموذج مش متأكد — ممكن يكون نقص عناصر أو أثر رش.',
        'en':
            'The image suggests yellow-orange stripes running parallel to the leaf veins, the classic yellow-rust pattern. Image quality and lighting left the model uncertain — it could also be a nutrient deficiency or spray residue.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'ابعت الحالة لمهندس زراعي للمراجعة قبل أي رش.',
          'en': 'Send the case to an agronomist for review before spraying anything.',
        },
        <String, String>{
          'ar': 'صوّر ٣ ورقات تانية في ضوء النهار وأعد التحليل.',
          'en': 'Photograph three more leaves in daylight and run the analysis again.',
        },
        <String, String>{
          'ar': 'لو اتأكد: رش تيبوكونازول في طور ظهور ورقة العلم.',
          'en': 'If confirmed: apply tebuconazole at the flag-leaf stage.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'أصناف مقاومة وميعاد زراعة مبكر يقلل فترة التعرض.',
          'en': 'Resistant varieties and early sowing shorten the exposure window.',
        },
        <String, String>{
          'ar': 'متزودش التسميد الأزوتي — بيزوّد الإصابة.',
          'en': 'Avoid excess nitrogen — it increases infection.',
        },
      ],
      confidence: 0.58,
      severity: Severity.medium,
    ),
    DiseaseInfo(
      id: 'northern_leaf_blight',
      cropId: 'maize',
      name: <String, String>{
        'ar': 'لفحة أوراق الذرة',
        'en': 'Northern leaf blight',
      },
      scientificName: 'Exserohilum turcicum',
      summary: <String, String>{
        'ar':
            'بقع طويلة رمادية مايلة للبني شكلها زي السيجار على الأوراق، بتبدأ من تحت وتطلع لفوق. بتقلل مساحة التمثيل الضوئي وبالتالي وزن الكيزان.',
        'en':
            'Long grey-brown cigar-shaped lesions on the leaves, starting low and moving up. They cut photosynthetic area and therefore cob weight.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'رش مبيد فطري (أزوكسيستروبين) لو الإصابة قبل طور الحرير.',
          'en':
              'Apply a strobilurin fungicide (azoxystrobin) if infection appears before silking.',
        },
        <String, String>{
          'ar': 'قلل كثافة الزراعة في الموسم الجاي لتحسين التهوية.',
          'en': 'Reduce plant density next season to improve air flow.',
        },
        <String, String>{
          'ar': 'ادفن بقايا المحصول بعد الحصاد بالحرث العميق.',
          'en': 'Bury crop residue after harvest with deep ploughing.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'هجن مقاومة ودورة زراعية مع محصول مش نجيلي.',
          'en': 'Resistant hybrids and rotation with a non-grass crop.',
        },
        <String, String>{
          'ar': 'ري متوازن ومتسبش الأرض رطبة لفترة طويلة.',
          'en': 'Balanced irrigation — do not leave the field wet for long spells.',
        },
      ],
      confidence: 0.88,
      severity: Severity.medium,
    ),
    DiseaseInfo(
      id: 'leaf_miner',
      cropId: 'citrus',
      name: <String, String>{
        'ar': 'صانعة أنفاق الموالح',
        'en': 'Citrus leaf miner',
      },
      scientificName: 'Phyllocnistis citrella',
      summary: <String, String>{
        'ar':
            'أنفاق فضية متعرجة جوه الورقة الحديثة مع التفاف في الحواف. الضرر الأكبر على الأشجار الصغيرة والطرود الجديدة، وبيفتح الباب للتقرح الحمضي.',
        'en':
            'Silvery winding tunnels inside young leaves with curled edges. Damage is worst on young trees and new flush, and it opens the door to citrus canker.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'رش زيت معدني صيفي ١٪ على الطرود الحديثة كل ١٠ أيام.',
          'en': 'Spray 1% summer mineral oil on new flush every 10 days.',
        },
        <String, String>{
          'ar': 'قص الطرود المصابة بشدة وتخلص منها.',
          'en': 'Prune heavily infested shoots and dispose of them.',
        },
        <String, String>{
          'ar': 'حافظ على الأعداء الحيوية ومتستخدمش مبيدات واسعة المدى.',
          'en':
              'Protect natural enemies — avoid broad-spectrum insecticides.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'وحّد مواعيد التسميد علشان الطرود تطلع مرة واحدة وتسهل حمايتها.',
          'en':
              'Synchronise fertilisation so flush appears in one wave and is easier to protect.',
        },
        <String, String>{
          'ar': 'مصايد فرمونية للمتابعة المبكرة.',
          'en': 'Pheromone traps for early monitoring.',
        },
      ],
      confidence: 0.93,
      severity: Severity.low,
    ),
    DiseaseInfo(
      id: 'powdery_mildew',
      cropId: 'grape',
      name: <String, String>{
        'ar': 'البياض الدقيقي',
        'en': 'Powdery mildew',
      },
      scientificName: 'Erysiphe necator',
      summary: <String, String>{
        'ar':
            'طبقة بيضا زي البودرة على الأوراق والعناقيد، بتخلي الحبات تتشقق وتفقد قيمتها التسويقية. بينشط في الجو الدافي الجاف مع ظل كثيف.',
        'en':
            'A white powdery layer on leaves and clusters that cracks the berries and destroys their market value. It thrives in warm dry weather with dense shade.',
      },
      treatment: <Bilingual>[
        <String, String>{
          'ar': 'كبريت ميكروني رشًا أو تعفيرًا في الصباح الباكر.',
          'en': 'Micronised sulphur, sprayed or dusted early in the morning.',
        },
        <String, String>{
          'ar': 'خفّف الأوراق حوالين العناقيد علشان الشمس والهواء يوصلوا.',
          'en': 'Thin the leaves around the clusters to let in sun and air.',
        },
        <String, String>{
          'ar': 'كرر الرش كل ١٠–١٤ يوم لحد بداية التلوين.',
          'en': 'Repeat every 10–14 days until veraison.',
        },
      ],
      prevention: <Bilingual>[
        <String, String>{
          'ar': 'تقليم شتوي منتظم وتربية تسمح بدخول الضوء.',
          'en': 'Regular winter pruning and a training system that admits light.',
        },
        <String, String>{
          'ar': 'رشة كبريت وقائية مع بداية النمو الخضري.',
          'en': 'A preventive sulphur spray at the start of vegetative growth.',
        },
      ],
      confidence: 0.90,
      severity: Severity.medium,
    ),
  ];

  static DiseaseInfo diagnosisFor(String cropId) => diseases.firstWhere(
        (DiseaseInfo d) => d.cropId == cropId,
        orElse: () => diseases.first,
      );

  // ----------------------------------------------------------- assistant KB
  static const List<KnowledgeEntry> knowledgeBase = <KnowledgeEntry>[
    KnowledgeEntry(
      keywords: <String>['ري', 'اسقي', 'أسقي', 'سقي', 'مياه', 'irrigat', 'water'],
      answer: <String, String>{
        'ar':
            'للطماطم في مرحلة الإثمار: رية كل ٣ أيام تقريبًا بمعدل ٣٥–٤٠ مم. الأفضل تسقي بعد المغرب علشان البخر يقل، ولو فيه مطر متوقع خلال ٢٤ ساعة أجّل الرية ووفّر المياه.',
        'en':
            'For tomato at fruiting stage: irrigate roughly every 3 days at 35–40 mm. Water after sunset to cut evaporation, and skip the round if rain is forecast within 24 hours.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['سماد', 'تسميد', 'أسمّد', 'إزهار', 'fertil', 'npk'],
      answer: <String, String>{
        'ar':
            'في النمو الخضري استخدم نسبة نيتروجين أعلى (٢٠-١٠-١٠)، ومع بداية الإزهار حوّل لـ (١٥-١٥-٣٠) علشان تدعم العقد وحجم الثمرة. قسّم الجرعة على مرتين بدل مرة واحدة، وضيف كالسيوم وبورون رشًا لتقليل عفن الطرف الزهري.',
        'en':
            'During vegetative growth use a higher nitrogen ratio (20-10-10); at flowering switch to 15-15-30 to support fruit set and size. Split the dose in two instead of one, and add foliar calcium and boron to limit blossom-end rot.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['لفحة', 'بقع', 'فطر', 'blight', 'spot', 'fungus'],
      answer: <String, String>{
        'ar':
            'البقع البنية الدايرية بحلقات على الأوراق السفلية غالبًا لفحة مبكرة. شيل الأوراق المصابة واحرقها، ورش مبيد فطري نحاسي كل ٧–١٠ أيام، وقلل الري من فوق. ولو البقع مائية غامقة وبتكبر بسرعة، دي لفحة متأخرة وبتحتاج تدخل فوري.',
        'en':
            'Brown circular lesions with rings on the lower leaves usually mean early blight. Remove and burn infected leaves, spray a copper fungicide every 7–10 days, and reduce overhead watering. If the lesions are dark, water-soaked and spreading fast, that is late blight and needs immediate action.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['ميعاد', 'مواعيد', 'زراعة', 'أزرع', 'شتل', 'plant', 'sow'],
      answer: <String, String>{
        'ar':
            'أنسب ميعاد لشتل الطماطم في الوجه البحري: العروة الصيفي من منتصف فبراير لنص مارس، والعروة الخريفي من يوليو لأغسطس. تجنب الشتل في موجة حر فوق ٣٨ درجة لأن العقد بيقل جدًا.',
        'en':
            'Best tomato transplanting window in the Nile Delta: mid-February to mid-March for the summer season, and July to August for the autumn season. Avoid transplanting during heat waves above 38 °C — fruit set drops sharply.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['ذبابة', 'حشرة', 'آفة', 'دودة', 'whitefly', 'pest', 'insect', 'aphid'],
      answer: <String, String>{
        'ar':
            'الذبابة البيضاء بتقعد تحت الأوراق. علّق مصايد صفرا لاصقة (١٠ للفدان)، ورش صابون زراعي أو زيت نيم كل ٥ أيام مع تغطية السطح السفلي للورق، وشيل الحشائش حوالين الأرض لأنها بتأوي الحشرة. راقب كمان الفيروسات اللي بتنقلها زي تجعد الأوراق الصفراء.',
        'en':
            'Whitefly sits on the leaf underside. Hang yellow sticky traps (10 per feddan), spray insecticidal soap or neem oil every 5 days covering the underside, and clear weeds around the field since they host the insect. Watch for the viruses it transmits, such as yellow leaf curl.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['سعر', 'أسعار', 'أبيع', 'لبيع', 'هبيع', 'السوق', 'price', 'sell', 'market'],
      answer: <String, String>{
        'ar':
            'سعر الطماطم النهارده ٩٨٠٠ جنيه للطن، طالع ٦.٤٪ عن الأسبوع اللي فات، والتوقع القصير إنه يزيد ٣–٥٪ الأسبوع الجاي. لو عندك تخزين مناسب، الاستنى ٤–٥ أيام غالبًا أفضل. تقدر تشوف التفاصيل في تبويب السوق.',
        'en':
            'Tomato is at 9,800 EGP per ton today, up 6.4% week-on-week, and the short-term forecast points to another 3–5% next week. If you have suitable storage, waiting 4–5 days is likely the better call. Full details are in the Market tab.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['ملوحة', 'تربة', 'أرض', 'soil', 'salin', 'ec'],
      answer: <String, String>{
        'ar':
            'لو ظهر احتراق على أطراف الأوراق مع تقزم، اعمل تحليل تربة لقياس الـ EC. الحل السريع رية غسيل غزيرة مع تحسين الصرف، وبعدها ضيف مادة عضوية (كمبوست ٤–٦ م³ للفدان) لرفع قدرة التربة على الاحتفاظ بالعناصر.',
        'en':
            'If you see leaf-edge burn with stunted growth, run a soil test for EC. The quick fix is a heavy leaching irrigation plus better drainage, followed by organic matter (4–6 m³ of compost per feddan) to raise the soil exchange capacity.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['الجو', 'طقس', 'مطر', 'حرارة', 'weather', 'rain', 'temperature'],
      answer: <String, String>{
        'ar':
            'توقعات الأسبوع: ٢٩–٣٤ درجة نهارًا، رطوبة حوالين ٥٥٪، واحتمال مطر خفيف يوم الخميس. الحرارة مع الرطوبة دي بتزوّد خطر الأمراض الفطرية — راقب الأوراق السفلية وقلل الري بالرش.',
        'en':
            'This week: 29–34 °C by day, humidity around 55%, with a chance of light rain on Thursday. That heat-plus-humidity combination raises fungal disease risk — watch the lower leaves and reduce overhead irrigation.',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['جرعة', 'مبيد', 'رش', 'dose', 'spray', 'pesticide'],
      answer: <String, String>{
        'ar':
            'التزم بالجرعة المكتوبة على العبوة ومتزودهاش. رش في الصباح الباكر أو قبل المغرب والرياح تحت ١٥ كم/س، وغيّر المجموعة الكيماوية كل رشتين علشان متعملش مقاومة، والتزم بفترة الأمان قبل الحصاد (٧–١٤ يوم حسب المبيد).',
        'en':
            'Stick to the label rate and do not exceed it. Spray early morning or before sunset with wind under 15 km/h, rotate the chemical group every two applications to avoid resistance, and respect the pre-harvest interval (7–14 days depending on the product).',
      },
    ),
    KnowledgeEntry(
      keywords: <String>['اصفرار', 'صفرا', 'أصفر', 'yellow', 'chloros'],
      answer: <String, String>{
        'ar':
            'اصفرار الأوراق القديمة الأول غالبًا نقص نيتروجين. اصفرار الأوراق الحديثة مع بقاء العروق خضرا = نقص حديد. أما لو الاصفرار مع ذبول من ناحية واحدة، شك في الفيوزاريوم واعزل النبات فورًا.',
        'en':
            'Yellowing that starts on older leaves usually means nitrogen deficiency. Yellowing on young leaves with veins staying green means iron deficiency. If yellowing comes with one-sided wilting, suspect fusarium and isolate the plant immediately.',
      },
    ),
  ];

  /// Short keywords (2–3 letters, e.g. "ري") must match a whole word, otherwise
  /// they fire inside unrelated words — "أشتري" would trigger the irrigation
  /// answer. Longer keywords still match as a substring so that prefixes and
  /// suffixes ("الطماطم", "irrigation") keep working.
  static bool _matches(String question, String keyword) {
    final String k = keyword.toLowerCase();
    if (k.length > 3) return question.contains(k);
    final List<String> words =
        question.split(RegExp(r'[^\p{L}]+', unicode: true));
    return words.any((String w) =>
        w == k || w == 'ال$k' || w == 'و$k' || w == 'ب$k' || w == 'لل$k');
  }

  static String? answerFor(String question, String lang) {
    final String q = question.toLowerCase();
    for (final KnowledgeEntry entry in knowledgeBase) {
      for (final String keyword in entry.keywords) {
        if (_matches(q, keyword)) {
          return entry.answer[lang] ?? entry.answer['en'];
        }
      }
    }
    return null;
  }

  // -------------------------------------------------------------- insights
  static const double expectedYield = 11.3;
  static const double yieldRangeLow = 10.4;
  static const double yieldRangeHigh = 12.1;
  static const double yieldConfidence = 0.86;

  static const List<YieldPoint> yieldHistory = <YieldPoint>[
    YieldPoint(label: '2021', value: 8.4),
    YieldPoint(label: '2022', value: 9.1),
    YieldPoint(label: '2023', value: 8.8),
    YieldPoint(label: '2024', value: 9.6),
    YieldPoint(label: '2025', value: 10.2),
    YieldPoint(label: '2026', value: 11.3, forecast: true),
  ];

  static const List<IrrigationDay> irrigationWeek = <IrrigationDay>[
    IrrigationDay(
      day: <String, String>{'ar': 'الأحد', 'en': 'Sun'},
      millimetres: 38,
      note: <String, String>{
        'ar': 'الرية الأساسية — بعد المغرب',
        'en': 'Main round — after sunset',
      },
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'الاتنين', 'en': 'Mon'},
      millimetres: 0,
      note: <String, String>{'ar': 'التربة لسه محتفظة بالرطوبة', 'en': 'Soil still holds moisture'},
      skip: true,
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'التلات', 'en': 'Tue'},
      millimetres: 26,
      note: <String, String>{'ar': 'رية خفيفة صباحًا', 'en': 'Light morning round'},
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'الأربع', 'en': 'Wed'},
      millimetres: 0,
      note: <String, String>{'ar': 'مطر متوقع ٦ مم', 'en': '6 mm of rain expected'},
      skip: true,
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'الخميس', 'en': 'Thu'},
      millimetres: 34,
      note: <String, String>{'ar': 'تعويض بعد المطر', 'en': 'Top-up after the rain'},
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'الجمعة', 'en': 'Fri'},
      millimetres: 0,
      note: <String, String>{'ar': 'راحة', 'en': 'Rest day'},
      skip: true,
    ),
    IrrigationDay(
      day: <String, String>{'ar': 'السبت', 'en': 'Sat'},
      millimetres: 40,
      note: <String, String>{'ar': 'موجة حر متوقعة', 'en': 'Heat wave expected'},
    ),
  ];

  // ---------------------------------------------------------------- market
  static const List<PriceSeries> prices = <PriceSeries>[
    PriceSeries(
      cropId: 'tomato',
      name: <String, String>{'ar': 'طماطم', 'en': 'Tomato'},
      today: 9800,
      changePct: 6.4,
      forecastPct: 4.2,
      lastWeek: <double>[9100, 9150, 9280, 9350, 9520, 9640, 9800],
    ),
    PriceSeries(
      cropId: 'potato',
      name: <String, String>{'ar': 'بطاطس', 'en': 'Potato'},
      today: 7250,
      changePct: -2.1,
      forecastPct: -1.4,
      lastWeek: <double>[7480, 7430, 7390, 7350, 7300, 7280, 7250],
    ),
    PriceSeries(
      cropId: 'wheat',
      name: <String, String>{'ar': 'قمح', 'en': 'Wheat'},
      today: 12500,
      changePct: 1.2,
      forecastPct: 0.6,
      lastWeek: <double>[12340, 12360, 12400, 12380, 12440, 12470, 12500],
    ),
    PriceSeries(
      cropId: 'maize',
      name: <String, String>{'ar': 'ذرة', 'en': 'Maize'},
      today: 9150,
      changePct: 0.8,
      forecastPct: 2.3,
      lastWeek: <double>[9080, 9060, 9090, 9110, 9100, 9130, 9150],
    ),
    PriceSeries(
      cropId: 'citrus',
      name: <String, String>{'ar': 'موالح', 'en': 'Citrus'},
      today: 6400,
      changePct: -3.5,
      forecastPct: -2.0,
      lastWeek: <double>[6630, 6600, 6540, 6510, 6470, 6420, 6400],
    ),
    PriceSeries(
      cropId: 'grape',
      name: <String, String>{'ar': 'عنب', 'en': 'Grapes'},
      today: 18200,
      changePct: 4.0,
      forecastPct: 3.1,
      lastWeek: <double>[17500, 17600, 17750, 17900, 18000, 18100, 18200],
    ),
  ];

  static const List<MarketOffer> offers = <MarketOffer>[
    MarketOffer(
      buyer: <String, String>{'ar': 'شركة الدلتا للتصدير', 'en': 'Delta Export Co.'},
      crop: <String, String>{'ar': 'طماطم', 'en': 'Tomato'},
      grade: 'A',
      pricePerTon: 10200,
      tons: 25,
      location: <String, String>{'ar': 'الإسكندرية', 'en': 'Alexandria'},
    ),
    MarketOffer(
      buyer: <String, String>{'ar': 'مصنع وادي النيل للعصائر', 'en': 'Nile Valley Juices'},
      crop: <String, String>{'ar': 'طماطم', 'en': 'Tomato'},
      grade: 'B',
      pricePerTon: 8600,
      tons: 60,
      location: <String, String>{'ar': 'طنطا', 'en': 'Tanta'},
    ),
    MarketOffer(
      buyer: <String, String>{'ar': 'سلسلة أسواق البركة', 'en': 'Al-Baraka Markets'},
      crop: <String, String>{'ar': 'بطاطس', 'en': 'Potato'},
      grade: 'A',
      pricePerTon: 7600,
      tons: 18,
      location: <String, String>{'ar': 'القاهرة', 'en': 'Cairo'},
    ),
    MarketOffer(
      buyer: <String, String>{'ar': 'مؤسسة الصعيد للحبوب', 'en': 'Upper Egypt Grains'},
      crop: <String, String>{'ar': 'قمح', 'en': 'Wheat'},
      grade: 'A',
      pricePerTon: 12900,
      tons: 40,
      location: <String, String>{'ar': 'المنيا', 'en': 'Minya'},
    ),
  ];

  // --------------------------------------------------------------- profile
  static const List<Bilingual> modules = <Bilingual>[
    <String, String>{
      'ar': 'تشخيص أمراض النبات — رؤية حاسوبية (CNN)',
      'en': 'Plant disease diagnosis — computer vision (CNN)',
    },
    <String, String>{
      'ar': 'مساعد محادثة بالعربي — نموذج لغوي + قاعدة معرفة',
      'en': 'Arabic conversational assistant — LLM + knowledge base',
    },
    <String, String>{
      'ar': 'توقّع المحصول وجدولة الري — تحليلات تنبؤية',
      'en': 'Yield prediction & irrigation scheduling — predictive analytics',
    },
    <String, String>{
      'ar': 'توقّع الأسعار والسوق الذكي',
      'en': 'Price forecasting & smart marketplace',
    },
  ];

  static const List<Bilingual> stack = <Bilingual>[
    <String, String>{'ar': 'الواجهة: Flutter', 'en': 'App: Flutter'},
    <String, String>{'ar': 'الخادم: Python / FastAPI', 'en': 'Backend: Python / FastAPI'},
    <String, String>{'ar': 'الرؤية: PyTorch — ResNet / EfficientNet', 'en': 'Vision: PyTorch — ResNet / EfficientNet'},
    <String, String>{'ar': 'المحادثة: LLM + RAG', 'en': 'NLP: LLM + RAG'},
    <String, String>{'ar': 'البيانات: PostgreSQL + تخزين سحابي', 'en': 'Data: PostgreSQL + cloud object storage'},
    <String, String>{'ar': 'مصادر خارجية: طقس، أقمار صناعية، أسعار', 'en': 'External: weather, satellite, price feeds'},
  ];

  static Color severityColor(Severity severity) {
    switch (severity) {
      case Severity.low:
        return AppColors.leaf;
      case Severity.medium:
        return AppColors.warning;
      case Severity.high:
        return AppColors.danger;
    }
  }
}
