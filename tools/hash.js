const { pbkdf2Sync, randomBytes } = require('crypto');
const pwd = process.argv[2];
if (!pwd) { console.error('Usage: node tools/hash.js <password>'); process.exit(1); }
const salt = randomBytes(16);
const hash = pbkdf2Sync(pwd, salt, 100000, 32, 'sha256');
console.log(`${salt.toString('hex')}:${hash.toString('hex')}`);
