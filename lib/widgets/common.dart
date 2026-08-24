import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';

/// The rounded container every block of content sits in.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.accent,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.cardBg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent?.withOpacity(0.35) ?? context.borderColor,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Small heading used above every section.
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: context.strongText,
              ),
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(action!),
            ),
        ],
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.filled = false,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? color : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13, color: filled ? Colors.white : color),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: filled ? Colors.white : color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Icon + value + caption block used on the weather strip and stat rows.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.caption,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 19, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: context.strongText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: context.subtleText),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final Widget button = FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.35),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 19),
            const SizedBox(width: 8),
          ],
          Flexible(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// Header button that flips the whole app between Arabic and English.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => AppScope.of(context).toggleLanguage(),
      icon: const Icon(Icons.translate, size: 18),
      label: Text(
        context.tr('common.switchLang'),
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: AppColors.primary.withOpacity(0.10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

/// Confidence meter shown on the diagnosis result.
class ConfidenceBar extends StatelessWidget {
  const ConfidenceBar({super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double v, Widget? child) {
          return LinearProgressIndicator(
            value: v,
            minHeight: 10,
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          );
        },
      ),
    );
  }
}

/// The app mark: a leaf with a small circuit node, drawn with no assets.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.3),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.leaf, AppColors.primaryDeep],
        ),
      ),
      child: Icon(Icons.eco, color: Colors.white, size: size * 0.55),
    );
  }
}

/// Stylised leaf used in place of a real camera photo in this prototype.
class LeafArt extends StatelessWidget {
  const LeafArt({super.key, this.showSpots = true, this.tint});

  final bool showSpots;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LeafPainter(
        showSpots: showSpots,
        tint: tint ?? AppColors.leaf,
        background: context.isDark ? const Color(0xFF121915) : const Color(0xFFEDF4EA),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _LeafPainter extends CustomPainter {
  _LeafPainter({
    required this.showSpots,
    required this.tint,
    required this.background,
  });

  final bool showSpots;
  final Color tint;
  final Color background;

  static const List<List<double>> _spots = <List<double>>[
    <double>[0.40, 0.32, 0.055],
    <double>[0.60, 0.47, 0.075],
    <double>[0.44, 0.63, 0.045],
    <double>[0.57, 0.74, 0.035],
    <double>[0.36, 0.48, 0.030],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    canvas.drawRect(Offset.zero & size, Paint()..color = background);

    final Path leaf = Path()
      ..moveTo(w * 0.5, h * 0.06)
      ..cubicTo(w * 0.96, h * 0.26, w * 0.94, h * 0.76, w * 0.5, h * 0.96)
      ..cubicTo(w * 0.06, h * 0.76, w * 0.04, h * 0.26, w * 0.5, h * 0.06)
      ..close();

    canvas.drawPath(
      leaf,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[tint.withOpacity(0.95), tint.withOpacity(0.65)],
        ).createShader(Offset.zero & size),
    );

    canvas.save();
    canvas.clipPath(leaf);

    final Paint vein = Paint()
      ..color = Colors.white.withOpacity(0.42)
      ..strokeWidth = w * 0.008
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(w * 0.5, h * 0.09), Offset(w * 0.5, h * 0.93), vein);

    for (int i = 1; i <= 5; i++) {
      final double y = h * (0.18 + i * 0.13);
      final Path left = Path()
        ..moveTo(w * 0.5, y)
        ..quadraticBezierTo(w * 0.34, y - h * 0.02, w * 0.18, y + h * 0.05);
      final Path right = Path()
        ..moveTo(w * 0.5, y)
        ..quadraticBezierTo(w * 0.66, y - h * 0.02, w * 0.82, y + h * 0.05);
      canvas.drawPath(left, vein);
      canvas.drawPath(right, vein);
    }

    if (showSpots) {
      for (final List<double> spot in _spots) {
        final Offset centre = Offset(w * spot[0], h * spot[1]);
        final double radius = w * spot[2];
        canvas.drawCircle(
          centre,
          radius * 1.5,
          Paint()..color = const Color(0xFFD9B44A).withOpacity(0.45),
        );
        canvas.drawCircle(
          centre,
          radius,
          Paint()..color = const Color(0xFF7A4A22).withOpacity(0.85),
        );
        canvas.drawCircle(
          centre,
          radius * 0.55,
          Paint()
            ..color = const Color(0xFF4A2A12)
            ..style = PaintingStyle.stroke
            ..strokeWidth = w * 0.004,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LeafPainter oldDelegate) =>
      oldDelegate.showSpots != showSpots ||
      oldDelegate.tint != tint ||
      oldDelegate.background != background;
}
