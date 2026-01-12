import 'package:flutter/material.dart';

class AnimatedOnboardingIcon extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final bool isActive;

  const AnimatedOnboardingIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    this.size = 120,
    this.isActive = true,
  });

  @override
  State<AnimatedOnboardingIcon> createState() => _AnimatedOnboardingIconState();
}

class _AnimatedOnboardingIconState extends State<AnimatedOnboardingIcon>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for entrance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Subtle rotation animation
    _rotateController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotateAnimation = Tween<double>(
      begin: -0.02,
      end: 0.02,
    ).animate(
      CurvedAnimation(
        parent: _rotateController,
        curve: Curves.easeInOut,
      ),
    );

    // Pulse animation for the glow effect
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isActive) {
      _scaleController.forward();
      _rotateController.repeat(reverse: true);
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedOnboardingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _scaleController.forward();
      _rotateController.repeat(reverse: true);
      _pulseController.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _scaleController.reverse();
      _rotateController.stop();
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _rotateAnimation,
        _pulseAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow effect
                Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: widget.size + 40,
                    height: widget.size + 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.iconColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                // Middle glow
                Transform.scale(
                  scale: _pulseAnimation.value * 0.85,
                  child: Container(
                    width: widget.size + 20,
                    height: widget.size + 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.iconColor.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                // Icon container with glassmorphism
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    size: widget.size * 0.5,
                    color: widget.iconColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom icon widget for stats display
class StatsIconWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const StatsIconWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
