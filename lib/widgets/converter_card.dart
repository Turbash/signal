import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ConverterCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String output;
  final VoidCallback onConvert;
  final VoidCallback onPlay;
  final VoidCallback onShare;
  final VoidCallback? onShareAudio;

  const ConverterCard({
    super.key,
    required this.title,
    required this.controller,
    required this.output,
    required this.onConvert,
    required this.onPlay,
    required this.onShare,
    this.onShareAudio,
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
            Text(
              title,
              style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),
            ),
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
                
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: output.isNotEmpty ? onPlay : null,
                  icon: const Icon(Icons.volume_up),
                  label: const Text('Play'),
                ),
                if (onShareAudio != null) ...[
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: output.isNotEmpty ? onShareAudio : null,
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ],
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
                IconButton(
                  onPressed: output.isEmpty ?
                  null :
                  () {
                    SharePlus.instance.share(ShareParams(text: output));
                  },
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}