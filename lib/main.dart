import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MangoBytesApplication());
  });
}

// ============================================================================
// APP ROOT
// ============================================================================

class MangoBytesApplication extends StatelessWidget {
  const MangoBytesApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mango Bytes Voice AI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        useMaterial3: true,
      ),
      home: const VoiceSelectionScreen(),
    );
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

class BubbleConfig {
  final double size;
  final double top;
  final double right;
  final List<Color> gradientColors;
  final List<double> stops;

  const BubbleConfig({
    required this.size,
    required this.top,
    required this.right,
    required this.gradientColors,
    required this.stops,
  });
}

class VoiceProfile {
  final String id;
  final String displayName;
  final String descriptionText;
  final Color baseColor;
  final BubbleConfig mainBubble;
  final BubbleConfig glassBubble;

  const VoiceProfile({
    required this.id,
    required this.displayName,
    required this.descriptionText,
    required this.baseColor,
    required this.mainBubble,
    required this.glassBubble,
  });
}

final List<VoiceProfile> voiceDatabase = [
  VoiceProfile(
    id: 'adrija',
    displayName: 'Adrija',
    descriptionText: "> BONJOUR, I'M ADRIJA FROM FRANCE.\n> I AM A WOMAN IN MY 20'S...!",
    baseColor: const Color(0xFFE91E63),
    mainBubble: const BubbleConfig(
      size: 240,
      top: 140,
      right: -70,
      gradientColors: [Color(0xFFFFB3D9), Color(0xFFE91E63)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 115,
      top: 345,
      right: 10,
      gradientColors: [Colors.white, Color(0x99E91E63)],
      stops: [0.0, 1.0],
    ),
  ),
  VoiceProfile(
    id: 'ursa',
    displayName: 'Ursa',
    descriptionText: "> HEY! I'M URSA—YOROSHIKU NE!\n> FROM JAPAAANN\n> IN MY 30S...",
    baseColor: const Color(0xFFDE4A44),
    mainBubble: const BubbleConfig(
      size: 255,
      top: 200,
      right: -65,
      gradientColors: [Color(0xFFFFCDCC), Color(0xFFDE4A44)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 130,
      top: 420,
      right: -5,
      gradientColors: [Colors.white, Color(0x99DE4A44)],
      stops: [0.0, 1.0],
    ),
  ),
  VoiceProfile(
    id: 'swastika',
    displayName: 'Swastika',
    descriptionText:
        "> ASSALAMU ALAIKUM, I'M SWASTIKA.\n> I'M FROM SAUDI ARABIA\n> A WOMAN IN HER 50S...",
    baseColor: const Color(0xFF8E24AA),
    mainBubble: const BubbleConfig(
      size: 260,
      top: 280,
      right: -60,
      gradientColors: [Color(0xFFD39FE0), Color(0xFF8E24AA)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 140,
      top: 155,
      right: 10,
      gradientColors: [Colors.white, Color(0x998E24AA)],
      stops: [0.0, 1.0],
    ),
  ),
  VoiceProfile(
    id: 'utsha',
    displayName: 'Utsha',
    descriptionText: "> NAMASTE, MYSELF UTSHA\n> I AM FROM INDIA\n> CURRENTLY IN MY TEENS...",
    baseColor: const Color(0xFF43A047),
    mainBubble: const BubbleConfig(
      size: 250,
      top: 340,
      right: -60,
      gradientColors: [Color(0xFFB5E0B7), Color(0xFF43A047)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 125,
      top: 240,
      right: 10,
      gradientColors: [Colors.white, Color(0x9943A047)],
      stops: [0.0, 1.0],
    ),
  ),
  VoiceProfile(
    id: 'rochishnu',
    displayName: 'Rochishnu',
    descriptionText: "> OLA, I'M ROCHISHNU FROM BRAZIL.\n> I AM A GUY IN MY TEENS...",
    baseColor: const Color(0xFF009688),
    mainBubble: const BubbleConfig(
      size: 250,
      top: 395,
      right: -60,
      gradientColors: [Color(0xFF80CBC4), Color(0xFF009688)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 130,
      top: 270,
      right: 10,
      gradientColors: [Colors.white, Color(0x99009688)],
      stops: [0.0, 1.0],
    ),
  ),
  VoiceProfile(
    id: 'orbit',
    displayName: 'Orbit',
    descriptionText:
        "> HI I AM ORION\n> I AM AN AMERICAN BORN MALE\n> CURRENTLY IN MY 20S...",
    baseColor: const Color(0xFF1976D2),
    mainBubble: const BubbleConfig(
      size: 255,
      top: 450,
      right: -60,
      gradientColors: [Color(0xFF90CAF9), Color(0xFF1976D2)],
      stops: [0.0, 1.0],
    ),
    glassBubble: const BubbleConfig(
      size: 135,
      top: 290,
      right: 10,
      gradientColors: [Colors.white, Color(0x991976D2)],
      stops: [0.0, 1.0],
    ),
  ),
];

// ============================================================================
// MAIN SCREEN
// ============================================================================

class VoiceSelectionScreen extends StatefulWidget {
  const VoiceSelectionScreen({super.key});

  @override
  State<VoiceSelectionScreen> createState() => _VoiceSelectionScreenState();
}

class _VoiceSelectionScreenState extends State<VoiceSelectionScreen>
    with TickerProviderStateMixin {
  int _activeVoiceIndex = 1; // Ursa selected by default

  late final AnimationController _entranceController;
  late final AnimationController _ambientController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  void _handleVoiceSelected(int index) {
    if (_activeVoiceIndex == index) return;
    HapticFeedback.lightImpact();
    setState(() {
      _activeVoiceIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeProfile = voiceDatabase[_activeVoiceIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Solid background ──────────────────────────────────
          const ColoredBox(color: Color(0xFFF4F4F4)),

          // ── 2. Animated background bubbles (behind everything) ───
          _BackgroundBubbles(
            activeProfile: activeProfile,
            ambientController: _ambientController,
          ),

          // ── 3. Foreground UI ─────────────────────────────────────
          SafeArea(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dot-matrix header text
                      _HeaderText(
                        entranceController: _entranceController,
                        activeProfile: activeProfile,
                      ),

                      const Spacer(),

                      // Glass voice-selector card
                      _GlassCard(
                        entranceController: _entranceController,
                        activeProfile: activeProfile,
                        selectedIndex: _activeVoiceIndex,
                        onSelect: _handleVoiceSelected,
                      ),

                      const Spacer(),

                      // Share / dots button bottom-right
                      _FooterButton(entranceController: _entranceController),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// BACKGROUND BUBBLES
// ============================================================================

class _BackgroundBubbles extends StatelessWidget {
  final VoiceProfile activeProfile;
  final AnimationController ambientController;

  const _BackgroundBubbles({
    required this.activeProfile,
    required this.ambientController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ambientController,
      builder: (context, _) {
        final t = ambientController.value;
        final floatY = math.sin(t * 2 * math.pi) * 12;
        final floatX = math.cos(t * 2 * math.pi) * 8;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // White accent circle — top-right corner
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
            ),

            // ── Main gradient sphere ───────────────────────────────
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutQuint,
              top: activeProfile.mainBubble.top,
              right: activeProfile.mainBubble.right,
              child: Transform.translate(
                offset: Offset(floatX, floatY),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  width: activeProfile.mainBubble.size,
                  height: activeProfile.mainBubble.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: activeProfile.mainBubble.gradientColors,
                      stops: activeProfile.mainBubble.stops,
                      center: const Alignment(-0.3, -0.3),
                      radius: 0.9,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeProfile.mainBubble.gradientColors.last
                            .withOpacity(0.35),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Secondary frosted-glass sphere ────────────────────
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutQuint,
              top: activeProfile.glassBubble.top,
              right: activeProfile.glassBubble.right,
              child: Transform.translate(
                offset: Offset(-floatX * 1.3, -floatY * 1.3),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  width: activeProfile.glassBubble.size,
                  height: activeProfile.glassBubble.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: activeProfile.glassBubble.gradientColors,
                      center: const Alignment(-0.3, -0.4),
                      stops: const [0.0, 1.0],
                      radius: 0.85,
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.70),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeProfile.baseColor.withOpacity(0.18),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// HEADER — dot-matrix typewriter
// ============================================================================

class _HeaderText extends StatelessWidget {
  final AnimationController entranceController;
  final VoiceProfile activeProfile;

  const _HeaderText({
    required this.entranceController,
    required this.activeProfile,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    final slide = Tween<Offset>(
      begin: const Offset(-0.04, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: SizedBox(
          height: 115,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: _DotMatrixTypewriter(
              key: ValueKey(activeProfile.id),
              text: activeProfile.descriptionText,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// GLASS CARD
// ============================================================================

class _GlassCard extends StatelessWidget {
  final AnimationController entranceController;
  final VoiceProfile activeProfile;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _GlassCard({
    required this.entranceController,
    required this.activeProfile,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: entranceController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));
    final opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0.2, 0.75, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slideUp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutQuint,
          width: 208,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: activeProfile.baseColor.withOpacity(0.14),
                blurRadius: 44,
                spreadRadius: -4,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 20, left: 12, right: 12),
                decoration: BoxDecoration(
                  // Frosted glass: semi-transparent white
                  color: const Color(0x82FFFFFF),
                  border: Border.all(
                    color: const Color(0xD6FFFFFF),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle pill
                    Container(
                      width: 38,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.11),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    // Voice buttons
                    ...List.generate(voiceDatabase.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _VoiceButton(
                          voice: voiceDatabase[i],
                          isSelected: selectedIndex == i,
                          onTap: () => onSelect(i),
                        ),
                      );
                    }),

                    const SizedBox(height: 6),

                    // Gemini badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome,
                            color: Color(0xFF4285F4), size: 12),
                        SizedBox(width: 5),
                        Text(
                          'Powered by Gemini',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF999999),
                            letterSpacing: 0.15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// VOICE BUTTON
// ============================================================================

class _VoiceButton extends StatelessWidget {
  final VoiceProfile voice;
  final bool isSelected;
  final VoidCallback onTap;

  const _VoiceButton({
    required this.voice,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(isSelected ? 12.0 : 0.0, 0, 0),
        margin: EdgeInsets.only(right: isSelected ? 0 : 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.98)
              : Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: voice.baseColor.withOpacity(0.20),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Arrow
            Text(
              isSelected ? '<' : '>',
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? const Color(0xFF999999)
                    : const Color(0xFFCCCCCC),
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 9),
            // Name
            Expanded(
              child: Text(
                voice.displayName,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight:
                      isSelected ? FontWeight.w500 : FontWeight.w300,
                  color: const Color(0xFF2E2E2E),
                  letterSpacing: 0.1,
                ),
              ),
            ),
            // Icon: leaf vs radio
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: isSelected
                  ? _RadioIcon(key: const ValueKey('radio'), color: voice.baseColor)
                  : _LeafIcon(key: const ValueKey('leaf'), color: voice.baseColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeafIcon extends StatelessWidget {
  final Color color;
  const _LeafIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(11),
          bottomRight: Radius.circular(11),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        ),
      ),
    );
  }
}

class _RadioIcon extends StatelessWidget {
  final Color color;
  const _RadioIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.35), width: 2.0),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

// ============================================================================
// FOOTER BUTTON
// ============================================================================

class _FooterButton extends StatelessWidget {
  final AnimationController entranceController;
  const _FooterButton({required this.entranceController});

  @override
  Widget build(BuildContext context) {
    final scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    return Align(
      alignment: Alignment.bottomRight,
      child: ScaleTransition(
        scale: scale,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => HapticFeedback.selectionClick(),
            customBorder: const CircleBorder(),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF282828),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.24),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// DOT-MATRIX TYPEWRITER
// ============================================================================

class _DotMatrixTypewriter extends StatefulWidget {
  final String text;
  const _DotMatrixTypewriter({super.key, required this.text});

  @override
  State<_DotMatrixTypewriter> createState() => _DotMatrixTypewriterState();
}

class _DotMatrixTypewriterState extends State<_DotMatrixTypewriter>
    with SingleTickerProviderStateMixin {
  int _charCount = 0;
  late final AnimationController _cursorCtrl;

  @override
  void initState() {
    super.initState();
    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 430),
    )..repeat(reverse: true);
    _runTypewriter();
  }

  void _runTypewriter() async {
    final rng = math.Random();
    for (int i = 0; i <= widget.text.length; i++) {
      if (!mounted) return;
      setState(() => _charCount = i);
      final ch = i < widget.text.length ? widget.text[i] : '';
      final delay = ch == '\n' ? 65 : 13 + rng.nextInt(13);
      await Future.delayed(Duration(milliseconds: delay));
    }
  }

  @override
  void dispose() {
    _cursorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cursorCtrl,
      builder: (_, __) {
        final current = widget.text.substring(0, _charCount);
        final done = _charCount == widget.text.length;
        final showCursor = done ? (_cursorCtrl.value > 0.5) : true;
        return CustomPaint(
          size: const Size(double.infinity, 115),
          painter: _DotMatrixPainter(
            text: '$current${showCursor ? '_' : ' '}',
            color: const Color(0xFF333333),
            dotSize: 1.05,
            dotSpacing: 1.78,
            charSpacing: 3.6,
            lineSpacing: 22.0,
          ),
        );
      },
    );
  }
}

class _DotMatrixPainter extends CustomPainter {
  final String text;
  final Color color;
  final double dotSize;
  final double dotSpacing;
  final double charSpacing;
  final double lineSpacing;

  _DotMatrixPainter({
    required this.text,
    required this.color,
    required this.dotSize,
    required this.dotSpacing,
    required this.charSpacing,
    required this.lineSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double x = 0, y = 0;
    final upper = text.toUpperCase();

    for (int i = 0; i < upper.length; i++) {
      final ch = upper[i];
      if (ch == '\n') {
        x = 0;
        y += lineSpacing;
        continue;
      }
      if (ch == ' ') {
        x += (5 * dotSpacing) + charSpacing;
        continue;
      }
      final matrix = DotMatrixFont.getChar(ch);
      for (int row = 0; row < 7; row++) {
        for (int col = 0; col < 5; col++) {
          if ((matrix[row] & (1 << (4 - col))) != 0) {
            canvas.drawCircle(
              Offset(x + col * dotSpacing, y + row * dotSpacing),
              dotSize,
              paint,
            );
          }
        }
      }
      x += (5 * dotSpacing) + charSpacing;
      if (x > size.width - 16) {
        x = 0;
        y += lineSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotMatrixPainter old) => text != old.text;
}

// ============================================================================
// DOT-MATRIX 7×5 FONT  (bit4 = leftmost col)
// ============================================================================

class DotMatrixFont {
  static const Map<String, List<int>> _f = {
    'A': [0x0E, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11],
    'B': [0x1E, 0x11, 0x11, 0x1E, 0x11, 0x11, 0x1E],
    'C': [0x0E, 0x11, 0x10, 0x10, 0x10, 0x11, 0x0E],
    'D': [0x1E, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1E],
    'E': [0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x1F],
    'F': [0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x10],
    'G': [0x0E, 0x11, 0x10, 0x13, 0x11, 0x11, 0x0E],
    'H': [0x11, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11],
    'I': [0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E],
    'J': [0x07, 0x02, 0x02, 0x02, 0x02, 0x12, 0x0C],
    'K': [0x11, 0x12, 0x14, 0x18, 0x14, 0x12, 0x11],
    'L': [0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1F],
    'M': [0x11, 0x1B, 0x15, 0x11, 0x11, 0x11, 0x11],
    'N': [0x11, 0x19, 0x15, 0x13, 0x11, 0x11, 0x11],
    'O': [0x0E, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E],
    'P': [0x1E, 0x11, 0x11, 0x1E, 0x10, 0x10, 0x10],
    'Q': [0x0E, 0x11, 0x11, 0x11, 0x15, 0x12, 0x0D],
    'R': [0x1E, 0x11, 0x11, 0x1E, 0x14, 0x12, 0x11],
    'S': [0x0E, 0x11, 0x10, 0x0E, 0x01, 0x11, 0x0E],
    'T': [0x1F, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04],
    'U': [0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E],
    'V': [0x11, 0x11, 0x11, 0x11, 0x11, 0x0A, 0x04],
    'W': [0x11, 0x11, 0x11, 0x15, 0x15, 0x1B, 0x11],
    'X': [0x11, 0x11, 0x0A, 0x04, 0x0A, 0x11, 0x11],
    'Y': [0x11, 0x11, 0x11, 0x0A, 0x04, 0x04, 0x04],
    'Z': [0x1F, 0x01, 0x02, 0x04, 0x08, 0x10, 0x1F],
    '0': [0x0E, 0x13, 0x15, 0x19, 0x11, 0x11, 0x0E],
    '1': [0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x0E],
    '2': [0x0E, 0x11, 0x01, 0x02, 0x04, 0x08, 0x1F],
    '3': [0x1F, 0x02, 0x04, 0x02, 0x01, 0x11, 0x0E],
    '4': [0x02, 0x06, 0x0A, 0x12, 0x1F, 0x02, 0x02],
    '5': [0x1F, 0x10, 0x1E, 0x01, 0x01, 0x11, 0x0E],
    '6': [0x06, 0x08, 0x10, 0x1E, 0x11, 0x11, 0x0E],
    '7': [0x1F, 0x01, 0x02, 0x04, 0x08, 0x08, 0x08],
    '8': [0x0E, 0x11, 0x11, 0x0E, 0x11, 0x11, 0x0E],
    '9': [0x0E, 0x11, 0x11, 0x0F, 0x01, 0x02, 0x0C],
    '<': [0x02, 0x04, 0x08, 0x10, 0x08, 0x04, 0x02],
    '>': [0x08, 0x04, 0x02, 0x01, 0x02, 0x04, 0x08],
    '-': [0x00, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00],
    '.': [0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C],
    ',': [0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x08],
    "'": [0x0C, 0x0C, 0x08, 0x00, 0x00, 0x00, 0x00],
    '!': [0x04, 0x04, 0x04, 0x04, 0x00, 0x04, 0x04],
    '?': [0x0E, 0x11, 0x01, 0x02, 0x04, 0x00, 0x04],
    '_': [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F],
    ' ': [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
  };

  static List<int> getChar(String ch) => _f[ch] ?? _f[' ']!;
}