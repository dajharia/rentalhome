import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PolicyPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  const PolicyPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
  });

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(isDarkTheme ? Icons.dark_mode : Icons.light_mode),
          onPressed: toggleTheme,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String policyHtml = """
    <h1>Privacy Policy</h1>
    <p>This privacy policy applies to the Rental Home app (hereby referred to as "Application") for mobile devices that was created by daj web design (hereby referred to as "Service Provider") as an Open Source service. This service is intended for use "AS IS".</p>
    <h2>Information Collection and Use</h2>
    <p>The Application collects information when you download and use it. This information may include information such as:</p>
    <ul>
      <li><p>- Your device's Internet Protocol address (e.g. IP address)</p></li>
      <li><p>- The pages of the Application that you visit, the time and date of your visit, the time spent on those pages</p></li>
      <li><p>- The time spent on the Application</p></li>
      <li><p>- The operating system you use on your mobile device</p></li>
    </ul>
    <p>The Application does not gather precise information about the location of your mobile device.</p>
    <h2>Third Party Access</h2>
    <p>Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.</p>
    <p>Please note that the Application utilizes third-party services that have their own Privacy Policy about handling data. Below are the links to the Privacy Policy of the third-party service providers used by the Application:</p>
    <ul>
      <li><a href="https://www.google.com/policies/privacy/" target="_blank">Google Play Services</a></li>
      <li><a href="https://firebase.google.com/support/privacy" target="_blank">Google Analytics for Firebase</a></li>
      <li><a href="https://firebase.google.com/support/privacy/" target="_blank">Firebase Crashlytics</a></li>
    </ul>
    <h2>Opt-Out Rights</h2>
    <p>You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.</p>
    <h2>Data Retention Policy</h2>
    <p>The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you'd like them to delete User Provided Data that you have provided via the Application, please contact them at rentalhomedesk@gmail.com and they will respond in a reasonable time.</p>
    <h2>Children</h2>
    <p>The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.</p>
    <h2>Security</h2>
    <p>The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.</p>
    <h2>Changes</h2>
    <p>This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.</p>
    <h2>Your Consent</h2>
    <p>By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us.</p>
    <h2>Contact Us</h2>
    <p>If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at rentalhomedesk@gmail.com.</p>
    <p>This privacy policy is effective as of 2024-12-20</p>
    """;

    return Scaffold(
      appBar: buildAppBar(context, 'Privacy Policy'), // Updated AppBar
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Html(
          data: policyHtml, // Displaying HTML content
        ),
      ),
    );
  }
}
