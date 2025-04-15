import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  late bool isChecked;
  late AnimationController _controller;
  late Animation<double> _thumbPosition;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _thumbPosition = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    if (isChecked) {
      _controller.value = 1.0;
    }
  }

  void toggleSwitch() {
    setState(() {
      isChecked = !isChecked;
      isChecked ? _controller.forward() : _controller.reverse();
      widget.onChanged(isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 60,
            height: 34,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isChecked ? Colors.green : const Color(0xFF2E2E2E),
              borderRadius: BorderRadius.circular(34),
            ),
            child: Align(
              alignment: Alignment.lerp(Alignment.centerLeft,
                  Alignment.centerRight, _thumbPosition.value)!,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFFC),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
