import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/common.dart';

// ─── Data Models ──────────────────────────────────────────────────────────────
class _ComplexionTone {
  final String name;
  final String emoji;
  final Color swatch;
  final List<_ColorRec> bestColors;
  final List<_ColorRec> avoidColors;
  final String why;

  const _ComplexionTone({
    required this.name,
    required this.emoji,
    required this.swatch,
    required this.bestColors,
    required this.avoidColors,
    required this.why,
  });
}

class _ColorRec {
  final String name;
  final Color color;
  const _ColorRec(this.name, this.color);
}

class _ColorPair {
  final String label;
  final Color a;
  final Color b;
  final String note;
  const _ColorPair(this.label, this.a, this.b, this.note);
}

// ─── Color Data ───────────────────────────────────────────────────────────────
final _tones = [
  _ComplexionTone(
    name: 'Fair / Light',
    emoji: '🌸',
    swatch: Color(0xFFFDE8D8),
    why: 'Fair skin has cool or neutral undertones. Deep jewel tones and soft pastels create beautiful contrast without washing you out.',
    bestColors: [
      _ColorRec('Navy Blue', Color(0xFF1A237E)),
      _ColorRec('Burgundy', Color(0xFF7B1FA2)),
      _ColorRec('Forest Green', Color(0xFF2E7D32)),
      _ColorRec('Dusty Rose', Color(0xFFE8A0B4)),
      _ColorRec('Charcoal', Color(0xFF424242)),
      _ColorRec('Cobalt Blue', Color(0xFF1565C0)),
    ],
    avoidColors: [
      _ColorRec('Bright Orange', Color(0xFFFF5722)),
      _ColorRec('Neon Yellow', Color(0xFFFFEA00)),
      _ColorRec('Pale Beige', Color(0xFFEFEBE9)),
    ],
  ),
  _ComplexionTone(
    name: 'Medium / Olive',
    emoji: '🌿',
    swatch: Color(0xFFD4A574),
    why: 'Olive and medium skin tones have warm undertones that shine with earthy and warm-toned colors. You can also pull off bold brights.',
    bestColors: [
      _ColorRec('Terracotta', Color(0xFFBF5E3B)),
      _ColorRec('Warm White', Color(0xFFFFF8F0)),
      _ColorRec('Olive Green', Color(0xFF6D8B3A)),
      _ColorRec('Rust Orange', Color(0xFFD4541A)),
      _ColorRec('Gold', Color(0xFFD4A017)),
      _ColorRec('Deep Teal', Color(0xFF00695C)),
    ],
    avoidColors: [
      _ColorRec('Pastel Pink', Color(0xFFF8BBD9)),
      _ColorRec('Icy Blue', Color(0xFFB3E5FC)),
      _ColorRec('Cool Grey', Color(0xFF9E9E9E)),
    ],
  ),
  _ComplexionTone(
    name: 'Tan / Brown',
    emoji: '✨',
    swatch: Color(0xFF8D5524),
    why: 'Tan and brown skin tones look incredible in bright jewel tones and warm neutrals. High contrast colors make you pop.',
    bestColors: [
      _ColorRec('Electric Blue', Color(0xFF0D47A1)),
      _ColorRec('Bright White', Color(0xFFFFFFFF)),
      _ColorRec('Coral Red', Color(0xFFE53935)),
      _ColorRec('Mustard', Color(0xFFF9A825)),
      _ColorRec('Purple', Color(0xFF6A1B9A)),
      _ColorRec('Emerald', Color(0xFF2E7D32)),
    ],
    avoidColors: [
      _ColorRec('Khaki', Color(0xFFC8B560)),
      _ColorRec('Tan Brown', Color(0xFFA1887F)),
      _ColorRec('Dusty Mauve', Color(0xFFB39DDB)),
    ],
  ),
  _ComplexionTone(
    name: 'Deep / Dark',
    emoji: '🌟',
    swatch: Color(0xFF3E1C00),
    why: 'Deep skin tones are incredibly versatile. Bright, vivid, and jewel-toned colors make your skin glow. You can wear almost anything boldly.',
    bestColors: [
      _ColorRec('Bright Yellow', Color(0xFFF9A825)),
      _ColorRec('Hot Pink', Color(0xFFE91E63)),
      _ColorRec('Royal Blue', Color(0xFF1565C0)),
      _ColorRec('Crisp White', Color(0xFFFFFFFF)),
      _ColorRec('Lime Green', Color(0xFF558B2F)),
      _ColorRec('Rich Red', Color(0xFFC62828)),
    ],
    avoidColors: [
      _ColorRec('Dark Brown', Color(0xFF4E342E)),
      _ColorRec('Charcoal', Color(0xFF37474F)),
      _ColorRec('Muted Olive', Color(0xFF827717)),
    ],
  ),
];

