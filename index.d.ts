interface Reference {
  book: string;
  chapters: (Chapter | ChapterRange)[];
}

interface ChapterRange {
  start: Chapter;
  end: Chapter;
}

interface Chapter {
  chapter: number;
  verses: (Verse | VerseRange)[];
}

interface VerseRange {
  start: Verse;
  end: Verse;
}

interface Verse {
  verse: number;
}

export function parse(value: string): Reference[];
