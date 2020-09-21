import 'question.dart';

/// The built in questions about physics, space, technology and biology.
/// Physics, chemistry and space.
final List<Question> physicsQuestions = [
  Question(
      'The wavelength of red light is shorter than that of blue light.', false),
  Question('Helium gives off a pungent odor.', false,
      explanation: 'Helium has no smell at all.'),
  Question(
      'If you went into space without a spacesuit on, you\'d explode.', false),
  Question(
      'It takes 170,000 YEARS, on average, for a photon to travel from the centre of the sun to its surface.',
      true),
  Question('Silver is the most conductive of metals.', true,
      explanation: 'Silver conducts electricity better than copper or gold.'),
  Question('Light travels faster than sound.', true,
      explanation:
          'Light covers about 300,000 km each second, sound only about 343 m.'),
  Question('Water boils at 90 degrees Celsius at sea level.', false,
      explanation: 'Water boils at 100 degrees Celsius at sea level.'),
  Question('Jupiter is the largest planet in the solar system.', true),
  Question('Sound can travel through empty space.', false,
      explanation: 'Sound needs a medium such as air or water to travel.'),
];

/// The human body, animals and plants.
final List<Question> biologyQuestions = [
  Question('Approximately one quarter of human bones are in the feet.', true),
  Question('A slug\'s blood is green.', true,
      explanation: 'Slugs have a copper based blood pigment that looks green.'),
  Question(
      'The small intestine is about three-and-a-half times the length of your body.',
      true),
  Question(
      'Bananas are curved because they grow upwards towards the sun.', true),
  Question(
      'The total surface area of two human lungs is approximately 70 square metres.',
      true),
  Question(
      'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      true),
  Question('Humans have four lungs.', false,
      explanation: 'People have two lungs, a left and a right one.'),
  Question('The heart pumps blood through the whole body.', true),
  Question('Plants release oxygen during photosynthesis.', true),
  Question('An adult human has 206 bones.', true),
];

/// Computers and the web.
final List<Question> technologyQuestions = [
  Question(
      'Microsoft and Apple are two examples of how open-source companies can become global leaders in their industries.',
      false),
  Question(
      'In an era of steadily rising costs, computing costs have been decreasing dramatically because of the rapid developments in both hardware and software technology.',
      true),
  Question('Google was originally called "Backrub".', true,
      explanation:
          'The search engine started as the Backrub project at Stanford.'),
  Question('HTML is a programming language.', false,
      explanation:
          'HTML is a markup language that describes the structure of a page.'),
  Question('One kilobyte is 1024 bytes in the binary system.', true),
  Question('The first computer mouse was made of wood.', true,
      explanation: 'Douglas Engelbart built it in 1964 with a wooden shell.'),
];

/// Every built in question: physics first, then biology and technology.
final List<Question> defaultQuestions = [
  ...physicsQuestions,
  ...biologyQuestions,
  ...technologyQuestions,
];
