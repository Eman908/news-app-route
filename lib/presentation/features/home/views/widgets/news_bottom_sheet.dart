import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/data/models/full_atricles/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatefulWidget {
  const NewsBottomSheet({super.key, required this.article});
  final Article article;

  @override
  State<NewsBottomSheet> createState() => _NewsBottomSheetState();
}

class _NewsBottomSheetState extends State<NewsBottomSheet> {
  bool isLoading = false;

  Future<void> _launchUrl(Uri url) async {
    setState(() => isLoading = true);
    try {
      final launched = await launchUrl(url);
      if (!launched) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the article')),
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(widget.article.url ?? "");

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(widget.article.urlToImage ?? ''),
            ),
            Text(
              widget.article.description ?? "",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: context.text.bodyLarge!.copyWith(
                color: context.colors.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () {
                  isLoading ? null : _launchUrl(url);
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: context.colors.surface,
                  foregroundColor: context.colors.onSurface,
                ),
                child:
                    isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: context.colors.onSurface,
                          ),
                        )
                        : Text(
                          context.local.viewarticle,
                          style: context.text.bodyLarge,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