final _outfitPairs = [
  _ColorPair('Classic Contrast', Color(0xFF1A1A2E), Color(0xFFFFFFFF),
      'Navy or black with white — timeless, sharp, always works'),
  _ColorPair('Earth & Warmth', Color(0xFF8B5E3C), Color(0xFFF5E6C8),
      'Brown tones with cream — warm, grounded, sophisticated'),
  _ColorPair('Bold Statement', Color(0xFFE53935), Color(0xFF1A237E),
      'Red with navy — powerful combo that commands attention'),
  _ColorPair('Tonal Blend', Color(0xFF2E7D32), Color(0xFF81C784),
      'Dark and light of the same color — effortless and elevated'),
  _ColorPair('Neutral Base', Color(0xFF6D4C41), Color(0xFFD7CCC8),
      'Camel and beige — clean, minimal, always polished'),
  _ColorPair('Pop of Color', Color(0xFF263238), Color(0xFFF9A825),
      'Dark neutral with one bright accent — confident and intentional'),
];

// ─── Screen ───────────────────────────────────────────────────────────────────
class ColorAnalysisScreen extends StatefulWidget {
  const ColorAnalysisScreen({super.key});

  @override
  State<ColorAnalysisScreen> createState() => _ColorAnalysisScreenState();
}

class _ColorAnalysisScreenState extends State<ColorAnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _selectedTone = 0;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    _tabCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8)
                            ],
                          ),
                          child:
                              const Icon(Icons.arrow_back, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Color Analysis',
                              style: GoogleFonts.dmSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary)),
                          Text(
                              'Find colors that work for you',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tab bar
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10)
                      ],
                    ),
                    child: TabBar(
                      controller: _tabCtrl,
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.textSecondary,
                      labelStyle: GoogleFonts.dmSans(
                          fontSize: 13, fontWeight: FontWeight.w700),
                      unselectedLabelStyle: GoogleFonts.dmSans(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'Complexion Colors'),
                        Tab(text: 'Outfit Pairings'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ── Tab Views ────────────────────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  _ComplexionTab(
                    selectedTone: _selectedTone,
                    onToneSelected: (i) =>
                        setState(() => _selectedTone = i),
                  ),
                  const _OutfitPairingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab 1: Complexion ────────────────────────────────────────────────────────
class _ComplexionTab extends StatelessWidget {
  final int selectedTone;
  final ValueChanged<int> onToneSelected;

  const _ComplexionTab(
      {required this.selectedTone, required this.onToneSelected});

  @override
  Widget build(BuildContext context) {
    final tone = _tones[selectedTone];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skin tone selector
          Text('Select your complexion',
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Row(
            children: _tones.asMap().entries.map((e) {
              final selected = e.key == selectedTone;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onToneSelected(e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                        right: e.key < _tones.length - 1 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: e.value.swatch,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.divider, width: 1),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          e.value.name.split(' / ')[0],
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Tone info card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.75)
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tone.emoji,
                    style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tone.name,
                          style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      const SizedBox(height: 6),
                      Text(tone.why,
                          style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: Colors.white70,
                              height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Best colors
          _SectionHeader(
            icon: Icons.check_circle_outline,
            color: AppColors.green,
            title: 'Colors That Shine On You',
            subtitle: 'These make your complexion glow',
          ),
          const SizedBox(height: 14),
          _ColorSwatchGrid(colors: tone.bestColors, positive: true),
          const SizedBox(height: 24),

          // Avoid colors
          _SectionHeader(
            icon: Icons.do_not_disturb_alt_outlined,
            color: AppColors.orange,
            title: 'Colors to Avoid',
            subtitle: 'These can wash out or clash with your tone',
          ),
          const SizedBox(height: 14),
          _ColorSwatchGrid(colors: tone.avoidColors, positive: false),
          const SizedBox(height: 24),

          // Pro tip
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.tips_and_updates_outlined,
                      color: AppColors.card, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pro Tip',
                          style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accent)),
                      const SizedBox(height: 4),
                      Text(
                          'Always test colors in natural light. Clothing store lighting can make colors look very different on your skin than they actually are.',
                          style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.dmSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            Text(subtitle,
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }
}

class _ColorSwatchGrid extends StatelessWidget {
  final List<_ColorRec> colors;
  final bool positive;

  const _ColorSwatchGrid(
      {required this.colors, required this.positive});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.1,
      children: colors.map((c) => _SwatchTile(rec: c, positive: positive)).toList(),
    );
  }
}

class _SwatchTile extends StatelessWidget {
  final _ColorRec rec;
  final bool positive;

  const _SwatchTile({required this.rec, required this.positive});

  bool get _isLight {
    final luminance = rec.color.computeLuminance();
    return luminance > 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: rec.color,
        borderRadius: BorderRadius.circular(16),
        border: _isLight
            ? Border.all(color: AppColors.divider)
            : null,
        boxShadow: [
          BoxShadow(
              color: rec.color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Stack(
        children: [
          // Color name at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                rec.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          // ✓ or ✗ badge top right
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: positive ? AppColors.green : AppColors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                positive ? Icons.check : Icons.close,
                size: 12,
                color: AppColors.card,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 2: Outfit Pairings ───────────────────────────────────────────────────
class _OutfitPairingsTab extends StatelessWidget {
  const _OutfitPairingsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Intro banner
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: Row(
              children: [
                const Text('🎨', style: TextStyle(fontSize: 32)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color Coordination Rules',
                          style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(
                          'These pairings work across clothes, shoes, and accessories',
                          style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Pairing cards
          ..._outfitPairs.map((pair) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _PairingCard(pair: pair),
              )),

          const SizedBox(height: 8),

          // Accessory rule box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A2E), Color(0xFF3D2B6B)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('⌚', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Text('Accessory Color Rules',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 16),
                ...[
                  _AccRule('Gold jewelry', 'Pairs with warm tones — browns, oranges, olive, burgundy'),
                  _AccRule('Silver jewelry', 'Pairs with cool tones — navy, grey, white, black, purple'),
                  _AccRule('Brown belt / shoes', 'Never with black clothes. Match to warm outfit tones'),
                  _AccRule('Black belt / shoes', 'Works with almost anything. Keep it sleek'),
                  _AccRule('White sneakers', 'Universal — elevates casual looks across all colors'),
                ].map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFA78BFA),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${r.label} — ',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: r.value,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        color: Colors.white70,
                                        height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccRule {
  final String label;
  final String value;
  const _AccRule(this.label, this.value);
}

class _PairingCard extends StatelessWidget {
  final _ColorPair pair;
  const _PairingCard({required this.pair});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Color preview blocks
          Row(
            children: [
              Container(
                width: 44,
                height: 52,
                decoration: BoxDecoration(
                  color: pair.a,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12)),
                  border: Border.all(color: AppColors.divider),
                ),
              ),
              Container(
                width: 44,
                height: 52,
                decoration: BoxDecoration(
                  color: pair.b,
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12)),
                  border: Border.all(color: AppColors.divider),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pair.label,
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(pair.note,
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
