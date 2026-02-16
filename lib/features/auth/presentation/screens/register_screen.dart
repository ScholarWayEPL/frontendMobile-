import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/register/shared_widgets.dart';
import 'register_steps/academic_background_step.dart';
import 'register_steps/budget_simulation_step.dart';
import 'register_steps/career_objectives_step.dart';
import 'register_steps/review_step.dart';

/// Écran principal d'inscription multi-étapes.
///
/// Gère la navigation entre les 3 étapes :
/// 1. Parcours Académique
/// 2. Budget Simulation
/// 3. Objectifs de Carrière
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _totalSteps = 4;
  int _currentStep = 1;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      _goToStep(_currentStep + 1);
    } else {
      _onComplete();
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      _goToStep(_currentStep - 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onComplete() {
    // TODO: Soumettre les données d'inscription
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: Column(
        children: [
          // En-tête avec indicateur de progression
          StepAppBar(
            currentStep: _currentStep,
            totalSteps: _totalSteps,
            onBack: _previousStep,
          ),

          // Contenu des étapes
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AcademicBackgroundStep(
                  onNext: _nextStep,
                  onSave: () {
                    // TODO: Sauvegarder le brouillon
                  },
                ),
                BudgetSimulationStep(
                  onNext: _nextStep,
                  onBack: _previousStep,
                ),
                CareerObjectivesStep(
                  onNext: _nextStep,
                  onBack: _previousStep,
                ),
                ReviewStep(
                  onNext: _onComplete,
                  onBack: _previousStep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
