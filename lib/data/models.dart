import 'package:flutter/material.dart';

/// A bilingual string: {'ar': '...', 'en': '...'}
typedef Bilingual = Map<String, String>;

class Crop {
  const Crop({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  final String id;
  final Bilingual name;
  final IconData icon;
  final Color color;
}

enum Severity { low, medium, high }

class DiseaseInfo {
  const DiseaseInfo({
    required this.id,
    required this.cropId,
    required this.name,
    required this.scientificName,
    required this.summary,
    required this.treatment,
    required this.prevention,
    required this.confidence,
    required this.severity,
    this.healthy = false,
  });

  final String id;
  final String cropId;
  final Bilingual name;
  final String scientificName;
  final Bilingual summary;
  final List<Bilingual> treatment;
  final List<Bilingual> prevention;

  /// 0.0 – 1.0 as returned by the vision model.
  final double confidence;
  final Severity severity;
  final bool healthy;

  bool get isLowConfidence => confidence < 0.70;
}

class DiagnosisRecord {
  const DiagnosisRecord({
    required this.crop,
    required this.disease,
    required this.at,
  });

  final Crop crop;
  final DiseaseInfo disease;
  final DateTime at;
}

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.fromUser,
    this.canEscalate = false,
  });

  final String text;
  final bool fromUser;
  final bool canEscalate;
}

class KnowledgeEntry {
  const KnowledgeEntry({required this.keywords, required this.answer});

  final List<String> keywords;
  final Bilingual answer;
}

class PriceSeries {
  const PriceSeries({
    required this.cropId,
    required this.name,
    required this.today,
    required this.changePct,
    required this.forecastPct,
    required this.lastWeek,
  });

  final String cropId;
  final Bilingual name;
  final double today;
  final double changePct;
  final double forecastPct;
  final List<double> lastWeek;

  bool get shouldHold => forecastPct > 1.0;
}

class MarketOffer {
  const MarketOffer({
    required this.buyer,
    required this.crop,
    required this.grade,
    required this.pricePerTon,
    required this.tons,
    required this.location,
  });

  final Bilingual buyer;
  final Bilingual crop;
  final String grade;
  final double pricePerTon;
  final int tons;
  final Bilingual location;
}

class IrrigationDay {
  const IrrigationDay({
    required this.day,
    required this.millimetres,
    required this.note,
    this.skip = false,
  });

  final Bilingual day;
  final double millimetres;
  final Bilingual note;
  final bool skip;
}

class YieldPoint {
  const YieldPoint({
    required this.label,
    required this.value,
    this.forecast = false,
  });

  final String label;
  final double value;
  final bool forecast;
}
