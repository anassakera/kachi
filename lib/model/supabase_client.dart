import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final supabase = Supabase.instance.client;

  static Future<dynamic> getData(String table, {String? query}) async {
    try {
      final response = await supabase.from(table).select(query ?? '*');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> insertData(String table, Map<String, dynamic> data) async {
    try {
      final response = await supabase.from(table).insert(data).select();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> updateData(
      String table, String id, Map<String, dynamic> data) async {
    try {
      final response = await supabase
          .from(table)
          .update(data)
          .eq('id', id)
          .select();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteData(String table, String id) async {
    try {
      await supabase.from(table).delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }
}
