const ssrl = require('./index');
const scripture = process.argv[2].replace(/[\n\t\r]/g, '');
    
console.log(JSON.stringify(ssrl.parse(scripture), null, 2));
