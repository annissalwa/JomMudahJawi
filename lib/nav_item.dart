import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.title,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Text(
          title,
          style: TextStyle(   //ni untuk edit active navitem menu
            fontSize: 18.5,   //ni untuk edit active navitem menu
            color: active ? Colors.green.shade700 : Colors.black87,  //ni untuk edit active navitem menu
            fontWeight: active ? FontWeight.w600 : FontWeight.normal,    //ni untuk edit active navitem menu
          ),
        ),
      ),
    );
  }
}
