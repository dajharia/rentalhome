import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

AppBar buildAppBar(BuildContext context, String title, VoidCallback toggleTheme, bool isDarkTheme) {
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

class DisclaimerScreen extends StatelessWidget { // HomeScreen से विरासत लेने की आवश्यकता नहीं
  const DisclaimerScreen({super.key, required this.toggleTheme, required this.isDarkTheme});

  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    // Disclaimer HTML content
    final String disclaimerHtml = """
    <h1>Disclaimer</h1>
    <p>Last updated: December 20, 2024</p>
    <h2>Interpretation and Definitions</h2>
    <h3>Interpretation</h3>
    <p>The words of which the initial letter is capitalized have meanings defined under the following conditions.
    The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.</p>
    <h3>Definitions</h3>
    <p>For the purposes of this Disclaimer:</p>
    <ul>
      <li><p><strong>Company</strong> (referred to as either "the Company", "We", "Us" or "Our" in this Disclaimer) refers to RentalHome.</p></li>
      <li><p><strong>Service</strong> refers to the Application.</p></li>
      <li><p><strong>You</strong> means the individual accessing the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.</p></li>
      <li><p><strong>Application</strong> means the software program provided by the Company downloaded by You on any electronic device named RentalHome.</p></li>
    </ul>
    <h2>Disclaimer</h2>
    <p>The information contained on the Service is for general information purposes only.</p>
    <p>The Company assumes no responsibility for errors or omissions in the contents of the Service.</p>
    <p>In no event shall the Company be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever, whether in an action of contract, negligence or other tort, arising out of or in connection with the use of the Service or the contents of the Service. The Company reserves the right to make additions, deletions, or modifications to the contents on the Service at any time without prior notice. This Disclaimer has been created with the help of the <a href="https://www.termsfeed.com/disclaimer-generator/" target="_blank">Disclaimer Generator</a>.</p>
    <p>The Company does not warrant that the Service is free of viruses or other harmful components.</p>
    <h2>External Links Disclaimer</h2>
    <p>The Service may contain links to external websites that are not provided or maintained by or in any way affiliated with the Company.</p>
    <p>Please note that the Company does not guarantee the accuracy, relevance, timeliness, or completeness of any information on these external websites.</p>
    <h2>Errors and Omissions Disclaimer</h2>
    <p>The information given by the Service is for general guidance on matters of interest only. Even if the Company takes every precaution to ensure that the content of the Service is both current and accurate, errors can occur. Plus, given the changing nature of laws, rules and regulations, there may be delays, omissions or inaccuracies in the information contained on the Service.</p>
    <p>The Company is not responsible for any errors or omissions, or for the results obtained from the use of this information.</p>
    <h2>Fair Use Disclaimer</h2>
    <p>The Company may use copyrighted material which has not always been specifically authorized by the copyright owner. The Company is making such material available for criticism, comment, news reporting, teaching, scholarship, or research.</p>
    <p>The Company believes this constitutes a "fair use" of any such copyrighted material as provided for in section 107 of the United States Copyright law.</p>
    <p>If You wish to use copyrighted material from the Service for your own purposes that go beyond fair use, You must obtain permission from the copyright owner.</p>
    <h2>Views Expressed Disclaimer</h2>
    <p>The Service may contain views and opinions which are those of the authors and do not necessarily reflect the official policy or position of any other author, agency, organization, employer or company, including the Company.</p>
    <p>Comments published by users are their sole responsibility and the users will take full responsibility, liability and blame for any libel or litigation that results from something written in or as a direct result of something written in a comment. The Company is not liable for any comment published by users and reserves the right to delete any comment for any reason whatsoever.</p>
    <h2>No Responsibility Disclaimer</h2>
    <p>The information on the Service is provided with the understanding that the Company is not herein engaged in rendering legal, accounting, tax, or other professional advice and services. As such, it should not be used as a substitute for consultation with professional accounting, tax, legal or other competent advisers.</p>
    <p>In no event shall the Company or its suppliers be liable for any special, incidental, indirect, or consequential damages whatsoever arising out of or in connection with your access or use or inability to access or use the Service.</p>
    <h2>"Use at Your Own Risk" Disclaimer</h2>
    <p>All information in the Service is provided "as is", with no guarantee of completeness, accuracy, timeliness or of the results obtained from the use of this information, and without warranty of any kind, express or implied, including, but not limited to warranties of performance, merchantability and fitness for a particular purpose.</p>
    <p>The Company will not be liable to You or anyone else for any decision made or action taken in reliance on the information given by the Service or for any consequential, special or similar damages, even if advised of the possibility of such damages.</p>
    <h2>Contact Us</h2>
    <p>If you have any questions about this Disclaimer, You can contact Us:</p>
    <ul>
      <li><p>By email: <a href="/cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="7002151e04111c181f1d151415031b30171d11191c5e131f1d">[email&#160;protected]</a></p></li>
      <li><p>By visiting this page on our website: <a href="http://da.unaux.com" rel="external nofollow noopener" target="_blank">http://da.unaux.com</a></p></li>
    </ul>
    """; // Add disclaimer HTML content

    return Scaffold(
      appBar: buildAppBar(context, 'Disclaimer', toggleTheme, isDarkTheme), // Inherited AppBar with theme toggle
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Html(
          data: disclaimerHtml, // Pass the HTML content here
        ),
      ),
    );
  }
}
