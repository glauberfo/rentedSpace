import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/company_logo_widget.dart';
import 'login_screen.dart';

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({super.key});

  @override
  State<OnboardingCarouselScreen> createState() => _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: 'logo',
      title: 'Bem-vindo à Iluminarte!',
      description: 'Descubra o mundo encantado da Iluminarte!\nReserve oficinas, encontre novas atividades e viva momentos de arte, aprendizado e afeto para as crianças e famílias — tudo em poucos cliques.\n✨ Toque para conhecer e se apaixonar.',
      gradient: AppTheme.slideWelcomeGradient,
    ),
    OnboardingSlide(
      icon: '🎨',
      title: 'Explore Aulas',
      description: 'Descubra uma variedade de aulas infantis: pintura, culinária, dança, natação e muito mais!',
      gradient: AppTheme.slide1Gradient,
    ),
    OnboardingSlide(
      icon: '❤️',
      title: 'Instrutores Qualificados',
      description: 'Conheça educadores apaixonados por ensinar com arte, afeto e aprendizado.',
      gradient: AppTheme.slide2Gradient,
    ),
    OnboardingSlide(
      icon: '⭐',
      title: 'Reserve com Facilidade',
      description: 'Escolha a aula perfeita, veja horários disponíveis e reserve em segundos!',
      gradient: AppTheme.slide3Gradient,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

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

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          final slide = _slides[index];
          return _buildSlide(slide, index);
        },
      ),
    );
  }

  Widget _buildSlide(OnboardingSlide slide, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: slide.gradient,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Ícone/Logo
              _buildIcon(slide.icon),
              const SizedBox(height: 32),
              
              // Título
              FadeTransition(
                opacity: _fadeController,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _fadeController,
                    curve: Curves.easeOut,
                  )),
                  child: Text(
                    slide.title,
                    style: AppTheme.carouselTitleStyle(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Descrição
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - value)),
                      child: Text(
                        slide.description,
                        style: AppTheme.carouselDescriptionStyle(context),
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 52),
              
              // Botões
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - value)),
                      child: _buildButtons(index),
                    ),
                  );
                },
              ),
              const Spacer(),
              
              // Indicadores
              _buildDots(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String icon) {
    if (icon == 'logo') {
      return const CompanyLogoWidget(size: 140);
    }
    return Text(
      icon,
      style: const TextStyle(fontSize: 100),
    );
  }

  Widget _buildButtons(int index) {
    if (index < _slides.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSecondaryButton(
            'Pular Introdução',
            onPressed: _skipToLogin,
          ),
          const SizedBox(width: 16),
          _buildPrimaryButton(
            'Próximo →',
            onPressed: _nextPage,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSecondaryButton(
            '← Anterior',
            onPressed: _previousPage,
          ),
          const SizedBox(width: 16),
          _buildPrimaryButton(
            'Começar Agora',
            onPressed: _skipToLogin,
          ),
        ],
      );
    }
  }

  Widget _buildPrimaryButton(String text, {required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Text(
              text,
              style: AppTheme.buttonTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, {required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppTheme.darkGray.withOpacity(0.25),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Text(
              text,
              style: AppTheme.buttonTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          _slides.length,
          (index) => GestureDetector(
            onTap: () => _goToPage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 7),
              width: _currentPage == index ? 12 : 10,
              height: _currentPage == index ? 12 : 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.6),
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 2,
                ),
                boxShadow: _currentPage == index
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingSlide {
  final String icon;
  final String title;
  final String description;
  final LinearGradient gradient;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}

