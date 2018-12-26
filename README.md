# ssrl
structured scripture reference language.  turns strings of bible scriptures to json by parsing them.

I was curious what this would look like as a full on structured language.  Curiosity lead me here.

## .parse(string)

Input a string, get an array of references in json of that string.  Separate them by semicolon.

example:
```js
const ssrl = require('ssrl');
const json = ssrl.parse('Gen 3:16');
console.log(json);

/*
output [{ book: 'Gen', chapters: [{ chapter: 3, verses: [{ verse: 16 }] }] }]
*/
```

## Features
* Chapter - "Gen 3"
* Chapters - "Gen 3,5"
* Chapter ranges - "Gen 3-5"
* Verse - "Gen 3:16"
* Verses - "Gen 3:16,18"
* Verse ranges - "Gen 3:16-18"
* Repeating references - "Gen 3:16-18; Rev 21:3,4" (note: repeat without limit)
* Different use case? Find bugs and open issues!

## json structures
* `json` - `reference[]`
* `reference` - `{ book: string, chapters: (chapterRange | chapter)[] }`
* `chapterRange` - `{ start: chapter, end: chapter }`
* `chapter` - `{ chapter: number, verses: (verseRange | verse)[] }`
* `verseRange` - `{ start: verse, end: verse }`
* `verse` - `{ verse: number }`

## More examples?
[](test.js)
