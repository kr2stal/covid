import 'package:flutter/material.dart';

class LocalDropdown extends StatelessWidget {
  final List<String> locals;
  final String local;
  final Function(String) onChanged;

  const LocalDropdown({
    @required this.locals,
    @required this.local,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 40.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: local,
            items: locals
                .map((e) => DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 12.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            e,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: onChanged),
      ),
    );
  }
}
