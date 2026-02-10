String normalizeForTts(String text) {
  // Taling (e`) -> "eh" to bias pronunciation toward /e/ (as in "lele").
  // Pepet (e') -> "e".
  return text
      .replaceAll('e`', 'eh')
      .replaceAll("e'", 'e')
      .replaceAll('`', '')
      .replaceAll("'", '');
}
