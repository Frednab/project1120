import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = Supabase.instance.client;

class FitCheckService {
  static String get _uid => _supabase.auth.currentUser!.id;

  static Future<void> saveCheck({
    required double score,
    required String label,
    required List<String> whatWorks,
    required List<String> improvements,
    required List<String> quickSwaps,
    String? photoUrl,
    String mode = 'photo',
  }) async {
    await _supabase.from('checks').insert({
      'user_id': _uid,
      'score': score,
      'label': label,
      'what_works': whatWorks,
      'improvements': improvements,
      'quick_swaps': quickSwaps,
      'photo_url': photoUrl,
      'mode': mode,
    });
    await _supabase.rpc('increment_checks_used', params: {'uid': _uid});
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final data = await _supabase
        .from('checks')
        .select()
        .eq('user_id', _uid)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  static Stream<List<Map<String, dynamic>>> getHistoryStream() {
    return _supabase
        .from('checks')
        .stream(primaryKey: ['id'])
        .eq('user_id', _uid)
        .order('created_at', ascending: false)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  static Future<void> deleteCheck(String checkId) async {
    await _supabase.from('checks').delete().eq('id', checkId);
  }

  static Future<Map<String, dynamic>> getStats() async {
    final checks = await getHistory();
    if (checks.isEmpty) return {'total': 0, 'avgScore': 0.0, 'bestScore': 0.0};
    final scores = checks.map((c) => (c['score'] as num).toDouble()).toList();
    final avg = scores.reduce((a, b) => a + b) / scores.length;
    final best = scores.reduce((a, b) => a > b ? a : b);
    return {
      'total': checks.length,
      'avgScore': double.parse(avg.toStringAsFixed(1)),
      'bestScore': best,
    };
  }

  static Future<bool> hasChecksRemaining() async {
    final profile = await _supabase
        .from('profiles').select().eq('id', _uid).single();
    final isPro = profile['is_pro'] as bool? ?? false;
    if (isPro) return true;
    final used = (profile['checks_used'] as num?)?.toInt() ?? 0;
    return used < 5;
  }
}
