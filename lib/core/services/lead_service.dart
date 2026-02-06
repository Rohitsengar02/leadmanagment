import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/lead_model.dart';

class LeadService {
  String get _baseUrl =>
      dotenv.env['API_URL'] ?? 'http://192.168.1.43:5001/api';

  Future<List<Lead>> getLeads() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/leads'));

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((e) => Lead.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load leads: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching leads: $e');
      rethrow;
    }
  }

  Future<Lead> createLead(Lead lead) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/leads'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(lead.toJson()),
      );

      if (response.statusCode == 201) {
        return Lead.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create lead: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating lead: $e');
      rethrow;
    }
  }

  Future<Lead> updateLead(String id, Lead lead) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/leads/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(lead.toJson()),
      );

      if (response.statusCode == 200) {
        return Lead.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update lead: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating lead: $e');
      rethrow;
    }
  }

  Future<void> deleteLead(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/leads/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete lead: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting lead: $e');
      rethrow;
    }
  }
}
