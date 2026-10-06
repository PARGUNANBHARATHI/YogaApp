//----------------------------------------------------------
// IRAI OPTION MODEL
//----------------------------------------------------------
//
// Represents one selectable option inside an IRAI
// interaction.
//
// FUTURE READY:
// - Personal Discovery questions
// - Body/Mind assessment
// - Daily check-ins
// - AI-generated questions
// - Firebase questions
// - Personalized recommendations
//
// The UI will not contain the actual question data.
// It will receive IraiOption objects.
//
//----------------------------------------------------------

class IraiOption {
  final String id;

  final String title;

  final String? subtitle;

  final String? emoji;

  const IraiOption({
    required this.id,
    required this.title,
    this.subtitle,
    this.emoji,
  });
}