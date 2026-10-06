//----------------------------------------------------------
// IRAI ANSWER MODEL
//----------------------------------------------------------
//
// Represents one answer given by the user.
//
// An answer can come from:
// • Card
// • Text
// • Voice
//
// CURRENT:
// Used only locally.
//
// FUTURE:
// This same model can be saved to Firebase.
//
//----------------------------------------------------------

enum IraiAnswerType {
  card,
  text,
  voice,
}

class IraiAnswer {
  final String id;

  final String interactionId;

  final IraiAnswerType type;

  final String value;

  final DateTime createdAt;

  const IraiAnswer({
    required this.id,
    required this.interactionId,
    required this.type,
    required this.value,
    required this.createdAt,
  });
}