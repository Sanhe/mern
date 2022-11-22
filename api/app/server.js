'use strict';

const dotenv = require('dotenv');
const http = require('http');

dotenv.config({ path: './.env' });

const port = process.env.PORT;
const host = process.env.HOST;

const server = http.createServer((req, res) => {
    res.end('Hello from the server');
});

server.listen(port, host, () => {
    console.log(`Listening to request on ${host}:${port}`);
});
