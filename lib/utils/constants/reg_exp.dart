class RegExpressions {
  static final audienceExp = RegExp(
      r"LMS(-[0-9]| |$)"
      r"|[А-Я]-[0-9]{3}[а-я]?"
      r"|АКТРУ"
      r"|Teams"
  );
  static final lectorExp = RegExp(
      r"(?:[1-9]\s*п\/г\s*)?"
      r"(?:[А-ЯЁA-Zа-яёa-z]+)"
      r"\s[А-ЯЁA-Zа-яёa-z]\."
      r"\s*[А-ЯЁA-Zа-яёa-z]\."
      r"|[А-ЯЁA-Zа-яёa-z]\."
      r"\s*[А-ЯЁA-Zа-яёa-z]\."
      r"\s(?:[А-ЯЁA-Z][а-яёa-z]+)"
      r"(?:\s*[1-9]\s*п\/г)?"
  );
  static final groupExp = RegExp(
      r"КТ[бмас][озв]\d-\d\d?"
      r"|ВПК \d\d?-\d\d?(.\d)?"
      r"|\d{2}[А-ЯЁа-яё]{2}-\d{2}\.\d{2}\.\d{2}\.\d{2}-[а-о]\d"
      r"|Группа\d"
  );
}