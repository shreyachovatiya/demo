import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginatedListView extends StatefulWidget {
  const PaginatedListView({super.key});

  @override
  PaginatedListViewState createState() => PaginatedListViewState();
}

class PaginatedListViewState extends State<PaginatedListView> {
  List<dynamic> data = [];
  bool _isLoading = false;
  bool _isMoreDataAvailable = true;
  int _currentPage = 1;
  final int _limit = 20; // Number of items per page.

  Future<List<dynamic>> fetchData(int page, int limit) async {
    final url = Uri.parse(
        'https://staging.whistle.in.net/api/scoresheets?academy_id=29&page=$page');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Basic Y2FzdGxlcjpXZURpZEF3ZXNvbWUh Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWdpbmcud2hpc3RsZS5pbi5uZXQvYXBpL3ZlcmlmeSIsImlhdCI6MTcxNjE4MDIzMCwiZXhwIjoxOTc4OTgwMjMwLCJuYmYiOjE3MTYxODAyMzAsImp0aSI6IkI0MEQ3YVBGbXhwZVlGN2siLCJzdWIiOiIyMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.JE3x67X5D9sm5wkMhByaOQi0OHumMzKD8mAEsVuBg1U",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data']['scoresheets'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMoreData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMoreData() async {
    if (_isLoading || !_isMoreDataAvailable) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final newData = await fetchData(_currentPage, _limit);
      setState(() {
        if (newData.isEmpty) {
          _isMoreDataAvailable = false;
        } else {
          data.addAll(newData);
          _currentPage++;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paginated ListView')),
      body: data.isEmpty && !_isLoading
          ? Center(child: Text('No data available'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: data.length + (_isMoreDataAvailable ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }

                final item = data[index];
                return ListTile(
                  title: Text('Match ID: ${item['match_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Match Type: ${item['match_type']}'),
                      Text('Date: ${item['date']}'),
                      Text('Time: ${item['time']}'),
                      Text(
                          'Team 1: ${item['team_1']['name']} - Score: ${item['team_1']['team_score']}'),
                      Text(
                          'Team 2: ${item['team_2']['name']} - Score: ${item['team_2']['team_score']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
