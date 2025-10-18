import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String output;
  final VoidCallback onConvert;
  final VoidCallback? onPlay; 

  const ConverterCard({
    super.key,
    required this.title,
    required this.controller,
    required this.output,
    required this.onConvert,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onConvert,
                  child: const Text('Convert'),
                ),
                if (onPlay != null) ...[
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: onPlay,
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Play'),
                  )
                ]
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SelectableText(
                    output.isEmpty ? 'Output...' : output,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                IconButton(
                  onPressed: output.isEmpty ?
                    null :
                    () {
                      Clipboard.setData(ClipboardData(text: output));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to Clipboard')),
                      );
                    },
                  tooltip: 'Copy to Clipboard',
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}