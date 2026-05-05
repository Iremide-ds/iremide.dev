// lib/services/analytics_service.dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final instance = AnalyticsService();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // --- Screen tracking ---
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  // --- Section engagement ---
  Future<void> logSectionViewed(String section) async {
    await _analytics.logEvent(
      name: 'section_viewed',
      parameters: {'section_name': section},
    );
  }

  // --- Project interactions ---
  Future<void> logProjectViewed(String projectName) async {
    await _analytics.logEvent(
      name: 'project_viewed',
      parameters: {'project_name': projectName},
    );
  }

  Future<void> logProjectLinkOpened(String projectName, String linkType) async {
    await _analytics.logEvent(
      name: 'project_link_opened',
      parameters: {
        'project_name': projectName,
        'link_type': linkType, // 'github', 'live_demo', 'case_study'
      },
    );
  }

  // --- CTA / Contact ---
  Future<void> logContactInitiated(String method) async {
    await _analytics.logEvent(
      name: 'contact_initiated',
      parameters: {'method': method}, // 'email', 'linkedin', 'twitter'
    );
  }

  Future<void> logResumeDownloaded() async {
    await _analytics.logEvent(name: 'resume_downloaded');
  }

  // --- Engagement ---
  Future<void> logSkillTagClicked(String skill) async {
    await _analytics.logEvent(
      name: 'skill_tag_clicked',
      parameters: {'skill': skill},
    );
  }
}
