const assert = require('assert');
const bici = require('./index');

assert.deepEqual(bici.parse('Gen 3:16'), [{ book: 'Gen', chapters: [{ chapter: 3, verses: [{ verse: 16 }] }] }]);
assert.deepEqual(bici.parse('ec 7:16'), [{ book: 'ec', chapters: [{chapter: 7, verses: [{ verse: 16 }] }]}]);
assert.deepEqual(bici.parse('Exodus 14:23,'), [{ book: 'Exodus', chapters: [{ chapter: 14, verses: [{ verse: 23 }] }] }]);
assert.deepEqual(bici.parse('Exodus 14:23, 26'), [{ book: 'Exodus', chapters: [{ chapter: 14, verses: [{ verse: 23 }, { verse: 26 }] }] }]);
assert.deepEqual(bici.parse('Exodus 14:23, 26-'), [{ book: 'Exodus', chapters: [{ chapter: 14, verses: [{ verse: 23 }, { verse: 26 }] }] }]);
assert.deepEqual(bici.parse('Exodus 14:23, 26-30'), [{ book: 'Exodus', chapters: [{ chapter: 14, verses: [{ verse: 23 }, { start: 26, end: 30}] }] }]);
assert.deepEqual(bici.parse('ec 7:16; Exodus 14:23;'), [{ book: 'ec', chapters: [{ chapter: 7, verses: [{ verse: 16}] }] }, { book: "Exodus", chapters: [{ chapter: 14, verses: [{ verse: 23 }] }] }]);
assert.deepEqual(bici.parse('Gen. 2:15-17, 19, 20'), [{ book: 'Gen.', chapters: [{ chapter: 2, verses: [{ start: 15, end: 17}, { verse: 19 }, { verse: 20 }] }] }]);
assert.deepEqual(bici.parse('Gen. 1'),[{ book: 'Gen.', chapters: [{ chapter: 1 }] }]);
assert.deepEqual(bici.parse('Gen. 1-'),[{ book: 'Gen.', chapters: [{ chapter: 1 }] }]);
assert.deepEqual(bici.parse('Gen. 1-2'),[{ book: 'Gen.', chapters: [{ start: 1, end: 2 }] }]);
assert.deepEqual(bici.parse('Gen. 1-2, 5'),[{ book: 'Gen.', chapters: [{ start: 1, end: 2 }, { chapter: 5 }] }]);
assert.deepEqual(bici.parse('Gen 1, 2:4'), [{ book: 'Gen', chapters: [{ chapter: 1 }, { chapter: 2, verses: [{ verse: 4 }] }] }]);
assert.deepEqual(bici.parse('Gen 1:2, 2:4'), [{ book: 'Gen', chapters: [{ chapter: 1, verses: [{ verse: 2 }] }, { chapter: 2, verses: [{ verse: 4 }] }] }]);
assert.deepEqual(bici.parse('2 Timothy 1:2, 2:4'), [{ book: '2 Timothy', chapters: [{ chapter: 1, verses: [{ verse: 2 }] }, { chapter: 2, verses: [{ verse: 4 }] }] }]);

function print(v) {
    console.log(JSON.stringify(bici.parse(v), null, 2));
}