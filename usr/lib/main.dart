import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Law Internship Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A365D), // Professional Navy Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia', // Serif font for a legal/professional look
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class SlideData {
  final String title;
  final List<String> bulletPoints;
  final IconData icon;

  SlideData({
    required this.title,
    required this.bulletPoints,
    required this.icon,
  });
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isDownloading = false;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Internship Experience at Sessions Court',
      bulletPoints: [
        'A Comprehensive Overview of Legal Practice',
        'Presented by: Law Intern',
        'Focus: Criminal Justice System & Court Procedures',
      ],
      icon: Icons.account_balance,
    ),
    SlideData(
      title: '1. Introduction to Sessions Court',
      bulletPoints: [
        'Highest criminal court in a district.',
        'Presided over by a District & Sessions Judge.',
        'Deals with severe criminal offenses (e.g., murder, theft, rape).',
        'Has the power to impose any sentence authorized by law, including the death penalty (subject to High Court confirmation).',
      ],
      icon: Icons.gavel,
    ),
    SlideData(
      title: '2. Objectives of the Internship',
      bulletPoints: [
        'Bridge the gap between theoretical knowledge and practical application.',
        'Understand the procedural aspects of CrPC, IPC, and the Evidence Act.',
        'Observe the day-to-day functioning of the criminal justice system.',
        'Learn court etiquette and professional conduct.',
      ],
      icon: Icons.track_changes,
    ),
    SlideData(
      title: '3. Daily Roles & Responsibilities',
      bulletPoints: [
        'Attending court proceedings and taking detailed notes.',
        'Assisting senior advocates in organizing case files.',
        'Conducting legal research on precedents and case laws.',
        'Retrieving documents and tracking case statuses in the court registry.',
      ],
      icon: Icons.assignment,
    ),
    SlideData(
      title: '4. Observation of Court Proceedings',
      bulletPoints: [
        'Witnessed various stages of a criminal trial.',
        'Observed framing of charges and recording of statements (Sec 313 CrPC).',
        'Watched Chief Examination and Cross-Examination of witnesses.',
        'Listened to final arguments presented by the Prosecution and Defense.',
      ],
      icon: Icons.visibility,
    ),
    SlideData(
      title: '5. Case File Study & Drafting',
      bulletPoints: [
        'Analyzed First Information Reports (FIRs) and Police Charge Sheets.',
        'Studied post-mortem reports and forensic evidence documents.',
        'Assisted in drafting Bail Applications (Regular and Anticipatory).',
        'Learned the structure of drafting criminal miscellaneous petitions.',
      ],
      icon: Icons.edit_document,
    ),
    SlideData(
      title: '6. Understanding Bail Hearings',
      bulletPoints: [
        'Observed the critical factors judges consider for granting bail.',
        'Analyzed arguments regarding flight risk and tampering with evidence.',
        'Learned the difference between bailable and non-bailable offenses in practice.',
        'Noted the importance of surety and personal bonds.',
      ],
      icon: Icons.balance,
    ),
    SlideData(
      title: '7. Interaction with Clients & Advocates',
      bulletPoints: [
        'Observed client counseling sessions with senior advocates.',
        'Learned how to extract relevant facts from clients in distress.',
        'Understood the importance of attorney-client privilege.',
        'Witnessed negotiations and discussions with public prosecutors.',
      ],
      icon: Icons.people,
    ),
    SlideData(
      title: '8. Key Learnings & Skills Acquired',
      bulletPoints: [
        'Enhanced legal research and analytical skills.',
        'Improved understanding of the Indian Evidence Act in real scenarios.',
        'Developed patience and resilience in a high-pressure environment.',
        'Mastered the art of reading complex legal documents quickly.',
      ],
      icon: Icons.lightbulb,
    ),
    SlideData(
      title: '9. Challenges Faced',
      bulletPoints: [
        'Adapting to the fast-paced and often chaotic court environment.',
        'Understanding complex legal jargon and regional court language.',
        'Managing the emotional toll of dealing with severe criminal cases.',
        'Navigating the administrative bureaucracy of the court registry.',
      ],
      icon: Icons.warning,
    ),
    SlideData(
      title: '10. Conclusion & Future Outlook',
      bulletPoints: [
        'The internship provided invaluable practical exposure to criminal law.',
        'Solidified the desire to pursue a career in litigation.',
        'Highlighted the importance of ethics and dedication in the legal profession.',
        'Thank you to the presiding officers, senior advocates, and court staff.',
      ],
      icon: Icons.school,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _downloadPresentation() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final pdf = pw.Document();

      for (int i = 0; i < _slides.length; i++) {
        final slide = _slides[i];
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.presentation,
            build: (pw.Context context) {
              return pw.Container(
                padding: const pw.EdgeInsets.all(40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      slide.title,
                      style: pw.TextStyle(
                        fontSize: i == 0 ? 48 : 36,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue900,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Divider(thickness: 2, color: PdfColors.grey400),
                    pw.SizedBox(height: 30),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: slide.bulletPoints.map((point) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 20),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(top: 10, right: 16),
                                  width: 10,
                                  height: 10,
                                  decoration: const pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: PdfColors.blueGrey,
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    point,
                                    style: pw.TextStyle(
                                      fontSize: i == 0 ? 28 : 24,
                                      lineSpacing: 5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // Footer
                    pw.Align(
                      alignment: pw.Alignment.bottomRight,
                      child: pw.Text(
                        'Slide ${i + 1} of ${_slides.length}',
                        style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }

      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'Sessions_Court_Internship_Presentation.pdf',
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Presentation Viewer'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Slide ${_currentPage + 1} of ${_slides.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (_isDownloading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.download),
              tooltip: 'Download Presentation (PDF)',
              onPressed: _downloadPresentation,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _slides[index].icon,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      _slides[index].title,
                                      style: TextStyle(
                                        fontSize: index == 0 ? 36 : 32,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 40, thickness: 2),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _slides[index].bulletPoints.length,
                                  itemBuilder: (context, bulletIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              _slides[index].bulletPoints[bulletIndex],
                                              style: TextStyle(
                                                fontSize: index == 0 ? 24 : 22,
                                                height: 1.5,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                const SizedBox(width: 40),
                Row(
                  children: List.generate(
                    _slides.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton.icon(
                  onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
