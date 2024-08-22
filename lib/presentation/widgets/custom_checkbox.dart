import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        InkWell(
          onTap: () => onChanged(!value),
          child: Container(
            height: 17,
            width: 17,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(
                color: value ? Colors.transparent : Colors.grey,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.purple,
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ),

        const SizedBox(width: 18),

        Text(
          label,
          style: const TextStyle(color: Color(0XFF0F1427)),
        ),
      ],
    );
  }
}
