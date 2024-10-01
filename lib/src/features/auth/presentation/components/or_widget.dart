import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              // endIndent: context.width * 0.7,
              thickness: 1.5,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "OR",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                  ),
            ),
          ),
          Expanded(
            child: Divider(
              // indent: context.width * 0.7,
              thickness: 1.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
